---
title: Programmer’s reference
page-class: add-section-toc
page-head: |
  <style>
    header a.link-reference {
      color: #ac5cf0;
    }
  </style>
---


Programmer’s reference
======================

_Work in progress._


Configuration variables
-----------------------


### `HALCYON_AWS_ACCESS_KEY_ID`
> Default value:  _none_

Part of the authentication details used to access the private S3 bucket.


### `HALCYON_AWS_SECRET_ACCESS_KEY`
> Default value:  _none_

Like [`HALCYON_AWS_ACCESS_KEY_ID`](#halcyon_aws_access_key_id), but secret.


### `HALCYON_S3_BUCKET`
> Default value:  _none_

Name of the private Amazon S3 bucket used to store prebuilt layers.


### `HALCYON_S3_ACL`
> Default value:  `private`

The [S3 <abbr title="Access control list">ACL</abbr>](http://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html) assigned to all files uploaded to the private S3 bucket.

Commonly used values are `private` and `public-read`.


### `HALCYON_PURGE_CACHE`
> Default value:  `0`

Whether to delete the entire contents of the Heroku cache before compilation.


### `HALCYON_DEPENDENCIES_ONLY`
> Default value:  `0`

Whether to only install non-application layers, skipping the application layer entirely.


### `HALCYON_NO_PREBUILT`
> Default value:  `0`

Whether to ignore all prebuilt layers, and build all required layers from scratch.


### `HALCYON_NO_PREBUILT_GHC`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only prebuilt GHC layers.


### `HALCYON_NO_PREBUILT_CABAL`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only prebuilt Cabal layers.


### `HALCYON_NO_PREBUILT_SANDBOX`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only prebuilt sandbox layers.


### `HALCYON_NO_PREBUILT_APP`
> Default value:  `0`

Like [`HALCYON_NO_PREBUILT`](#halcyon_no_prebuilt), but ignoring only prebuilt application layers.


### `HALCYON_FORCE_GHC_VERSION`
> Default value:  _none_

The version of GHC to use, instead of an inferred version.


### `HALCYON_FORCE_CABAL_VERSION`
> Default value:  _none_

The version of Cabal to use, instead of an inferred version.


### `HALCYON_FORCE_CABAL_UPDATE`
> Default value:  `0`

Whether to ignore any existing prebuilt updated Cabal layers and update Cabal from scratch.


### `HALCYON_TRIM_GHC`
> Default value:  `0`

Whether to use an aggressively minimised variant of GHC.


### `HALCYON_CUSTOM_SCRIPT`
> Default value:  _none_

TODO
