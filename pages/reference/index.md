---
title: Reference
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


Haskell on Heroku reference
===========================

Haskell on Heroku is a [Heroku](https://heroku.com/) buildpack for deploying [Haskell](https://haskell.org/) apps.

The buildpack uses [Halcyon](https://halcyon.sh/) to install apps and development tools, including [GHC](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/) and [Cabal](https://haskell.org/cabal/users-guide/).

This reference is a list of buildpack-specific options.  Additional options are listed in the [Halcyon reference](https://halcyon.sh/reference/).


General options
---------------

### `BUILDPACK_SSH_PRIVATE_KEY`

> ---------------------|---
> Default value:       | _none_
> Type:                | _string_

Private key to be written to `~/.ssh/id_rsa` after beginning execution.

Additionally, disables SSH strict host key checking, and sets the known hosts file to `/dev/null`.

Intended to support using private GitHub repositories as [`HALCYON_SANDBOX_SOURCES`](https://halcyon.sh/reference/#halcyon_sandbox_sources).


Self-update options
-------------------

### `BUILDPACK_DIR`

> ---------------------|---
> Default value:       | _variable_
> Type:                | _read-only string_

Directory in which Haskell on Heroku is installed.

Automatically set by Haskell on Heroku at run-time.


### `BUILDPACK_URL`

> ---------------------|---
> Default value:       | [`https://github.com/mietek/haskell-on-heroku`](https://github.com/mietek/haskell-on-heroku)
> Type:                | _git_ URL

URL of the _git_ repository from which Haskell on Heroku updates itself.

Defaults to the `master` branch.  Other branches may be specified with a `#`_`branch`_ suffix.


### `BUILDPACK_NO_SELF_UPDATE`

> ---------------------|---
> Default value:       | `0`
> Type:                | `0` or `1`

Prevents Haskell on Heroku from updating itself.
