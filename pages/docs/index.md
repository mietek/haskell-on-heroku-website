---
title: Docs
---


Docs
====

Work in progress.


---

Haskell on Heroku is intended to be used with a private Amazon S3 bucket, defined by the `HALCYON_S3_BUCKET` configuration variable.

The S3 bucket is required for packages prebuilt on one-off dynos to be available during slug compilation, as there is no way to write to the Heroku cache from an one-off dyno.  Additionally, multiple apps can share prebuilt packages by using the same S3 bucket.

If write access to an S3 bucket is not available, no new packages can be prebuilt.  This means any app requiring a package which is not on the [list of public Halcyon prebuilt packages](http://TODO) will fail to compile.
