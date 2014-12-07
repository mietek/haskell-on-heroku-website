---
title: Haskell web application deployment
page-description: Haskell on Heroku is a system for deploying Haskell web applications, powered by Halcyon.
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
  <p>Deploy any Haskell web application.  Instantly.</p>
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

Haskell on Heroku is a system for deploying Haskell web applications to [Heroku](https://heroku.com/), powered by [Halcyon](https://halcyon.sh/).


### Support

_**Work in progress.**  For updates, please sign up to the [Haskell on Heroku announcements list](http://eepurl.com/8KXsT), or follow <a href="https://twitter.com/mietek">@mietek</a>._

The <a href="irc://chat.freenode.net/haskell-deployment">#haskell-deployment</a> IRC channel on [freenode](https://freenode.net/) is a good place to ask questions and find answers.

Please report any problems with Haskell on Heroku on the [issue tracker](https://github.com/mietek/haskell-on-heroku/issues/).  There is a [separate issue tracker](https://github.com/mietek/haskell-on-heroku-website/issues/) for problems with the documentation.

Need commercial support?  Contact the [author](#about) directly.


### Examples

Haskell on Heroku is being used in production since June 2014.

All Halcyon [example applications](https://halcyon.sh/examples/) and [“Hello, world!” shootout entries](https://halcyon.sh/shootout/) can be deployed to Heroku just by pushing a button.


<aside>
<a class="micro face tristan-sloughter" href="https://twitter.com/t_sloughter/status/539168929131003904"></a>
<blockquote>_“Miëtek’s Haskell on Heroku and [Halcyon](https://halcyon.sh/) has made deploying [How I Start](https://howistart.org/) fast and simple!  Thanks!”_</blockquote>
<p>[— Tristan Sloughter](https://twitter.com/t_sloughter/status/539168929131003904)</p>
</aside>


Usage
-----

<pre class="with-tweaks"><code><span class="prompt">$</span> <span class="input">heroku create -b <a href="https://github.com/mietek/haskell-on-heroku">https://github.com/mietek/haskell-on-heroku</a></span>
<span class="prompt">$</span> <span class="input">heroku config:set <a href="https://halcyon.sh/reference/#halcyon_aws_access_key_id">HALCYON_AWS_ACCESS_KEY_ID</a>=…</span>
<span class="prompt">$</span> <span class="input">heroku config:set <a href="https://halcyon.sh/reference/#halcyon_aws_secret_access_key">HALCYON_AWS_SECRET_ACCESS_KEY</a>=…</span>
<span class="prompt">$</span> <span class="input">heroku config:set <a href="https://halcyon.sh/reference/#halcyon_s3_bucket">HALCYON_S3_BUCKET</a>=…</span>
<span class="prompt">$</span> <span class="input">git push heroku master</span>
</code></pre>

```
$ heroku run --size=PX build
$ git commit --amend -C HEAD
$ git push -f heroku master
```

```
$ heroku ps:scale web=1
$ heroku open
```

### Documentation

<div><nav>
<ul class="menu open">
<li><a href="/guide/">User’s guide</a></li>
<li><a href="/reference/">User’s reference</a></li>
<li><a href="https://halcyon.sh/guide/">Halcyon user’s guide</a></li>
<li><a href="https://halcyon.sh/reference/">Halcyon user’s reference</a></li>
</ul>
</nav></div>


#### Internal documentation

Haskell on Heroku is written in [GNU _bash_](https://gnu.org/software/bash/), using the [_bashmenot_](https://bashmenot.mietek.io/) shell function library.

<div><nav>
<ul class="menu open">
<li><a href="https://github.com/mietek/haskell-on-heroku">Source code</a></li>
<li><a href="https://github.com/mietek/halcyon">Halcyon source code</a></li>
<li><a href="https://bashmenot.mietek.io/reference/">_bashmenot_ programmer’s reference</a></li>
<li><a href="https://github.com/mietek/bashmenot">_bashmenot_ source code</a></li>
</ul>
</nav></div>


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

Thanks to [Joe Nelson](http://begriffs.com/), [Brian McKenna](http://brianmckenna.org/), and [Neuman Vong](https://github.com/luciferous/) for initial work on Haskell deployment.  Thanks to [CircuitHub](https://circuithub.com/), [Purely Agile](http://purelyagile.com/), and [Tweag I/O](http://tweag.io/) for advice and assistance.

The welcome image is based on [Cumulus Clouds](https://flickr.com/photos/kubina/152730867/), by [Jeff Kubina](https://flickr.com/photos/kubina/).  The monospaced font is [PragmataPro](http://fsd.it/fonts/pragmatapro.htm), by [Fabrizio Schiavi](http://fsd.it/).  The sans-serif font is [Concourse](http://practicaltypography.com/concourse.html), by [Matthew Butterick](http://practicaltypography.com/).  Website built with [_cannot_](https://cannot.mietek.io/).

This project is not affiliated with [Heroku](https://heroku.com/), [DigitalOcean](https://digitalocean.com/), or [Amazon](https://amazon.com/).


<aside>
<a class="micro face joe-nelson" href="https://twitter.com/begriffs/status/522811714325475329"></a>
<blockquote>_“Check out [Miëtek’s](#about) Haskell on Heroku buildpack — it dynamically selects a pre-made Cabal sandbox for build speed.”_</blockquote>
<p>[— Joe Nelson](https://twitter.com/begriffs/status/522811714325475329)</p>
</aside>
