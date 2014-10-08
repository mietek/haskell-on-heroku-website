---
title: Documentation
page-class: add-section-toc
page-data:
  - key: max-section-toc-level
    value: 1
page-head: |
  <style>
    header a.link-documentation {
      color: #ac5cf0;
    }
  </style>
---


Documentation
=============

_Haskell on Heroku_ user guide.

Detailed technical information is available in the [_Haskell on Heroku_ reference](documentation/reference/).

Work in progress.  Please report any problems with the documentation on the [_haskell-on-heroku-website_ issue tracker](https://github.com/mietek/haskell-on-heroku-website/issues/).

> Contents:




Packages
--------

_Haskell on Heroku_ is designed to allow mixing-and-matching GHC and Cabal versions, updating the Cabal database incrementally or from scratch, and building new sandboxes based on existing sandboxes.

Apps deploy in the time required to compile the pushed changes.  There is no unnecessary recompiling or relinking.  Only the minimum is stored in the Heroku cache.  The resulting slugs are small, as they do not include the compilation environment—which can be restored in seconds, should the user wish to interact with the deployed app using GHCi.

All of this is made possible by using [_Halcyon_](http://halcyon.sh/) prebuilt packages.


### Package types

Please be mindful of the many meanings of the term _package_.  In this documentation, the term _package_ always refers to one of the four following types of entities:

1.  _GHC packages_, which contain a live installation of GHC, archived to:\
    `halcyon-ghc-`_`ghcVersion`_`.tar.xz`

2.  _Cabal packages_, in two flavours:

    -   _Non-updated Cabal packages_, containing only the `cabal-install` executable and configuration file, archived to:\
        `halcyon-cabal-`_`cabalVersion`_`.tar.xz`
    
    -   _Updated Cabal packages_, containing also an updated Cabal database, archived to:\
        `halcyon-cabal-`_`cabalVersion`_`-`_`updateTimestamp`_`.tar.xz`

3.  _Sandbox packages_, which contain a live sandbox, including all dependencies required to compile a specific app, archived to:\
    `halcyon-sandbox-`_`ghcVersion`_`-`_`appName`_`-`_`appVersion`_-_`sandboxDigest`_`.tar.gz`

4.  _App packages_, which contain a live app executable, including all intermediate build results in its `dist` directory, archived to:\
    `halcyon-app-`_`ghcVersion`_`-`_`appName`_`-`_`appVersion`_`.tar.gz`

All packages include a `tag` file in their top-level directory, declaring the type and contents of the package, including the identifier of the targeted OS.


### Sandbox packages

Every sandbox package includes a `cabal.config` file, which declares the names and version numbers of all included dependencies.  A SHA–1 digest of this file is embedded in the name of the package.  This allows efficiently locating a sandbox which perfectly matches all required dependencies—by scanning a list of file names.

A copy of the `cabal.config` file is also kept next of the archived sandbox package:\
`halcyon-sandbox-`_`ghcVersion`_`-`_`appName`_`-`_`appVersion`_-_`sandboxDigest`_`.cabal.config`

If a perfect match for the required dependencies cannot be located, each available configuration file is scanned and scored.  Sandboxes containing any extraneous dependencies are ignored.  The sandbox with the best score is selected a base for building a new, perfectly matched sandbox.


### Rationale

Separating the dependencies required to compile an app into four types is an attempt at striking an optimum between the time spent compiling code, archiving compilation results, and transferring archives.  For example, as GHC packages are expected not to change often, they are archived to `.tar.xz` files, while `.tar.gz` is used for app packages, which change on every deploy.

The sandbox scoring process accepts only sandboxes which include a strict subset of the required dependencies.  This ensures every sandbox built contains the minimum necessary amount of data.




Building packages
-----------------

_Haskell on Heroku_ is intended to be used with a private Amazon S3 bucket, defined by the [`HALCYON_S3_BUCKET`](documentation/reference/#halcyon_s3_bucket) configuration variable.

All packages required for compilation are downloaded from the bucket.  If a required package is not found while attempting to deploy an app, compilation will fail—but deployment will succeed!

The deployed slug will only contain _Haskell on Heroku_.  This allows building the missing packages on a one-off dyno:
```
$ heroku run --size=PX build
```

It is important to specify a PX-sized dyno, as it offers 6GB of RAM, and compiling Haskell requires large amounts of memory.

The newly built packages will perfectly match all required dependencies, allowing subsequent compilation to succeed.  Pushing an empty commit is the simplest way to deploy again:
```
$ git commit --allow-empty --allow-empty-message -m ''
$ git push heroku master
```

All built packages are archived and uploaded to the bucket, under an OS-specific prefix.  All uploaded files are assigned an [S3 ACL](http://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html), defined by [`HALCYON_S3_ACL`](documentation/reference/#halcyon_s3_acl), which defaults to `private`.

Access to the bucket is controlled by setting [`HALCYON_AWS_ACCESS_KEY_ID`](documentation/reference/#halcyon_aws_access_key) and [`HALCYON_AWS_SECRET_ACCESS_KEY`](documentation/reference/#halcyon_aws_secret_access_key).


### Public packages

For the purposes of getting started quickly, it is also possible to use [public packages](http://s3.halcyon.sh/), by not defining a private bucket.  This is not recommended for production usage, as the set of available public packages may change at any time.

Additionally, as public packages cannot match all dependencies required to compile every app, some apps will not compile successfully unless a private bucket is defined.

If a private bucket is defined, public packages are never used.  This helps maintain complete control over the deployed code.


### Rationale

A private bucket is necessary because of the separation between the dynos used for compiling apps and the one-off dynos used for building packages.

Compile dynos keep packages in the Heroku compile cache, but one-off dynos are not allowed to access the cache.  Some form of external storage must be used to transfer the packages between dynos, and an Amazon S3 bucket is a good solution to this problem.

Building packages on-the-fly during deployment is not practical on Heroku, because compile dynos are always 1X-sized.  The standard 512MB of RAM offered by a 1X-sized dyno is not sufficient to compile any Haskell web framework.  Running out of memory will not stop deployment—instead, the dyno will slowly grind to a halt, swapping data in and out of RAM, until the 15-minut Heroku compile time limit puts it out of its misery.

While _Haskell on Heroku_ is designed to make building packages on one-off dynos as easy as possible, packages can also be built on any machine with an architecture and OS matching the specifications of the targeted Heroku stack.  Please refer to the [_Halcyon_ documentation](http://halcyon.sh/documentation/) for details.

Storing packages externally also allows unrelated apps to share common dependencies.  Sharing the same private bucket between multiple apps requires no additional configuration beyond defining the same bucket for every app.  This is how public packages are made available.


### Special considerations

If the time required to compile the pushed changes is greater than the 15-minute Heroku compile time limit, it may be worth considering to split off part of the app into a library, allowing the library to be declared as a dependency and included in a sandbox package.  As an interim measure, it is also possible to force deployment to succeed before attempting to compile the app, by setting [`HALCYON_DEPENDENCIES_ONLY`](documentation/reference/#halcyon_dependencies_only) to `1`.  This will allow building the app on a one-off dyno, as described above.




Caching packages
----------------

_Haskell on Heroku_ downloads all packages to the Heroku compile cache.  The cache is automatically cleaned after every deployment, retaining only the most recently used packages.

Deleting the contents of the cache before deployment can be requested by setting the [`HALCYON_PURGE_CACHE`](documentation/reference/#halcyon_purge_cache) configuration variable to `1`.  This is equivalent to using the [`purge_cache`](https://github.com/heroku/heroku-repo#purge_cache) command from the [`heroku-repo`](https://github.com/heroku/heroku-repo/) plugin, but more efficient.

Please note the variable needs to be manually unset after deployment.




---

_To be continued…_
