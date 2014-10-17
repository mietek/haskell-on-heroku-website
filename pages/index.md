---
title: Haskell web application deployment
page-class: hero
header-class: hero
main-class: hero
hero: |
  <h1 class="logotype">Haskell on Heroku</h1>
  <p>Haskell web application deployment.</p>
page-footer: |
  <script>
    addEventListener('load', function () {
      [].forEach.call(document.getElementsByClassName('hello'), function (hello) {
        hello.href = cannot.rot13('znvygb:uryyb@zvrgrx.vb');
      });
    });
  </script>
---


_Haskell on Heroku_
==================

_Haskell on Heroku_ is a system for fast and reliable deployment of Haskell web applications to [Heroku](http://heroku.com/).

**This page describes version 1.0, which is currently undergoing testing.  Check back soon, or follow <a href="http://twitter.com/mietek">@mietek</a>.**


Examples
--------

_Work in progress._


Usage
-----

To learn more, see the [full list of examples](examples/), and continue with the [user’s guide](guide/).

Interested in deploying other types of Haskell applications?  Try [Halcyon](http://halcyon.sh/).


### Internals

For an in-depth discussion of _Haskell on Heroku_ internals, see the [programmer’s reference](reference/).

_Haskell on Heroku_ is built with [Halcyon](http://halcyon.sh/), a system for deploying Haskell applications, and [_bashmenot_](http://bashmenot.mietek.io/), a library of functions for safer shell scripting in [GNU _bash_](http://gnu.org/software/bash/).

Additional information is available in the [Halcyon user’s guide](http://halcyon.sh/guide/), the [Halcyon programmers’s reference](http://halcyon.sh/reference/), and the [_bashmenot_ programmer’s reference](http://bashmenot.mietek.io/reference/).


### Installation

New applications:

```
$ heroku create -b https://github.com/mietek/haskell-on-heroku.git
```

Existing applications:

```
$ heroku config:set BUILDPACK_URL=https://github.com/mietek/haskell-on-heroku.git
```


### Dependencies

Currently, _Haskell on Heroku_ supports:

- Heroku _cedar_ and [_cedar-14_](https://blog.heroku.com/archives/2014/8/19/cedar-14-public-beta)
- GHC [7.6.1](http://www.haskell.org/ghc/download_ghc_7_6_1), [7.6.3](http://www.haskell.org/ghc/download_ghc_7_6_3), [7.8.2](http://www.haskell.org/ghc/download_ghc_7_8_2), and [7.8.3](http://www.haskell.org/ghc/download_ghc_7_8_3)
- _cabal-install_ [1.20.0.0](http://www.haskell.org/cabal/download.html) and newer


### Bugs

Please report any problems with _Haskell on Heroku_ on the [issue tracker](https://github.com/mietek/haskell-on-heroku/issues/).

There is a [separate issue tracker](https://github.com/mietek/haskell-on-heroku-website/issues/) for problems with the documentation.


About
-----

<span id="mietek"><a class="hello" href=""></a></span>

My name is [Miëtek Bak](http://mietek.io/).  I make software, and _Haskell on Heroku_ is one of [my projects](http://mietek.io/projects/).

This work is published under the [MIT X11 license](license/), and supported by my company, [Least Fixed](http://leastfixed.com/).

Would you like to work with me?  Say <a class="hello" href="">hello</a>.


### Acknowledgments

Thanks to [Joe Nelson](http://begriffs.com/), [Brian McKenna](http://brianmckenna.org/), and [Neuman Vong](https://github.com/luciferous/) for initial work on Haskell buildpacks.

Thanks to [CircuitHub](https://circuithub.com/), [Tweag I/O](http://www.tweag.io/), and [Purely Agile](http://purelyagile.com/) for advice and assistance.

The monospaced font used in this website is [PragmataPro](http://www.fsd.it/fonts/pragmatapro.htm), by [Fabrizio Schiavi](http://www.fsd.it/).  The sans-serif font is [Concourse](http://practicaltypography.com/concourse.html), by [Matthew Butterick](http://practicaltypography.com/).

The welcome image is based on [Cumulus Clouds](https://www.flickr.com/photos/kubina/152730867/), by [Jeff Kubina](https://www.flickr.com/photos/kubina/).

[Heroku](http://heroku.com/) is a registered trademark of [Salesforce](http://salesforce.com/).  This project is not affiliated with Heroku.
