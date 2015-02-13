---
title: Buildpack for deploying Haskell apps
page-description: Haskell on Heroku is a buildpack for deploying Haskell apps.
page-class: hero tweak-listings
page-data:
- key: min-section-link-level
  value: 1
- key: min-back-link-level
  value: 2
- key: h2-back-link-target
  value: haskell-on-heroku
header-class: hero
main-class: hero
hero: |
  <h1 class="logotype">Haskell on Heroku</h1>
  <p>Buildpack for deploying Haskell apps</p>
  <div id="hero-button"><a href="#haskell-on-heroku" title="More">More</a></div>
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

Haskell on Heroku is a [Heroku](https://heroku.com/) buildpack for deploying Haskell apps.

The buildpack uses [Halcyon](https://halcyon.sh/) to install apps and development tools, including [GHC](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/) and [Cabal](https://haskell.org/cabal/users-guide/).

**Follow the [Haskell on Heroku tutorial](/tutorial/) to get started.**


### Support

The <a href="irc://chat.freenode.net/haskell-deployment">`#haskell-deployment`</a> IRC channel on [_freenode_](https://freenode.net/) is a good place to ask questions and find answers.

Please report any problems with Haskell on Heroku on the [issue tracker](https://github.com/mietek/haskell-on-heroku/issues).  There is a [separate issue tracker](https://github.com/mietek/haskell-on-heroku-website/issues) for problems with the documentation.

Need commercial support?  Contact the [author](#about) directly.


### Examples

- See the [Halcyon examples](https://halcyon.sh/examples/) for a demonstration of advanced Halcyon features.

- Take a look at the [Halcyon shootout](https://halcyon.sh/shootout/) for a comparison of build times and sizes across most Haskell web frameworks.

All example apps can be deployed to Heroku in one click.


<aside>
<a class="micro face tristan-sloughter" href="https://twitter.com/t_sloughter/status/539168929131003904"></a>
<blockquote>_“[Miëtek’s](#about) Haskell on Heroku and [Halcyon](https://halcyon.sh/) has made deploying [How I Start](https://halcyon.sh/examples/#how-i-start) fast and simple!  Thanks!”_</blockquote>
<p>[— Tristan Sloughter](https://twitter.com/t_sloughter/status/539168929131003904), author of [How I Start](https://halcyon.sh/examples/#how-i-start)</p>
</aside>


Usage
-----

Haskell on Heroku, like other [Heroku buildpacks](https://devcenter.heroku.com/articles/buildpacks), can be used when creating a new Heroku app:

```
$ heroku create -b https://github.com/mietek/haskell-on-heroku
```

Push the code to Heroku in order to deploy your app:

```
$ git push heroku master
```


### Documentation

- **Start with the [Haskell on Heroku tutorial](/tutorial/) to learn how to develop a simple Haskell web app and deploy it to Heroku.**

- Read the [Halcyon tutorial](https://halcyon.sh/tutorial/) to learn more about developing Haskell apps using Halcyon.

- See the [Haskell on Heroku reference](/reference/) for a list of buildpack-specific options.

- Look for additional options in the [Halcyon reference](https://halcyon.sh/reference/).


#### Internals

Haskell on Heroku is written in [GNU _bash_](https://gnu.org/software/bash/), using the [_bashmenot_](https://bashmenot.mietek.io/) library.

- Read the [Haskell on Heroku source code](https://github.com/mietek/haskell-on-heroku) to understand how it works.


<aside>
<a class="micro face brian-mckenna" href="https://twitter.com/puffnfresh/status/541029111611674624"></a>
<blockquote>_“Deployment of Haskell applications is getting interesting due to Miëtek’s [Halcyon](https://halcyon.sh/) project.”_</blockquote>
<p>[— Brian McKenna](https://twitter.com/puffnfresh/status/541029111611674624), author of [Try Idris](https://halcyon.sh/examples/#try-idris) and [inspiration](http://brianmckenna.org/blog/haskell_buildpack_heroku) for Haskell on Heroku</p>
</aside>


About
-----

<div class="aside-like">
<a class="face mietek" href="https://mietek.io/"></a>
<blockquote>_My name is [Miëtek Bak](https://mietek.io/).  I make software, and Haskell on Heroku is one of [my projects](https://mietek.io/projects/)._

_This work is published under the [MIT X11 license](/license/), and supported by my company, [Least Fixed](https://leastfixed.com/)._

_Like my work?  I am available for consulting.  Say <a class="hello" href="">hello</a>, or follow <a href="https://twitter.com/mietek">@mietek</a>._
</blockquote>
</div>


### Acknowledgments

Thanks to [Joe Nelson](http://begriffs.com/), [Brian McKenna](http://brianmckenna.org/), and [Neuman Vong](https://github.com/luciferous) for initial work on Haskell deployment.  Thanks to [CircuitHub](https://circuithub.com/), [Purely Agile](http://purelyagile.com/), and [Tweag I/O](http://tweag.io/) for advice and assistance.

The welcome image is based on [Cumulus Clouds](https://flickr.com/photos/kubina/152730867/), by [Jeff Kubina](https://flickr.com/photos/kubina/).  The monospaced font is [PragmataPro](http://fsd.it/fonts/pragmatapro.htm), by [Fabrizio Schiavi](http://fsd.it/).  The sans-serif font is [Concourse](http://practicaltypography.com/concourse.html), by [Matthew Butterick](http://practicaltypography.com/).  Website built with [_cannot_](https://cannot.mietek.io/).

Thanks to [Fastly](https://fastly.com/) for providing low-latency access to Halcyon public storage.

This project is not affiliated with [Heroku](https://heroku.com/).
