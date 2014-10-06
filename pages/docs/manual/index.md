---
title: Manual
---


Manual
======

Work in progress.


Buckets
-------

Haskell on Heroku is intended to be used with a private Amazon S3 bucket, defined by the [`HALCYON_S3_BUCKET`](docs/reference/#halcyon_s3_bucket) configuration variable.

Packages prebuilt on a Heroku one-off dyno need to be available during app compilation, which is performed on an unspecified compile dyno.  Compile dynos keep prebuilt packages in the Heroku compile cache, but access to the cache is not allowed from one-off dynos.  Some form of external storage must be used to help transfer packages from one-off dynos to compile dynos, which is where the bucket comes in.

Additionally, sharing the same bucket between multiple apps helps save work by allowing common packages to be reused.

A public S3 bucket is provided in order to facilitate getting started, and as a fallback measure.  Using the public bucket for production purposes is not recommended, as the list of available prebuilt packages may change at any time.


### Bucket usage

Haskell on Heroku can use buckets in one of three ways:

1.  If a private bucket is not available, Haskell on Heroku will be unable to prebuild packages, and will only use packages from the default public Halcyon bucket.  As these packages cannot contain all dependencies required to compile every app, only some apps will deploy successfully, and other apps will fail to deploy.

2.  Similarly, if a private bucket is available, but uploading to it is not allowed—either by an S3 policy, or by setting [`HALCYON_NO_UPLOAD`](docs/reference/#halcyon_no_upload) to `1`—Haskell on Heroku will only use the packages which already exist in the bucket.  Public packages are not used in this mode.

3.  Finally, if a private bucket is available, and uploading to it is allowed, Haskell on Heroku will archive any prebuilt packages in the bucket for later reuse.  All uploaded files will be assigned an ACL, defined by [`HALCYON_S3_ACL`](docs/reference/#halcyon_s3_acl).  This is the optimal mode.

Access to the private bucket is controlled by setting the [`HALCYON_AWS_ACCESS_KEY_ID`](docs/reference/#halcyon_aws_access_key) and [`HALCYON_AWS_SECRET_ACCESS_KEY`](docs/reference/#halcyon_aws_secret_access_key) configuration variables.


### Bucket organization

Refer to the [Halcyon documentation](http://halcyon.sh/docs/manual/#bucket-organization) for details.
