---
title: Tutorial
page-class: add-main-toc tweak-listings
page-data:
- key: max-section-toc-level
  value: 1
page-head: |
  <style>
    header a.link-tutorial {
      color: #ac5cf0;
    }
  </style>
---


Tutorial
========

<div><nav id="main-toc"></nav></div>


Introduction
------------

Haskell on Heroku is a Heroku buildpack, using [Halcyon](https://halcyon.sh/) in order to install Haskell apps and development tools.

This tutorial shows how to develop a simple Haskell web app, and deploy it to Heroku.


Set up
------

The tutorial assumes you’ve created a [Heroku account](https://signup.heroku.com/) and installed the [Heroku Toolbelt](https://toolbelt.heroku.com/):

```
$ which heroku
/usr/local/bin/heroku
```

You don’t need to install Haskell on your system to follow this tutorial, but if you want to do it, read the [Halcyon tutorial](https://halcyon.sh/tutorial/) first.


Deploy the app
--------------

The [tutorial app](https://github.com/mietek/haskell-on-heroku-tutorial) is a simple web service, built with [Servant](http://haskell-servant.github.io/).

The app includes a Cabal package description file, [`haskell-on-heroku-tutorial.cabal`](https://github.com/mietek/haskell-on-heroku-tutorial/blob/master/haskell-on-heroku-tutorial.cabal) file, used to declare dependencies, and a Halcyon constraints file,  [`.halcyon/constraints`](https://github.com/mietek/haskell-on-heroku-tutorial/blob/master/.halcyon/constraints) file, used to declare version constraints.

Clone the app repository:

```
$ git clone https://github.com/mietek/haskell-on-heroku-tutorial
```

Create a new Heroku app with the `heroku create` command, using the `-b` option to specify the buildpack:

<div class="toggle">
<a class="toggle-button" data-target="prepare-the-app-log1" href="" title="Toggle">Toggle</a>
``` { #prepare-the-app-log1 .toggle }
$ cd haskell-on-heroku-tutorial
$ heroku create -b https://github.com/mietek/haskell-on-heroku
Creating still-earth-4767... done, stack is cedar-14
BUILDPACK_URL=https://github.com/mietek/haskell-on-heroku
https://still-earth-4767.herokuapp.com/ | https://git.heroku.com/still-earth-4767.git
Git remote heroku added
```
</div>

Push the code to Heroku in order to deploy your app:

<div class="toggle">
<a class="toggle-button" data-target="deploy-the-app-log1" href="" title="Toggle">Toggle</a>
``` { #deploy-the-app-log1 .toggle }
$ git push heroku master
...
-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**

-----> Installing buildpack... done, 771c0ff
-----> Installing Halcyon... done, e4dd33c
-----> Installing bashmenot... done, c4b81f9
-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **9f23c39**
       External storage:                         **public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-9f23c39-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-install-9f23c39-haskell-on-heroku-tutorial-1.0.tar.gz... done, 8.8MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> App deployed:                             **haskell-on-heroku-tutorial-1.0**

       To see the app, spin up at least one web dyno:
       $ heroku ps:scale web=1
       $ heroku open

       To run GHCi, use a one-off dyno:
       $ heroku run bash
       $ restore
       $ cabal repl


-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 3.3MB
-----> Launching... done, v5
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
       ...
```
</div>

Ensure at least one instance of your app is running:

```
$ heroku ps:scale web=1
Scaling dynos... done, now running web at 1:1X.
```

Your app is now ready to use.


### Options

By default, Heroku creates apps with randomly-generated names, such as `still-earth-4767`.

You can specify your own app name as an argument to `heroku create`, or rename the app later using the `heroku apps:rename` command.


View the logs
-------------

The tutorial app exposes one HTTP endpoint, `/notes`, which accepts `GET` and `POST` requests.

You can visit the app in your web browser by using the `heroku open` command:

```
$ heroku open
Opening still-earth-4767... done
```

Heroku allows you to view the output of your app as a sequence of events, combined with messages from all other Heroku components.

Use the `heroku logs -t` command to start viewing the logs in one shell:

```
$ heroku logs -t
...
2015-01-14T09:24:33.751003+00:00 heroku[web.1]: State changed from starting to up
2015-01-14T09:24:40.087150+00:00 heroku[router]: at=info method=GET path="/" host=still-earth-4767.herokuapp.com request_id=2d9895dd-e31e-40d4-8b0a-f3835b4f653b fwd="192.168.144.120" dyno=web.1 connect=1ms service=2ms status=404 bytes=132
```

In another shell, make a `GET` request to see an empty list of notes:

```
$ curl https://still-earth-4767.herokuapp.com/notes
[]
```

Notes are JSON objects with a single text field, `contents`.  The app responds to each request with a list of all existing notes.

Make a couple `POST` requests to add some notes:

```
$ curl -X POST https://still-earth-4767.herokuapp.com/notes -d '{ "contents": "Hello, world!" }'
[{"contents":"Hello, world!"}]
```
```
$ curl -X POST https://still-earth-4767.herokuapp.com/notes -d '{ "contents": "Hello?" }'
[{"contents":"Hello?"},{"contents":"Hello, world!"}]
```

Incoming requests appear in the logs:

```
$ heroku logs -t
...
2015-01-14T09:25:05.606819+00:00 heroku[router]: at=info method=GET path="/notes" host=still-earth-4767.herokuapp.com request_id=34f251cb-66d6-4bf8-a16a-64ad4dc1d352 fwd="192.168.144.120" dyno=web.1 connect=1ms service=3ms status=200 bytes=150
2015-01-14T09:25:09.527051+00:00 heroku[router]: at=info method=POST path="/notes" host=still-earth-4767.herokuapp.com request_id=cc4a444f-804b-4a4d-8737-05ebd7bc6868 fwd="192.168.144.120" dyno=web.1 connect=8ms service=11ms status=201 bytes=183
2015-01-14T09:25:09.526124+00:00 app[web.1]: Hello, world!
2015-01-14T09:25:13.085316+00:00 heroku[router]: at=info method=POST path="/notes" host=still-earth-4767.herokuapp.com request_id=8672db7e-ad15-4093-9ef4-f052971d39e7 fwd="192.168.144.120" dyno=web.1 connect=3ms service=4ms status=201 bytes=205
2015-01-14T09:25:13.085297+00:00 app[web.1]: Hello?
```

Press `control-C` to stop viewing the logs.


Add a `Procfile`… or not
-------------------------

Heroku expects you to include a [`Procfile`](https://devcenter.heroku.com/articles/procfile) to declare what command should be executed to start your app.  With Haskell on Heroku, this isn’t necessary.

If a `Procfile` isn’t included, the buildpack generates one at compile-time, based on the executable name declared in the Cabal package description file:

```
$ grep executable haskell-on-heroku-tutorial.cabal
executable haskell-on-heroku-tutorial
```

The generated `Procfile` declares a single process type, `web`, and the command needed to start one:

```
web: /app/bin/haskell-on-heroku-tutorial
```

Heroku requires the `web` process type to be declared, as only instances of this process receive HTTP traffic from Heroku’s [routers](https://devcenter.heroku.com/articles/http-routing).


### Options

One `Procfile` can declare multiple process types, although Haskell apps rarely need to be composed of multiple processes.

The commands declared in a `Procfile` can include additional arguments and reference environment variables:

```
web: /app/bin/example-app -p $PORT
```


Scale the app
-------------

Heroku [dynos](https://devcenter.heroku.com/articles/dynos) are lightweight Linux containers, intended to run processes declared in your app’s `Procfile`.  There are three available [dyno sizes](https://devcenter.heroku.com/articles/dyno-size) — 1X, 2X, and PX.

Right now, your app is running on a single 1X dyno.  You can check this by using the `heroku ps` command:

```
$ heroku ps
=== web (1X): `/app/bin/haskell-on-heroku-tutorial`
web.1: up 2015/01/14 09:24:33 (~ 1m ago)
```

To increase your app’s throughput, and to prevent [dyno sleeping](https://devcenter.heroku.com/articles/dynos#dyno-sleeping), you can scale to more than one `web` dyno:

```
$ heroku ps:scale web=2
Scaling dynos... done, now running web at 2:1X.
```

Scaling the app may require you to [verify](https://heroku.com/verify) your Heroku account.

For each app, Heroku provides [750 free dyno-hours](https://devcenter.heroku.com/articles/usage-and-billing) per month.  This allows your app to run on a single 1X dyno for free, indefinitely.

Scale the app back to avoid exceeding this allowance:

```
$ heroku ps:scale web=1
Scaling dynos... done, now running web at 1:1X.
```


Start a one-off dyno
--------------------

TODO


Define a config var
-------------------

TODO


Push a change
-------------

TODO


Declare a dependency
--------------------

TODO


Declare a version constraint
----------------------------

TODO


Set up remote storage
---------------------

TODO


Provision an add-on
-------------------

TODO


Use a database
--------------

TODO


Next steps
----------

You now know how to use Haskell on Heroku to develop and deploy Haskell web apps.  You have also developed and deployed a simple Haskell web service.

Here’s some recommended reading:

- TODO


---

_**Work in progress.**  For updates, follow <a href="https://twitter.com/mietek">@mietek</a>._
