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


Buckets
-------

_Haskell on Heroku_ is intended to be used with a private Amazon S3 bucket, defined by the [`HALCYON_S3_BUCKET`](documentation/reference/#halcyon_s3_bucket) configuration variable.

Packages prebuilt on a Heroku one-off dyno need to be available during app compilation, which is performed on an unspecified compile dyno.  Compile dynos keep prebuilt packages in the Heroku compile cache, but access to the cache is not allowed from one-off dynos.  Some form of external storage must be used to help transfer packages from one-off dynos to compile dynos, which is where the bucket comes in.

Additionally, sharing the same bucket between multiple apps helps save work by allowing common packages to be reused.

A public S3 bucket is provided in order to facilitate getting started, and as a fallback measure.  Using the public bucket for production purposes is not recommended, as the list of available prebuilt packages may change at any time.


### Bucket usage

_Haskell on Heroku_ can use buckets in one of three ways:

1.  If a private bucket is not available, _Haskell on Heroku_ will be unable to prebuild packages, and will only use packages from the default public Halcyon bucket.  As these packages cannot contain all dependencies required to compile every app, only some apps will deploy successfully, and other apps will fail to deploy.

2.  Similarly, if a private bucket is available, but uploading to it is not allowed—either by an S3 policy, or by setting [`HALCYON_NO_UPLOAD`](documentation/reference/#halcyon_no_upload) to `1`—_Haskell on Heroku_ will only use the packages which already exist in the bucket.  Public packages are not used in this mode.

3.  Finally, if a private bucket is available, and uploading to it is allowed, _Haskell on Heroku_ will archive any prebuilt packages in the bucket for later reuse.  All uploaded files will be assigned an ACL, defined by [`HALCYON_S3_ACL`](documentation/reference/#halcyon_s3_acl).  This is the optimal mode.

Access to the private bucket is controlled by setting the [`HALCYON_AWS_ACCESS_KEY_ID`](documentation/reference/#halcyon_aws_access_key) and [`HALCYON_AWS_SECRET_ACCESS_KEY`](documentation/reference/#halcyon_aws_secret_access_key) configuration variables.
