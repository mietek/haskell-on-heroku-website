---
title: User’s reference
page-class: add-section-toc rule-before-h3 tweak-listings
page-data:
- key: max-back-link-level
  value: 3
page-head: |
  <style>
    header a.link-reference {
      color: #ac5cf0;
    }
  </style>
---


User’s reference
================


Options
-------

### `BUILDPACK_SSH_PRIVATE_KEY`

> ---------------------|---
> Default value:       | _none_
> Type:                | _string_

_TODO_


### `BUILDPACK_DIR`

> ---------------------|---
> Default value:       | _variable_
> Type:                | _read-only string_

Directory in which Haskell on Heroku is installed.


### `BUILDPACK_URL`

> ---------------------|---
> Default value:       | [`https://github.com/mietek/haskell-on-heroku`](https://github.com/mietek/haskell-on-heroku)
> Type:                | _git_ URL

URL of the _git_ repository from which Haskell on Heroku updates itself.

The `master` branch is used by default.  Other branches may be specified with a `#`_`branch`_ suffix.


### `BUILDPACK_NO_SELF_UPDATE`

> ---------------------|---
> Default value:       | `0`
> Type:                | `0` or `1`

Prevents Haskell on Heroku from updating itself.


---

_**Work in progress.**  For updates, please sign up to the [Haskell on Heroku announcements list](http://eepurl.com/8KXsT), or follow <a href="https://twitter.com/mietek">@mietek</a>._

For more information, please see the Halcyon [user’s reference](https://halcyon.sh/reference/).
