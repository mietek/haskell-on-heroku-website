---
title: Reference
page-class: add-section-toc
page-head: |
  <style>
    header a.link-docs {
      color: #ac5cf0;
    }
  </style>
---


Reference
=========

Haskell on Heroku internal function documentation.

Intended for people interested in developing [Haskell on Heroku](https://github.com/mietek/haskell-on-heroku/).  Best read together with the source code.

Work in progress.

> Contents:




Configuration variables { .vars }
-----------------------

### `HALCYON_AWS_ACCESS_KEY_ID`
> Default value:  _none_

Part of the authentication details used to access the private Amazon S3 bucket.


### `HALCYON_AWS_SECRET_ACCESS_KEY`
> Default value:  _none_

Like [`HALCYON_AWS_ACCESS_KEY_ID`](#halcyon_aws_access_key_id), but secret.


### `HALCYON_S3_BUCKET`
> Default value:  _none_

Name of the private Amazon S3 bucket used to keep prebuilt packages.


### `HALCYON_S3_ACL`
> Default value:  `private`

ACL assigned to all files uploaded to the private Amazon S3 bucket.

Commonly used values are `private` and `public-read`.


### `HALCYON_PURGE_CACHE`
> Default value:  `0`

Whether to delete the contents of the Heroku cache before compilation.


### `HALCYON_NO_PREBUILT`
> Default value:  `0`

Whether to ignore all existing prebuilt packages and build all required packages from scratch.


### `HALCYON_NO_PREBUILT_GHC`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only GHC packages.


### `HALCYON_NO_PREBUILT_CABAL`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only Cabal packages.


### `HALCYON_NO_PREBUILT_SANDBOX`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only sandbox packages.


### `HALCYON_NO_PREBUILT_APP`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only app packages.


### `HALCYON_FORCE_GHC_VERSION`
> Default value:  _none_

Version of GHC to use, instead of an inferred version.


### `HALCYON_FORCE_CABAL_VERSION`
> Default value:  _none_

Version of Cabal to use, instead of an inferred version.


### `HALCYON_FORCE_CABAL_UPDATE`
> Default value:  `0`

Whether to ignore any existing prebuilt updated Cabal packages and update Cabal based on a non-updated Cabal package.


### `HALCYON_TRIM_GHC`
> Default value:  `0`

Whether to use an aggressively minimized prebuilt variant of GHC.


### `HALCYON_CUSTOM_SCRIPT`
> Default value:  _none_

TODO
