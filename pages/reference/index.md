---
title: Option reference
page-class: add-section-toc tweak-listings
page-head: |
  <style>
    header a.link-options {
      color: #ac5cf0;
    }
  </style>
---


Option reference
================


Automatic update options
------------------------

### `BUILDPACK_URL`

> ---------------------|---
> Default value:       | [`https://github.com/mietek/haskell-on-heroku`](https://github.com/mietek/haskell-on-heroku)

URL of the _git_ repository used for automatic updates.

Defaults to the `master` branch.  Another branch may be specified with a `#`_`branch`_ suffix.


### `BUILDPACK_NO_AUTOUPDATE`

> ---------------------|---
> Default value:       | `0`

Disables automatic updates.


General options
---------------

### `BUILDPACK_SSH_PRIVATE_KEY`

> ---------------------|---
> Default value:       | _none_

TODO
