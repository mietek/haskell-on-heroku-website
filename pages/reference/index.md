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


Usage
-----

Executing any of the [`build`](https://github.com/mietek/haskell-on-heroku/blob/master/bin/build), [`compile`](https://github.com/mietek/haskell-on-heroku/blob/master/bin/compile), or [`restore`](https://github.com/mietek/haskell-on-heroku/blob/master/bin/restore) scripts automatically updates Haskell on Heroku, Halcyon, and _bashmenot_ to the newest versions available.

To disable automatic updates, set [`BUILDPACK_NO_AUTOUPDATE`](#buildpack_no_autoupdate) to `1`.

Automatic updates are automatically disabled on compile dynos.

The top-level [`src.sh`](https://github.com/mietek/haskell-on-heroku/blob/master/src.sh) file can also be sourced to bring all functions into scope.


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
