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

_Haskell on Heroku_ is a buildpack for rapid deployment of Haskell web apps to Heroku, designed to be fast, efficient, and flexible.

Apps are expected to deploy in the time required to compile the pushed changes.  There is no unnecessary recompiling or relinking.  Only the minimum is stored in the Heroku cache.  The resulting slugs are small, as they do not include the compilation environment—which can be restored in seconds, should the user wish to interact with the deployed app using GHCi.

All of this is made possible by using [_Halcyon_](http://halcyon.sh/) prebuilt packages.


### Package tiers

Please be mindful of the many meanings of the term _package_.  In this documentation, the term _package_ always refers to one of the following four tiers of entities:

1.  _GHC packages_, which contain a live installation of GHC, archived to:\
    `halcyon-ghc-`_`ghcVersion`_`.tar.xz`

2.  _Cabal packages_, in two flavours:

    -   _Non-updated Cabal packages_, containing only the `cabal-install` executable and configuration file, archived to:\
        `halcyon-cabal-`_`cabalVersion`_`.tar.xz`
    
    -   _Updated Cabal packages_, containing also an updated Cabal database, archived to:\
        `halcyon-cabal-`_`cabalVersion`_`-`_`updateTimestamp`_`.tar.xz`

3.  _Sandbox packages_, which contain a live sandbox, including all dependencies required to compile a specific app, archived to:\
    `halcyon-sandbox-`_`ghcVersion`_`-`_`appName`_`-`_`appVersion`_-_`sandboxDigest`_`.tar.gz`

4.  _App packages_, which contain a live app executable, including all intermediate build products, archived to:\
    `halcyon-app-`_`ghcVersion`_`-`_`appName`_`-`_`appVersion`_`.tar.gz`

All packages include a `tag` file in their top-level directory, declaring the tier and contents of the package, the identifier of the targeted OS, and the root path of the installation.


### Sandbox packages

Special consideration is due to sandbox packages.  Every sandbox package includes a `cabal.config` file, which declares a set of constraints—the names and version numbers of all included dependencies.  A [SHA–1](http://en.wikipedia.org/wiki/SHA-1) digest of these constraints is embedded in the name of the package.  This allows efficiently locating a sandbox which perfectly matches all required dependencies—by scanning a list of file names.

A copy of the `cabal.config` file is also kept next to the archived sandbox package:\
`halcyon-sandbox-`_`ghcVersion`_`-`_`appName`_`-`_`appVersion`_-_`sandboxDigest`_`.cabal.config`

If a perfectly matched sandbox cannot be located, each available configuration file is scanned and scored.  Files including any extraneous constraints are ignored.  The sandbox containing the best scoring set of constraints is selected as a base, copied, and extended with the missing packages.  The resulting sandbox will match the required dependencies perfectly, without needing to be built from scratch.


### Rationale

Separating the dependencies required to compile an app into four tiers is an attempt at striking a balance between the time spent compiling code, archiving compilation results, and transferring archives over the network. 

The four-tiered design allows mixing-and-matching GHC and Cabal versions, updating the Cabal database incrementally or from scratch, and building new sandboxes based on existing sandboxes.  This flexibility enables aiming for efficiency at every step—for example:

-   The sandbox scoring process accepts only sandboxes which include a strict subset of the required dependencies.  This ensures every sandbox built contains the minimum necessary amount of data.

-   As GHC packages are expected not to change often, they are archived using the slower LZMA algorithm, while the faster <span class="small-caps">Deflate</span> is used for app packages, which change on every deploy.




Building packages
-----------------

_Haskell on Heroku_ is intended to be used with a private Amazon S3 bucket, defined by the [`HALCYON_S3_BUCKET`](documentation/reference/#halcyon_s3_bucket) configuration variable.

All packages required for compilation are downloaded from the private bucket.  If a required package is not found while attempting to deploy an app, compilation will fail—but deployment will succeed!  The deployed slug will contain only _Haskell on Heroku_ itself.  This approach, which may seem counter-intuitive, enables building the missing packages directly on Heroku, without the need to involve any external entities.

The user will be notified whenever compilation fails due to a missing package.  The next step is building the missing packages on a one-off PX-sized dyno:
```
$ heroku run --size=PX build
```

The newly built packages will perfectly match all required dependencies, allowing subsequent compilation to succeed.  Pushing an empty commit is the simplest way to deploy again:
```
$ git commit --allow-empty --allow-empty-message -m ''
$ git push heroku master
```

All built packages are archived and uploaded to the private S3 bucket, prefixed with an appropriate OS identifier.  The original files used for the build are also uploaded to the private bucket, in order to decrease the overall load on upstream servers.  All uploaded files are assigned an [S3 ACL](http://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html), defined by [`HALCYON_S3_ACL`](documentation/reference/#halcyon_s3_acl), which defaults to `private`.

Access to the private bucket is controlled by setting [`HALCYON_AWS_ACCESS_KEY_ID`](documentation/reference/#halcyon_aws_access_key) and [`HALCYON_AWS_SECRET_ACCESS_KEY`](documentation/reference/#halcyon_aws_secret_access_key).


### Public packages

For the purposes of getting started quickly, it is also possible to use [public packages](http://s3.halcyon.sh/), by not defining a private bucket.  This is not recommended for production usage, as the set of available public packages may change at any time.

Additionally, as public packages cannot match all dependencies required to compile every app, and uploading packages is not possible without defining a private bucket, some apps will not compile successfully.

If a private bucket is defined, public packages are never used.  This helps maintain complete control over the deployed code.


### Rationale

A private bucket is necessary because of the separation between the dynos used for compiling apps and the one-off dynos used for building packages.

Compile dynos keep packages in the Heroku compile cache, but access ot the cache is not allowed from one-off dynos.  Some form of external storage must be used to transfer the packages between dynos, and an Amazon S3 bucket is a good solution to this problem.

Building packages on-the-fly during deployment is not practical on Heroku, because apps are always compiled on 1X dynos, which offer 512MB RAM.  This amount of memory is not sufficient to compile most Haskell web frameworks—indeed, compiling some of the more generously-proportioned frameworks requires in excess of 4GB RAM.  Running out of memory will not stop deployment immediately—instead, the dyno will slowly grind to a halt, swapping data in and out of RAM, until the 15-minut Heroku compile time limit puts it out of its misery.  Hence, building packages is best done on PX one-off dynos, which offer 6GB RAM, and where the time limit does not apply.

Storing packages externally also allows unrelated apps to share common dependencies.  Sharing the same private bucket between multiple apps requires no additional configuration beyond defining the same private bucket for every app.  This is the same method by which public packages are made available.

While _Haskell on Heroku_ is designed to make building packages on one-off dynos as easy as possible, packages can also be built on any machine with an architecture and OS matching the specifications of the targeted Heroku stack—currently, Ubuntu 10.04 LTS or 14.04 LTS, both 64-bit.  Please refer to the [_Halcyon_ documentation](http://halcyon.sh/documentation/) for details.


### Special considerations

If the time required to compile the pushed changes is greater than the 15-minute Heroku compile time limit, it may be worth considering to split off part of the app into a library, allowing the library to be declared as a dependency and included in a sandbox package.  As an interim measure, it is also possible to avoid compiling the app during deployment, by setting [`HALCYON_DEPENDENCIES_ONLY`](documentation/reference/#halcyon_dependencies_only) to `1`.  This will allow building the app on a one-off dyno, as described above.




Caching packages
----------------

_Haskell on Heroku_ downloads all packages to the Heroku compile cache.  The cache is automatically cleaned after every deployment, retaining only the most recently used packages.

Deleting the contents of the cache before deployment can be requested by setting the [`HALCYON_PURGE_CACHE`](documentation/reference/#halcyon_purge_cache) configuration variable to `1`.  This is equivalent to using the [`purge_cache`](https://github.com/heroku/heroku-repo#purge_cache) command from the [`heroku-repo`](https://github.com/heroku/heroku-repo/) plugin, but more efficient.  Please note the variable needs to be unset after use.




---

_To be continued…_
