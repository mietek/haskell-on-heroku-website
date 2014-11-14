---
title: Haskell web application deployment
page-class: hero tweak-listings
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


Haskell on Heroku
==================

Haskell on Heroku is a system for fast and reliable deployment of Haskell web applications to [Heroku](https://heroku.com/).

**This page describes version 1.0, which is currently undergoing testing.  Check back soon, or follow <a href="https://twitter.com/mietek">@mietek</a>.**


Examples
--------

_Work in progress._

<nav>
<ul class="menu open">
<li><a href="examples/">See all examples</a></li>
</ul>
</nav>


Usage
-----

New applications:

```
$ heroku create -b https://github.com/mietek/haskell-on-heroku -s cedar-14
```

Existing applications:

```
$ heroku config:set BUILDPACK_URL=https://github.com/mietek/haskell-on-heroku
```

Haskell on Heroku supports:

- Heroku _cedar_ and [_cedar-14_](https://blog.heroku.com/archives/2014/8/19/cedar-14-public-beta).
- GHC [7.0.4](https://haskell.org/ghc/download_ghc_7_0_4), [7.2.2](https://haskell.org/ghc/download_ghc_7_2_2), [7.4.2](https://haskell.org/ghc/download_ghc_7_4_2), [7.6.1](https://haskell.org/ghc/download_ghc_7_6_1), [7.6.3](https://haskell.org/ghc/download_ghc_7_6_3), [7.8.2](https://haskell.org/ghc/download_ghc_7_8_2), and [7.8.3](https://haskell.org/ghc/download_ghc_7_8_3).
- _cabal-install_ [1.20.0.0](https://haskell.org/cabal/download.html) and newer.

To learn more, check back soon.


### Internals

Haskell on Heroku is built with [Halcyon](https://halcyon.sh/), a system for deploying Haskell applications, and [_bashmenot_](https://bashmenot.mietek.io/), a library of functions for safer shell scripting in [GNU _bash_](https://gnu.org/software/bash/).

Additional information is available in the [_bashmenot_ programmer’s reference](https://bashmenot.mietek.io/reference/).


### Bugs

Please report any problems with Haskell on Heroku on the [issue tracker](https://github.com/mietek/haskell-on-heroku/issues/).

There is a [separate issue tracker](https://github.com/mietek/haskell-on-heroku-website/issues/) for problems with the documentation.


About
-----

<span id="mietek"><a class="hello" href=""></a></span>

My name is [Miëtek Bak](https://mietek.io/).  I make software, and Haskell on Heroku is one of [my projects](https://mietek.io/projects/).

This work is published under the [MIT X11 license](license/), and supported by my company, [Least Fixed](https://leastfixed.com/).

Like my work?  I am available for consulting on software projects.  Say <a class="hello" href="">hello</a>, or follow <a href="https://twitter.com/mietek">@mietek</a>.


### Acknowledgments

Thanks to [Joe Nelson](http://begriffs.com/), [Brian McKenna](http://brianmckenna.org/), and [Neuman Vong](https://github.com/luciferous/) for initial work on Haskell buildpacks.  Thanks to [CircuitHub](https://circuithub.com/), [Tweag I/O](http://tweag.io/), and [Purely Agile](http://purelyagile.com/) for advice and assistance.

The monospaced font used in this website is [PragmataPro](http://fsd.it/fonts/pragmatapro.htm), by [Fabrizio Schiavi](http://fsd.it/).  The sans-serif font is [Concourse](http://practicaltypography.com/concourse.html), by [Matthew Butterick](http://practicaltypography.com/).  The welcome image is based on [Cumulus Clouds](https://flickr.com/photos/kubina/152730867/), by [Jeff Kubina](https://flickr.com/photos/kubina/).

[Heroku](http://heroku.com/) is a registered trademark of [Salesforce](http://salesforce.com/).  This project is not affiliated with Heroku.
