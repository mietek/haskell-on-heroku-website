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

_Haskell on Heroku_ uses prebuilt packages to speed up deployment.

Please be mindful of the many meanings of the term _package_.  In this documentation, the term _package_ always means _prebuilt package_, and refers to one of the four following types of entities:

1.  _GHC packages_, which contain a live installation of GHC, including the default global GHC database. The user GHC database is always empty.

2.  _Cabal packages_, in two flavours:

    -   _Non-updated Cabal packages_, containing only the `cabal-install` executable and configuration file.
    
    -   _Updated Cabal packages_, containing also an updated Cabal database.

3.  _Sandbox packages_, which contain a live sandbox, including all dependencies required to compile a specific app.

4.  _App packages_, which contain a live app, including all intermediate files in its `dist` directory.

All packages include a `tag` file in their top-level directory, declaring the contents of the package.


### Naming

All packages are archived following a consistent naming scheme:

1.  GHC packages:\
    `halcyon-ghc-`_`version`_`.tar.xz`

2.  Cabal packages:

    -   Non-updated Cabal packages:\
        `halcyon-cabal-`_`version`_`.tar.xz`
    
    -   Updated Cabal packages:\
        `halcyon-cabal-`_`version`_`-`_`timestamp`_`.tar.xz`

3.  Sandbox packages:\
    `halcyon-sandbox-`_`ghc_version`_`-`_`app_name`_`-`_`app_version`_`-`_`digest`_`.tar.gz`

    Sandbox configuration files are also stored separately:\
    `halcyon-sandbox-`_`ghc_version`_`-`_`app_name`_`-`_`app_version`_`-`_`digest`_`.cabal.config`

4.  App packages:\
    `halcyon-app-`_`ghc_version`_`-`_`app-name`_`-`_`app_version`_`.tar.gz`


### Rationale

Separating the dependencies required to compile any app into four types is an attempt at striking a balance between the time spent compiling and the space occupied by compilation products.  This design allows for mixing-and-matching GHC and Cabal versions, updating the Cabal database incrementally or from scratch, and extending sandboxes based on existing sandboxes.

Each type of package is expected to vary at a different rate—from never-changing GHC packages, to app packages which change on every deployment.


S3 buckets
----------

_Haskell on Heroku_ is intended to be used with a private Amazon S3 bucket, defined by the [`HALCYON_S3_BUCKET`](documentation/reference/#halcyon_s3_bucket) configuration variable.

All packages required to compile an app are downloaded from the bucket.  If any required packages are not found, compilation will not succeed, and an app-less slug will be deployed.  This allows prebuilding packages on an one-off dyno.

Any prebuilt packages are archived and uploaded to the bucket.  All uploaded files are assigned an [S3 ACL](http://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html), defined by [`HALCYON_S3_ACL`](documentation/reference/#halcyon_s3_acl), which defaults to `private`.

Access to the bucket is controlled by setting [`HALCYON_AWS_ACCESS_KEY_ID`](documentation/reference/#halcyon_aws_access_key) and [`HALCYON_AWS_SECRET_ACCESS_KEY`](documentation/reference/#halcyon_aws_secret_access_key).


### Public packages

For the purposes of getting started quickly, it is also possible to use [public packages](http://s3.halcyon.sh/), by not defining a private bucket.  This is not recommended for production usage, as the set of available public packages may change at any time.

Additionally, as public packages cannot satisfy all dependencies required to compile every app, some apps will not compile successfully unless a private bucket is defined.

If a private bucket is defined, public packages are never used.  This helps maintain complete control over the deployed code.


### Rationale

A private bucket is necessary because of the separation between the dynos used for compiling apps and the one-off dynos used for prebuilding packages.

Compile dynos keep packages in the Heroku compile cache, but prebuild dynos are not allowed to access the cache.  Some form of external storage must be used to transfer the packages between dynos, and an Amazon S3 bucket is a good solution to this problem.

While _Haskell on Heroku_ is designed to make prebuilding packages on one-off dynos as easy as possible, packages can also be prebuilt on any machine with a compatible architecture and OS.  Please refer to the [_Halcyon_ documentation](http://halcyon.sh/documentation/) for details.

Storing packages externally also allows unrelated apps to share common dependencies.  Sharing the same private bucket between multiple apps requires no additional configuration beyond defining the same bucket for every app.  This is how public packages are made available.




Caching
-------

_Haskell on Heroku_ downloads all files to the Heroku compile cache, which is automatically cleaned after every installation, retaining only the most recently used packages.

Deleting the contents of the cache before installation can be requested by setting the [`HALCYON_PURGE_CACHE`](documentation/reference/#halcyon_purge_cache) configuration variable to `1`.  This is equivalent to using the [`purge_cache`](https://github.com/heroku/heroku-repo#purge_cache) command from the [`heroku-repo`](https://github.com/heroku/heroku-repo/) plugin, but more efficient.

Remember to unset the variable before redeploying.




---

_To be continued._
