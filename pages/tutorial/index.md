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
<a class="toggle-button" data-target="deploy-the-app-log1" href="" title="Toggle">Toggle</a>
``` { #deploy-the-app-log1 .toggle }
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
<a class="toggle-button" data-target="deploy-the-app-log2" href="" title="Toggle">Toggle</a>
``` { #deploy-the-app-log2 .toggle }
$ git push -q heroku HEAD:master
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
       ...

-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 3.3MB
-----> Launching... done, v5
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
...
```
</div>

In this step, Halcyon restores the tutorial app’s _install directory_ by extracting an archive downloaded from _public storage._  The correct archive to restore is determined by calculating a _source hash_ of the source directory.

Make sure your app is running:

```
$ heroku ps:scale web=1
Scaling dynos... done, now running web at 1:1X.
```

Your app is now ready to use.


### Options

By default, Heroku creates apps with randomly-generated names, such as `still-earth-4767`.

You can specify your own app name as an argument to `heroku create`, or rename the app later with the `heroku apps:rename` command.


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

Heroku expects you to include a [`Procfile`](https://devcenter.heroku.com/articles/procfile) to declare what command should be executed to start your app.

With Haskell on Heroku, this isn’t necessary.  If a `Procfile` isn’t included, the buildpack generates one at compile-time, based on the executable name declared in the Cabal package description file:

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

Right now, your app is running on a single 1X dyno.  You can check this with the `heroku ps` command:

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


Use a one-off dyno
------------------

Heroku allows you to run commands on [one-off dynos](https://devcenter.heroku.com/articles/one-off-dynos) with `heroku run`.

Try launching a remote shell:

```
$ heroku run bash
Running `bash` attached to terminal... up, run.4012
~ $ ls
Main.hs  Procfile  README.md  app.json	bin  cabal.config  haskell-on-heroku-tutorial.cabal
```

Each dyno has its own transient filesystem, which includes the contents of your app’s [slug](https://devcenter.heroku.com/articles/slug-compiler).  Once the command finishes running, the dyno is shut down, and its filesystem is discarded.

For performance reasons, Haskell on Heroku does not include your app’s dependencies in the slug.  If you want to experiment with your app in GHCi, you need to restore the dependencies first.

Use `heroku run` to launch a remote GHCi session:

<div class="toggle">
<a class="toggle-button" data-target="use-a-one-off-dyno-log1" href="" title="Toggle">Toggle</a>
``` { #use-a-one-off-dyno-log1 .toggle }
$ heroku run 'restore && cabal repl'
Running `restore && cabal repl` attached to terminal... up, run.1522
-----> Installing haskell-on-heroku-tutorial-1.0
-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **5f04cfc**
       Constraints hash:                         **becfd1b**
       Magic hash:                               **c7b5b77**
       External storage:                         **public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz... done
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Locating Cabal directories
       Listing https://halcyon.global.ssl.fastly.net/?prefix=linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-... done
-----> Restoring Cabal directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-15.tar.gz... done
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-15.tar.gz... done, 180MB

-----> Restoring sandbox directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-becfd1b-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-sandbox-becfd1b-haskell-on-heroku-tutorial-1.0.tar.gz... done, 140MB

-----> Restoring build directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 9.4MB

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-5f04cfc-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-install-5f04cfc-haskell-on-heroku-tutorial-1.0.tar.gz... done, 8.8MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> App restored:                             **haskell-on-heroku-tutorial-1.0**
       ...

GHCi, version 7.8.4: http://www.haskell.org/ghc/  :? for help
...
[1 of 1] Compiling Main             ( Main.hs, interpreted )
Ok, modules loaded: Main.
λ 
```
</div>

Your app’s code is now ready to use:

<div class="toggle">
<a class="toggle-button" data-target="use-a-one-off-dyno-log2" href="" title="Toggle">Toggle</a>
``` { #use-a-one-off-dyno-log2 .toggle }
λ :browse
newtype Note = Note {contents :: Text}
emptyNotes :: IO (TVar [Note])
getNotes :: MonadIO m => TVar [Note] -> m [Note]
postNote :: MonadIO m => TVar [Note] -> Note -> m [Note]
type NoteAPI =
  ("notes" :> Get [Note])
  :<|> ("notes" :> (ReqBody Note :> Post [Note]))
noteAPI :: Proxy NoteAPI
server :: TVar [Note] -> Server NoteAPI
main :: IO ()
```
</div>

Press `control-D` to exit GHCi and shut down the dyno.


### Options

By default, Heroku starts 1X one-off dynos.  You can specify another size with the `-s` option:

```
$ heroku run -s PX bash
```


Push a change
-------------

Let’s change the tutorial app so that each note can contain a timestamp.

The [`step2`](https://github.com/mietek/haskell-on-heroku-tutorial/tree/2) version of the app includes a new `dateTime` field in each note.

Check out and deploy `step2`:

<div class="toggle">
<a class="toggle-button" data-target="push-a-change-log" href="" title="Toggle">Toggle</a>
``` { #push-a-change-log .toggle }
$ git checkout -q step2
$ git push -q heroku HEAD:master
...
-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**

-----> Installing buildpack... done, 4502dd8
-----> Installing Halcyon... done, a45f643
-----> Installing bashmenot... done, 3221e3f
-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **711905e**
       External storage:                         **public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-711905e-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)

-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **711905e**
       Constraints hash:                         **becfd1b**
       Magic hash:                               **c7b5b77**
       External storage:                         **public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz... done
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Locating Cabal directories
       Listing https://halcyon.global.ssl.fastly.net/?prefix=linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-... done
-----> Restoring Cabal directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-15.tar.gz... done
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-15.tar.gz... done, 180MB

-----> Restoring sandbox directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-becfd1b-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-sandbox-becfd1b-haskell-on-heroku-tutorial-1.0.tar.gz... done, 140MB

-----> Restoring build directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 9.4MB
-----> Examining source changes
       * Main.hs
-----> Building app
       Building haskell-on-heroku-tutorial-1.0...
       Preprocessing executable 'haskell-on-heroku-tutorial' for
       haskell-on-heroku-tutorial-1.0...
       [1 of 1] Compiling Main             ( Main.hs, dist/build/haskell-on-heroku-tutorial/haskell-on-heroku-tutorial-tmp/Main.o )
       Linking dist/build/haskell-on-heroku-tutorial/haskell-on-heroku-tutorial ...
-----> App built, 12MB
       Stripping app... done, 9.4MB
-----> Archiving build directory
       Creating halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 2.1MB

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-711905e-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
-----> Preparing install directory
-----> Install directory prepared, 8.8MB
-----> Archiving install directory
       Creating halcyon-install-711905e-haskell-on-heroku-tutorial-1.0.tar.gz... done, 2.0MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> App deployed:                             **haskell-on-heroku-tutorial-1.0**
       ...

-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 3.3MB
-----> Launching... done, v6
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
...
```
</div>

In this step, Halcyon tries to restore the tutorial app’s install directory.  This fails, and so Halcyon falls back to building the app:

1.  First, a _GHC directory_, a _Cabal directory_, and the app’s _sandbox directory_ are restored from public storage.

2.  Next, Halcyon restores the app’s _build directory,_ and performs an incremental build.

3.  Finally, a new install directory is prepared and archived, and the app is installed.

Halcyon determines which sandbox to use by calculating a _constraints hash_ of the version constraints declared by your app.  Similarly, the version of GHC to use is implied by the `base` package constraint:

```
$ grep -E '^base-' .halcyon/constraints
base-4.7.0.2
```

Your app is now ready to use again:

```
$ curl -X POST https://still-earth-4767.herokuapp.com/notes -d '{ "contents": "Hello, world!" }'
[{"contents":"Hello, world!","dateTime":""}]
```


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
