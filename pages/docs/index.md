---
title: Docs
---


Docs
====

Work in progress.


On buckets
----------

Haskell on Heroku is intended to be used with a private Amazon S3 bucket, defined by the `HALCYON_S3_BUCKET` configuration variable.

The bucket is needed so that packages prebuilt on a Heroku dyno will be available during app compilation.  As it is currently not possible to write to the Heroku cache from a dyno, some form of external storage must be used.

Additionally, sharing the same bucket between multiple apps helps save work by allowing common packages to be reused.

There are three modes of operation:

1.  If the bucket is not available, Haskell on Heroku cannot prebuild new packages, and falls back to using [public prebuilt packages](http://halcyon.sh/docs/public-prebuilt-packages/).  These packages may not contain all required dependencies, in which case deployment will fail.

2.  Similarly, if the bucket is defined, but uploading to it is not allowed—either by an S3 policy, or by setting `HALCYON_NO_UPLOAD` to `1`—Haskell on Heroku only uses the packages which already exist in the bucket.  Public packages are not used in this case.

3.  With full access to the bucket, Haskell on Heroku will archive any prebuilt packages in the bucket for later reuse.  This is the optimal scenario.

Access to the bucket is controlled by defining the `HALCYON_AWS_ACCESS_KEY_ID` and `HALCYON_AWS_SECRET_ACCESS_KEY` configuration variables.
