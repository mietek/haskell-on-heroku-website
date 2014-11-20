---
title: Haskell web application deployment
page-class: hero tweak-listings
header-class: hero
main-class: hero
hero: |
  <h1 class="logotype">Haskell on Heroku</h1>
  <p>Haskell web application deployment</p>
page-footer: |
  <script>
    addEventListener('load', function () {
      [].forEach.call(document.getElementsByClassName('hello'), function (hello) {
        hello.href = cannot.rot13('znvygb:uryyb@zvrgrx.vb');
      });
    });
  </script>
---


Haskell on Heroku
==================

Haskell on Heroku is a system for deploying Haskell web applications to [Heroku](https://heroku.com/), based on [Halcyon](https://halcyon.sh/).

**Pre-release version.  Please sign up to the [Haskell on Heroku announcements list](http://eepurl.com/8KXsT) for updates, or follow <a href="https://twitter.com/mietek">@mietek</a>.**


Overview
--------

Haskell on Heroku can deploy any Haskell web application in two clicks, using explicitly declared versions of GHC, libraries, build-tools, and other dependencies.

For more information about the build process, please refer to the [Halcyon documentation](https://halcyon.sh/#more).


Usage
-----

```
$ heroku create -b https://github.com/mietek/haskell-on-heroku
$ git push heroku master
$ heroku ps:scale web=1
$ heroku open
```


### Examples

<nav>
<ul class="menu open">
<li><a href="apps/">Real-world Haskell apps</a></li>
<li><a href="examples/">“Hello, world!” examples</a></li>
</ul>
</nav>


### Dependencies

Haskell on Heroku supports:

- Heroku _cedar_ and [_cedar-14_](https://devcenter.heroku.com/articles/cedar)
- GHC [7.6.3](https://haskell.org/ghc/download_ghc_7_6_3) and [7.8.3](https://haskell.org/ghc/download_ghc_7_8_3)
- _cabal-install_ [1.20.0.0](https://haskell.org/cabal/download.html) and newer

Versions of GHC including [7.8.2](https://haskell.org/ghc/download_ghc_7_8_2), [7.6.1](https://haskell.org/ghc/download_ghc_7_6_1) , [7.4.2](https://haskell.org/ghc/download_ghc_7_4_2), [7.2.2](https://haskell.org/ghc/download_ghc_7_2_2), and [7.0.4](https://haskell.org/ghc/download_ghc_7_0_4) are also expected to work.


### Support

Please report any problems with Haskell on Heroku on the [issue tracker](https://github.com/mietek/haskell-on-heroku/issues/).  There is a [separate issue tracker](https://github.com/mietek/haskell-on-heroku-website/issues/) for problems with the documentation.

The <a href="irc://chat.freenode.net/haskell-deployment">#haskell-deployment</a> IRC channel on [freenode](https://freenode.net/) is a good place to ask questions and find answers.


About
-----

<span id="mietek"><a class="hello" href=""></a></span>

My name is [Miëtek Bak](https://mietek.io/).  I make software, and Haskell on Heroku is one of [my projects](https://mietek.io/projects/).

This work is published under the [MIT X11 license](license/), and supported by my company, [Least Fixed](https://leastfixed.com/).

Like my work?  I am available for consulting on software projects.  Say <a class="hello" href="">hello</a>, or follow <a href="https://twitter.com/mietek">@mietek</a>.


### Acknowledgments

Thanks to [Joe Nelson](http://begriffs.com/), [Brian McKenna](http://brianmckenna.org/), and [Neuman Vong](https://github.com/luciferous/) for initial work on Haskell buildpacks.  Thanks to [CircuitHub](https://circuithub.com/), [Tweag I/O](http://tweag.io/), and [Purely Agile](http://purelyagile.com/) for advice and assistance.

The monospaced font used in this website is [PragmataPro](http://fsd.it/fonts/pragmatapro.htm), by [Fabrizio Schiavi](http://fsd.it/).  The sans-serif font is [Concourse](http://practicaltypography.com/concourse.html), by [Matthew Butterick](http://practicaltypography.com/).  The welcome image is based on [Cumulus Clouds](https://flickr.com/photos/kubina/152730867/), by [Jeff Kubina](https://flickr.com/photos/kubina/).

[Heroku](http://heroku.com/) is a registered trademark of [Salesforce](http://salesforce.com/).  This project is not affiliated with Heroku.
