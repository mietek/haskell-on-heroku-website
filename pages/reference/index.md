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


Usage
-----

_Work in progress._


Automatic update options
------------------------

### `BUILDPACK_URL`

> ---------------------|---
> Default value:       | [`https://github.com/mietek/haskell-on-heroku`](https://github.com/mietek/haskell-on-heroku)

_git_ repository used for automatic updates.

Defaults to the `master` branch.  Another branch may be specified with a `#`_`branch`_ suffix.


### `BUILDPACK_NO_AUTOUPDATE`

> ---------------------|---
> Default value:       | `0`

Disables automatic updates.
