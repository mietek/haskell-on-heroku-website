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


Haskell on Heroku tutorial
==========================

Haskell on Heroku is a [Heroku](https://heroku.com/) buildpack for deploying [Haskell](https://haskell.org/) apps.

The buildpack uses [Halcyon](https://halcyon.sh/) to install apps and development tools, including [GHC](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/) and [Cabal](https://haskell.org/cabal/users-guide/).

This tutorial shows how to develop a simple Haskell web app and deploy it to Heroku.

<div><nav id="main-toc"></nav></div>


Set up
------

The tutorial assumes you’ve created a [Heroku account](https://signup.heroku.com/) and installed the [Heroku Toolbelt](https://toolbelt.heroku.com/):

```
$ which heroku
/usr/local/bin/heroku
```

You don’t need to install Haskell on your system to follow this tutorial, but if you want to do it, read the [Halcyon tutorial](https://halcyon.sh/tutorial/) first.


Prepare the app
---------------

The [tutorial app](https://github.com/mietek/haskell-on-heroku-tutorial) is a simple web service for storing notes, built with [Servant](http://haskell-servant.github.io/).

The app includes a Cabal _package description file,_ [`haskell-on-heroku-tutorial.cabal`](https://github.com/mietek/haskell-on-heroku-tutorial/blob/master/haskell-on-heroku-tutorial.cabal) file, used to declare dependencies, and a Halcyon _constraints file,_ [`.halcyon/constraints`](https://github.com/mietek/haskell-on-heroku-tutorial/blob/master/.halcyon/constraints) file, used to declare version constraints.

Clone the [_haskell-on-heroku-tutorial_ source repository](https://github.com/mietek/haskell-on-heroku-tutorial):

```
$ git clone https://github.com/mietek/haskell-on-heroku-tutorial
```

Create a new Heroku app with the `heroku create` command, using the `-b` option to specify the buildpack:

```
$ cd haskell-on-heroku-tutorial
$ heroku create -b https://github.com/mietek/haskell-on-heroku
Creating still-earth-4767... done, stack is cedar-14
BUILDPACK_URL=https://github.com/mietek/haskell-on-heroku
https://still-earth-4767.herokuapp.com/ | https://git.heroku.com/still-earth-4767.git
Git remote heroku added
```


### Options

By default, Heroku creates apps with randomly-generated names, such as `still-earth-4767`.

You can specify your own app name as an argument to `heroku create`, or rename the app later with the `heroku apps:rename` command:

```
$ heroku apps:rename example-name
```


Deploy the app
--------------

Push the code to Heroku in order to deploy your app:

<div class="toggle">
<a class="toggle-button" data-target="deploy-the-app-log" href="" title="Toggle">Toggle</a>
``` { #deploy-the-app-log .toggle }
$ git push -q heroku master
-----> Fetching custom git buildpack... done
-----> Haskell app detected


-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**

-----> Installing buildpack... done, 34a2e51
-----> Installing Halcyon... done, 0e8fd37
-----> Installing bashmenot... done, 167e265
-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **a1f7195**
       External storage:                         **public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-a1f7195-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-install-a1f7195-haskell-on-heroku-tutorial-1.0.tar.gz... done, 8.8MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> Examining cache changes
       + halcyon-install-a1f7195-haskell-on-heroku-tutorial-1.0.tar.gz

-----> App deployed:                             **haskell-on-heroku-tutorial-1.0**
       ...


-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 3.4MB
-----> Launching... done, v4
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
```
</div>

> ---------------------|---
> _Expected time:_     | _<1 minute_

In this step, Halcyon restores the tutorial app’s _install directory_ by extracting an archive downloaded from _public storage,_ which is an external cache for previously-built apps and dependencies.

All downloaded archives are cached in the Halcyon _cache directory,_ inside the Heroku [build cache](https://devcenter.heroku.com/articles/buildpack-api#caching).

The right archive to restore is determined by calculating a _source hash_ of the app’s _source directory._

Make sure your app is running:

```
$ heroku ps:scale web=1
Scaling dynos... done, now running web at 1:1X.
```

Your app is now ready to use.

You can visit the app in your web browser by using the `heroku open` command:

```
$ heroku open
Opening still-earth-4767... done
```

**Note:**  Warnings saying _“This app’s git repository is large”_ can be ignored, as they are a known Heroku issue.


View the logs
-------------

Heroku allows you to view the output of your app as a sequence of events, mixed with messages from other Heroku components.

The tutorial app exposes one HTTP endpoint, `/notes`, which accepts `GET` and `POST` requests.

Notes are JSON objects with a single text field, `contents`.  The app responds to each request with a list of all existing notes.

Use the `heroku logs` command with the `-t` option to start viewing the logs in one shell:

```
$ heroku logs -t
...
2015-01-25T09:24:33.751003+00:00 heroku[web.1]: State changed from starting to up
2015-01-25T09:24:40.087150+00:00 heroku[router]: at=info method=GET path="/" host=still-earth-4767.herokuapp.com request_id=2d9895dd-e31e-40d4-8b0a-f3835b4f653b fwd="192.168.144.120" dyno=web.1 connect=1ms service=2ms status=404 bytes=132
```

In another shell, make a `GET` request to see an empty list of notes:

```
$ curl https://still-earth-4767.herokuapp.com/notes
[]
```

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
2015-01-25T09:25:05.606819+00:00 heroku[router]: at=info method=GET path="/notes" host=still-earth-4767.herokuapp.com request_id=34f251cb-66d6-4bf8-a16a-64ad4dc1d352 fwd="192.168.144.120" dyno=web.1 connect=1ms service=3ms status=200 bytes=150
2015-01-25T09:25:09.527051+00:00 heroku[router]: at=info method=POST path="/notes" host=still-earth-4767.herokuapp.com request_id=cc4a444f-804b-4a4d-8737-05ebd7bc6868 fwd="192.168.144.120" dyno=web.1 connect=8ms service=11ms status=201 bytes=183
2015-01-25T09:25:09.526124+00:00 app[web.1]: Hello, world!
2015-01-25T09:25:13.085316+00:00 heroku[router]: at=info method=POST path="/notes" host=still-earth-4767.herokuapp.com request_id=8672db7e-ad15-4093-9ef4-f052971d39e7 fwd="192.168.144.120" dyno=web.1 connect=3ms service=4ms status=201 bytes=205
2015-01-25T09:25:13.085297+00:00 app[web.1]: Hello?
```

Press `control-C` to stop viewing the logs.


Configure the app
-----------------

Heroku lets you define [config vars](https://devcenter.heroku.com/articles/config-vars) to separate your app’s configuration data from the code.  At run-time, config vars are provided to the app as _environment variables._

You can check which config vars are currently defined by using the `heroku config` command:

```
$ heroku config
=== still-earth-4767 Config Vars
BUILDPACK_URL:       https://github.com/mietek/haskell-on-heroku
```

The tutorial app responds to `GET /` requests with a welcome message:

```
$ curl https://still-earth-4767.herokuapp.com/
"Welcome to Haskell on Heroku"
```

This message can be changed by setting the `TUTORIAL_HOME` environment variable:

```
$ grep -C1 Welcome Main.hs
    let port = maybe 8080 read $ lookup "PORT" env
        home = maybe "Welcome to Haskell on Heroku" T.pack $
                 lookup "TUTORIAL_HOME" env
```

Use the `heroku config:set` command to define `TUTORIAL_HOME`:

```
$ heroku config:set TUTORIAL_HOME="Hello, world!"
Setting config vars and restarting still-earth-4767... done, v5
TUTORIAL_HOME: Hello, world!
```

Your new welcome message is now ready to see:

```
$ curl https://still-earth-4767.herokuapp.com/
"Hello, world!"
```

Restore the default message with the `heroku config:unset` command:

```
$ heroku config:unset TUTORIAL_HOME
Unsetting TUTORIAL_HOME and restarting still-earth-4767... done, v6
```


Add a `Procfile`… or not
------------------------

Heroku expects you to include a [`Procfile`](https://devcenter.heroku.com/articles/procfile) declaring what command should be executed to start your app.

With Haskell on Heroku, this isn’t necessary.  If a `Procfile` isn’t included, the buildpack generates one at compile-time, based on the executable name declared in the Cabal package description file:

```
$ grep executable haskell-on-heroku-tutorial.cabal
executable haskell-on-heroku-tutorial
```

The generated `Procfile` declares a single process type, `web`:

```
web: bin/haskell-on-heroku-tutorial
```

Heroku requires the `web` process type to be declared, as only instances of this process can receive HTTP traffic from Heroku’s [routers](https://devcenter.heroku.com/articles/http-routing).


### Options

One `Procfile` can declare multiple process types, although Haskell apps rarely need to be composed of multiple processes.

The commands declared in a `Procfile` can include additional arguments and reference environment variables:

```
web: bin/example-app -p $PORT
```


Push a change
-------------

Let’s change the tutorial app so that each note can contain a timestamp.

The [`step2`](https://github.com/mietek/haskell-on-heroku-tutorial/tree/step2) version of the app includes a new `dateTime` field in each note.

Check out and deploy `step2`:

<div class="toggle">
<a class="toggle-button" data-target="push-a-change-log" href="" title="Toggle">Toggle</a>
``` { #push-a-change-log .toggle }
$ git checkout -q step2
$ git push -q heroku HEAD:master
-----> Fetching custom git buildpack... done
-----> Haskell app detected


-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**

-----> Installing buildpack... done, 34a2e51
-----> Installing Halcyon... done, 0e8fd37
-----> Installing bashmenot... done, 167e265
-----> Examining cache contents
       halcyon-install-a1f7195-haskell-on-heroku-tutorial-1.0.tar.gz

-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **0229215**
       External storage:                         **public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)

-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **0229215**
       Constraints hash:                         **f458aa8**
       Magic hash:                               **3bffeae**
       External storage:                         **public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz... done
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Locating Cabal directories
       Listing https://halcyon.global.ssl.fastly.net/... done
-----> Restoring Cabal directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done, 182MB

-----> Restoring sandbox directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done, 140MB

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
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
-----> Preparing install directory
-----> Installing extra data files for dependencies
-----> Install directory prepared, 8.8MB
-----> Archiving install directory
       Creating halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz... done, 2.0MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> Examining cache changes
       + halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz
       + halcyon-ghc-7.8.4.tar.gz
       - halcyon-install-a1f7195-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz

-----> App deployed:                             **haskell-on-heroku-tutorial-1.0**
       ...


-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 3.4MB
-----> Launching... done, v7
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
```
</div>

> ---------------------|---
> _Expected time:_     | _1–2 minutes_

In this step, Halcyon tries to restore the tutorial app’s install directory by using an archive from public storage.  This fails, and so Halcyon falls back to building the app:

1.  First, a _GHC directory_, a _Cabal directory_, and the app’s _sandbox directory_ are restored from public storage.

2.  Next, Halcyon restores the app’s _build directory_ from public storage, and performs an incremental build.

3.  Finally, the app’s new install directory is prepared and archived, and the app is installed.

Halcyon determines which sandbox archive to restore by calculating a _constraints hash_ of the version constraints declared by your app.  Similarly, the right version of GHC to use is implied by the `base` package constraint:

```
$ grep -E '^base-' .halcyon/constraints
base-4.7.0.2
```

Your app is now ready to use again:

```
$ curl -X POST https://still-earth-4767.herokuapp.com/notes -d '{ "contents": "Hello, world!" }'
[{"contents":"Hello, world!","dateTime":""}]
```


Scale the app
-------------

Heroku [dynos](https://devcenter.heroku.com/articles/dynos) are lightweight Linux containers, intended to run processes declared in your app’s `Procfile`.  There are three available [dyno sizes](https://devcenter.heroku.com/articles/dyno-size) — 1X, 2X, and PX.

Currently, your app is running on a single 1X dyno.  You can check this with the `heroku ps` command:

```
$ heroku ps
=== web (1X): `bin/haskell-on-heroku-tutorial`
web.1: up 2015/01/15 09:24:33 (~ 1m ago)
```

To increase your app’s throughput, and to prevent [dyno sleeping](https://devcenter.heroku.com/articles/dynos#dyno-sleeping), you can scale the app to more than one `web` dyno:

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

Heroku allows you to run commands on [one-off dynos](https://devcenter.heroku.com/articles/one-off-dynos) with the `heroku run` command.

Each dyno has its own transient filesystem, which includes the contents of your app’s [slug](https://devcenter.heroku.com/articles/slug-compiler).  Once the command finishes running, the dyno is shut down, and its filesystem is discarded.

Start a remote shell on a one-off dyno:

```
$ heroku run bash
Running `bash` attached to terminal... up, run.4012
~ $ ls
Main.hs  Procfile  README.md  app.json	bin  cabal.config  haskell-on-heroku-tutorial.cabal
```

For performance reasons, Haskell on Heroku does not include your app’s dependencies in the slug.  If you want to experiment with your app in [GHCi](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/ghci.html), you need to use the buildpack’s `restore` command:

<div class="toggle">
<a class="toggle-button" data-target="use-a-one-off-dyno-log" href="" title="Toggle">Toggle</a>
``` { #use-a-one-off-dyno-log .toggle }
~ $ restore
-----> Installing haskell-on-heroku-tutorial-1.0
-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **0229215**
       Constraints hash:                         **f458aa8**
       Magic hash:                               **3bffeae**
       External storage:                         **public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz... done
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Locating Cabal directories
       Listing https://halcyon.global.ssl.fastly.net/... done
-----> Restoring Cabal directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done, 182MB

-----> Restoring sandbox directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done, 140MB

-----> Restoring build directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 9.4MB

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-a1f7195-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz... done, 8.8MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> Examining cache changes
       + halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz
       + halcyon-ghc-7.8.4.tar.gz
       + halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz

-----> App restored:                             **haskell-on-heroku-tutorial-1.0**

       To run GHCi:
       $ cabal repl
```
</div>

> ---------------------|---
> _Expected time:_     | _<1 minute_

In this step, Halcyon restores all required directories by extracting archives downloaded from public storage.

Previously-cached archives can’t be used, because there is no access to the Heroku build cache from one-off dynos.

Start a GHCi session inside the remote shell:

```
~ $ cabal repl
GHCi, version 7.8.4: http://www.haskell.org/ghc/  :? for help
...
[1 of 1] Compiling Main             ( Main.hs, interpreted )
Ok, modules loaded: Main.
```

Your app’s code is now ready to use:

```
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

Press `control-D` twice to exit GHCi and shut down the dyno.


### Options

By default, Heroku runs one-off commands on 1X dynos.  You can specify another [dyno size](https://devcenter.heroku.com/articles/dyno-size) with the `-s` option:

```
$ heroku run -s PX bash
```


Declare a dependency
--------------------

Now, let’s change the tutorial app so that it remembers the time each note is added.

The [`step3`](https://github.com/mietek/haskell-on-heroku-tutorial/tree/step3) version of the app declares the standard Haskell [_old-locale_](http://hackage.haskell.org/package/old-locale) and [_time_](http://hackage.haskell.org/package/time) libraries as dependencies:

<div class="toggle">
<a class="toggle-button" data-target="declare-a-dependency-diff" href="" title="Toggle">Toggle</a>
``` { #declare-a-dependency-diff .toggle }
$ git diff step2 step3 haskell-on-heroku-tutorial.cabal
...
**@@ -14,9 +14,11 @@** executable haskell-on-heroku-tutorial
   ghc-options:        -O2 -Wall -threaded
   build-depends:      base,
                       aeson,
**+                      old-locale,**
                       servant,
                       servant-server,
                       stm,
                       text,
**+                      time,**
                       transformers,
                       warp
```
</div>

Check out and deploy `step3`:

<div class="toggle">
<a class="toggle-button" data-target="declare-a-dependency-log" href="" title="Toggle">Toggle</a>
``` { #declare-a-dependency-log .toggle }
$ git checkout -q step3
$ git push -q heroku HEAD:master
-----> Fetching custom git buildpack... done
-----> Haskell app detected


-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**

-----> Installing buildpack... done, 34a2e51
-----> Installing Halcyon... done, 0e8fd37
-----> Installing bashmenot... done, 167e265
-----> Examining cache contents
       halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz
       halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz
       halcyon-ghc-7.8.4.tar.gz
       halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz
       halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz

-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **188f30c**
       External storage:                         **public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-188f30c-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)

-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **188f30c**
       Constraints hash:                         **f458aa8**
       Magic hash:                               **3bffeae**
       External storage:                         **public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Restoring Cabal directory
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done, 182MB

-----> Restoring sandbox directory
       Extracting halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done, 140MB

-----> Restoring build directory
       Extracting halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 9.4MB
-----> Examining source changes
       * Main.hs
       * haskell-on-heroku-tutorial.cabal
-----> Configuring app
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
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-188f30c-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
-----> Preparing install directory
-----> Installing extra data files for dependencies
-----> Install directory prepared, 8.8MB
-----> Archiving install directory
       Creating halcyon-install-188f30c-haskell-on-heroku-tutorial-1.0.tar.gz... done, 2.0MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> Examining cache changes
       * halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-install-188f30c-haskell-on-heroku-tutorial-1.0.tar.gz
       - halcyon-install-0229215-haskell-on-heroku-tutorial-1.0.tar.gz

-----> App deployed:                             **haskell-on-heroku-tutorial-1.0**
       ...


-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 3.4MB
-----> Launching... done, v8
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
```
</div>

> ---------------------|---
> _Expected time:_     | _1–2 minutes_

In this step, Halcyon restores the GHC, Cabal, and sandbox directories from cache, performs an incremental build, and installs the app.

The previously-restored sandbox directory can be used again, because version constraints for our new dependencies are already declared:

```
$ grep -E '^(old-locale|time)' .halcyon/constraints
old-locale-1.0.0.6
time-1.4.2
```

Your app is now ready to use again:

```
$ curl -X POST https://still-earth-4767.herokuapp.com/notes -d '{ "contents": "Hello, world!" }'
[{"contents":"Hello, world!","dateTime":"2015-01-25T09:31:28Z"}]
```


Declare a constraint
--------------------

Let’s try to simplify the code by using a third-party library.

The [`step4`](https://github.com/mietek/haskell-on-heroku-tutorial/tree/step4) version of the app replaces _old-locale_ and _time_ with the [_hourglass_](http://hackage.haskell.org/package/hourglass) library:

<div class="toggle">
<a class="toggle-button" data-target="declare-a-constraint-diff" href="" title="Toggle">Toggle</a>
``` { #declare-a-constraint-diff .toggle }
$ git diff step3 step4 haskell-on-heroku-tutorial.cabal
...
**@@ -14,11 +14,10 @@** executable haskell-on-heroku-tutorial
   ghc-options:        -O2 -Wall -threaded
   build-depends:      base,
                       aeson,
**-                      old-locale,**
**+                      hourglass,**
                       servant,
                       servant-server,
                       stm,
                       text,
**-                      time,**
                       transformers,
                       warp
```
</div>

In order for Halcyon to provide the right sandbox directory, we need to declare version constraints for _hourglass_ and all of its dependencies.  You can determine these constraints using Halcyon.

Check out `step4`, and try deploying it:

<div class="toggle">
<a class="toggle-button" data-target="declare-a-constraint-log" href="" title="Toggle">Toggle</a>
``` { #declare-a-constraint-log .toggle }
$ git checkout -q step4
$ git push -q heroku HEAD:master
-----> Fetching custom git buildpack... done
-----> Haskell app detected


-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**

-----> Installing buildpack... done, 34a2e51
-----> Installing Halcyon... done, 0e8fd37
-----> Installing bashmenot... done, 167e265
-----> Examining cache contents
       halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz
       halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz
       halcyon-ghc-7.8.4.tar.gz
       halcyon-install-188f30c-haskell-on-heroku-tutorial-1.0.tar.gz
       halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz

-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **ba0aa48**
       External storage:                         **public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-ba0aa48-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)

-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **ba0aa48**
       Constraints hash:                         **f458aa8**
       Magic hash:                               **3bffeae**
       External storage:                         **public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Restoring Cabal directory
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done, 182MB

-----> Restoring sandbox directory
       Extracting halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done, 140MB
**   *** WARNING: Unexpected constraints difference**
       @@ -38,6 +38,7 @@
        free-4.10.0.1
        ghc-prim-0.3.1.0
        hashable-1.2.3.1
       +hourglass-0.2.8
        http-date-0.0.4
        http-types-0.8.5
        integer-gmp-0.5.1.0

-----> Restoring build directory
       Extracting halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 9.4MB
-----> Examining source changes
       * Main.hs
       * haskell-on-heroku-tutorial.cabal
-----> Configuring app
       ...
       Could not resolve dependencies:
       trying: haskell-on-heroku-tutorial-1.0 (user goal)
       next goal: hourglass (dependency of haskell-on-heroku-tutorial-1.0)
       Dependency tree exhaustively searched.
       Configuring haskell-on-heroku-tutorial-1.0...
       cabal: At least the following dependencies are missing:
       hourglass -any
**   *** ERROR: Failed to configure app**
**   *** ERROR: Failed to deploy app**

 !     Push rejected, failed to compile Haskell app
```
</div>

> ---------------------|---
> _Expected time:_     | _<1 minute_

In this step, Cabal fails to configure the app, because the _hourglass_ library isn’t provided in the existing sandbox directory.  Halcyon suggests adding a single version constraint, `hourglass-0.2.8`.

The [`step5`](https://github.com/mietek/haskell-on-heroku-tutorial/tree/step5) version of the app declares this constraint:

```
$ git diff -U1 step4 step5 .halcyon/constraints
...
**@@ -40,2 +40,3 @@** ghc-prim-0.3.1.0
 hashable-1.2.3.1
**+hourglass-0.2.8**
 http-date-0.0.4
```


Build the sandbox
-----------------

Halcyon always provides a sandbox directory matching the declared version constraints.  If needed, the sandbox directory is built on-the-fly — either from scratch, or based on a previously-built sandbox.

Heroku limits `git push` time to [15 minutes](https://devcenter.heroku.com/articles/slug-compiler#time-limit), and performs builds on a 1X dyno with [512 MB RAM](https://devcenter.heroku.com/articles/dyno-size).  For many Haskell apps, building a sandbox from scratch is impossible under these conditions.

By default, Haskell on Heroku does not allow dependencies to be built during a `git push`, in order to avoid wasting your time on builds which take 15 minutes to fail.  In this case, we expect the build to finish in less than 5 minutes, as we only need to add a single package to a previously-built sandbox.

Override the default by setting the [`HALCYON_NO_BUILD_DEPENDENCIES`](https://halcyon.sh/reference/#halcyon_no_build_dependencies) option to `0`:

```
$ heroku config:set HALCYON_NO_BUILD_DEPENDENCIES=0
Setting config vars and restarting still-earth-4767... done, v9
HALCYON_NO_BUILD_DEPENDENCIES: 0
```

Check out and install `step5`:

<div class="toggle">
<a class="toggle-button" data-target="build-the-sandbox-log" href="" title="Toggle">Toggle</a>
``` { #build-the-sandbox-log .toggle }
$ git checkout -q step5
$ git push -q heroku HEAD:master
-----> Fetching custom git buildpack... done
-----> Haskell app detected


-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**
       HALCYON_NO_BUILD_DEPENDENCIES:            **0**

-----> Installing buildpack... done, 34a2e51
-----> Installing Halcyon... done, 0e8fd37
-----> Installing bashmenot... done, 167e265
-----> Examining cache contents
       halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz
       halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz
       halcyon-ghc-7.8.4.tar.gz
       halcyon-install-188f30c-haskell-on-heroku-tutorial-1.0.tar.gz
       halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz

-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **57e9d9d**
       External storage:                         **public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-57e9d9d-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)

-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **57e9d9d**
       Constraints hash:                         **0551a64**
       Magic hash:                               **4877c9d**
       External storage:                         **public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Restoring Cabal directory
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done, 182MB

-----> Restoring sandbox directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-0551a64-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
-----> Locating sandbox directories
       Listing https://halcyon.global.ssl.fastly.net/... done
-----> Examining partially matching sandbox directories
       ...
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.constraints... done
-----> Scoring partially matching sandbox directories
       ...
       Ignoring hello-yesod-1.0 (1a1d740) as asn1-encoding-0.9.0 is not needed
       Ignoring hello-happstack-1.0 (3b0b768) as base-unicode-symbols-0.2.2.4 is not needed
       Ignoring hello-snap-1.0 (335d31e) as HUnit-1.2.5.2 is not needed
           101 haskell-on-heroku-tutorial-1.0 (f458aa8)
            41 hello-wai-1.0 (ffec23f)
-----> Using partially matching sandbox directory: haskell-on-heroku-tutorial-1.0 (f458aa8)
-----> Restoring sandbox directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-sandbox-f458aa8-haskell-on-heroku-tutorial-1.0.tar.gz... done, 140MB
-----> Building sandbox directory
-----> Building sandbox
       Resolving dependencies...
       Notice: installing into a sandbox located at /app/sandbox
       Downloading hourglass-0.2.8...
       Configuring hourglass-0.2.8...
       Building hourglass-0.2.8...
       Installed hourglass-0.2.8
-----> Sandbox built, 144MB
       Removing documentation from sandbox directory... done, 144MB
       Stripping sandbox directory... done, 143MB
-----> Archiving sandbox directory
       Creating halcyon-sandbox-0551a64-haskell-on-heroku-tutorial-1.0.tar.gz... done, 25MB

-----> Restoring build directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done
       Extracting halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 9.4MB
-----> Examining source changes
       * .halcyon/constraints
       * Main.hs
       * cabal.config
       * haskell-on-heroku-tutorial.cabal
-----> Configuring app
-----> Building app
       Building haskell-on-heroku-tutorial-1.0...
       Preprocessing executable 'haskell-on-heroku-tutorial' for
       haskell-on-heroku-tutorial-1.0...
       [1 of 1] Compiling Main             ( Main.hs, dist/build/haskell-on-heroku-tutorial/haskell-on-heroku-tutorial-tmp/Main.o )
       Linking dist/build/haskell-on-heroku-tutorial/haskell-on-heroku-tutorial ...
-----> App built, 13MB
       Stripping app... done, 9.8MB
-----> Archiving build directory
       Creating halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz... done, 2.2MB

-----> Restoring install directory
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-57e9d9d-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
-----> Preparing install directory
-----> Installing extra data files for dependencies
-----> Install directory prepared, 9.1MB
-----> Archiving install directory
       Creating halcyon-install-57e9d9d-haskell-on-heroku-tutorial-1.0.tar.gz... done, 2.0MB
-----> Installing app to /app
-----> Installed haskell-on-heroku-tutorial-1.0

-----> Examining cache changes
       * halcyon-build-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-install-57e9d9d-haskell-on-heroku-tutorial-1.0.tar.gz
       - halcyon-install-188f30c-haskell-on-heroku-tutorial-1.0.tar.gz
       + halcyon-sandbox-0551a64-haskell-on-heroku-tutorial-1.0.tar.gz

-----> App deployed:                             **haskell-on-heroku-tutorial-1.0**
       ...


-----> Discovering process types
       Procfile declares types -> web

-----> Compressing... done, 3.4MB
-----> Launching... done, v10
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
```
</div>

> ---------------------|---
> _Expected time:_     | _4–5 minutes_

In this step, Halcyon restores the GHC and Cabal directories from cache, and tries to locate the right sandbox directory for the current version of the app.  This fails, and so Halcyon falls back to building the sandbox:

1.  First, previously-built sandbox directories are located and assigned a score, which reflects the number of required dependencies within each sandbox.

2.  Next, Halcyon builds and archives a new sandbox, based on the highest-scoring _partially-matching_ sandbox directory.

3.  Finally, an incremental build is performed, and the app is installed.

Your app is now ready to use again:

```
$ curl -X POST http://localhost:8080/notes -d '{ "contents": "Hello, world!" }'
[{"contents":"Hello, world!","dateTime":"2015-01-25T09:28:26+00:00"}]
```


Set up private storage
----------------------

Halcyon can use _private storage_ as well as public storage.  Private storage is an external cache for the apps and dependencies you build.

By using private storage, you can share archives between multiple machines, and avoid running into the Heroku 15-minute build [time limit](https://devcenter.heroku.com/articles/slug-compiler#time-limit).

To use private storage, you’ll need to:

- Sign up for an [Amazon Web Services](http://aws.amazon.com/) account

- Create an [Amazon IAM user](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_SettingUpUser.html) and an [Amazon S3 bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html)

- Give the IAM user [permission to access](http://docs.aws.amazon.com/IAM/latest/UserGuide/PermissionsAndPolicies.html) the S3 bucket

Once you’re done, configure private storage by setting [`HALCYON_AWS_ACCESS_KEY_ID`](https://halcyon.sh/reference/#halcyon_aws_access_key_id),  [`HALCYON_AWS_SECRET_ACCESS_KEY`](https://halcyon.sh/reference/#halcyon_aws_secret_access_key), and [`HALCYON_S3_BUCKET`](https://halcyon.sh/reference/#halcyon_s3_bucket):

```
$ heroku config:set HALCYON_AWS_ACCESS_KEY_ID=example-access-key-id HALCYON_AWS_SECRET_ACCESS_KEY=example-secret-access-key HALCYON_S3_BUCKET=example-bucket
Setting config vars and restarting still-earth-4767... done, v11
HALCYON_AWS_ACCESS_KEY_ID:     example-access-key-id
HALCYON_AWS_SECRET_ACCESS_KEY: example-secret-access-key
HALCYON_S3_BUCKET:             example-bucket
```

If your S3 bucket isn’t located in the Amazon US Standard region, you’ll also need to set [`HALCYON_S3_ENDPOINT`](https://halcyon.sh/reference/#halcyon_s3_endpoint) to the address of the right [region-specific S3 endpoint](http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region):

```
$ heroku config:set HALCYON_S3_ENDPOINT=s3-example-region.amazonaws.com
Setting config vars and restarting still-earth-4767... done, v12
HALCYON_S3_ENDPOINT: s3-example-region.amazonaws.com
```


### Options

By default, all uploads are assigned the `private` [Amazon S3 ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html).  To make newly-uploaded files available to the public, set [`HALCYON_S3_ACL`](https://halcyon.sh/reference/#halcyon_s3_acl) to `public-read`:

```
$ heroku config:set HALCYON_S3_ACL=public-read
```


Use private storage
-------------------

Let’s force Halcyon to build the sandbox directory again, in order to populate your private storage.  Since we are using Heroku, we want the build to be performed on a one-off PX dyno.

Restore the default dependency build restriction:

```
$ heroku config:unset HALCYON_NO_BUILD_DEPENDENCIES
Unsetting HALCYON_NO_BUILD_DEPENDENCIES and restarting still-earth-4767... done, v13
```

Set the [`HALCYON_PURGE_CACHE`](https://halcyon.sh/reference/#halcyon_purge_cache) option to `1` in order to empty the cache directory before building:

```
$ heroku config:set HALCYON_PURGE_CACHE=1
Setting config vars and restarting still-earth-4767... done, v14
HALCYON_PURGE_CACHE: 1
```

Try forcing Heroku to deploy the same version of the app again:

<div class="toggle">
<a class="toggle-button" data-target="use-private-storage-log" href="" title="Toggle">Toggle</a>
``` { #use-private-storage-log .toggle }
$ git commit --amend --no-edit
$ git push -q -f heroku HEAD:master
-----> Fetching custom git buildpack... done
-----> Haskell app detected


-----> Welcome to Haskell on Heroku
       BUILDPACK_URL:                            **https://github.com/mietek/haskell-on-heroku**
       HALCYON_AWS_ACCESS_KEY_ID:                **(secret)**
       HALCYON_AWS_SECRET_ACCESS_KEY:            **(secret)**
       HALCYON_PURGE_CACHE:                      **1**
       HALCYON_S3_BUCKET:                        **example-bucket**

-----> Installing buildpack... done, 34a2e51
-----> Installing Halcyon... done, 0e8fd37
-----> Installing bashmenot... done, 167e265
-----> Purging cache

-----> Installing haskell-on-heroku-tutorial-1.0
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **57e9d9d**
       External storage:                         **private and public**
       GHC version:                              **7.8.4**

-----> Restoring install directory
       Downloading s3://dev.halcyon.sh/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-57e9d9d-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-install-57e9d9d-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)

-----> Determining constraints
       Label:                                    **haskell-on-heroku-tutorial-1.0**
       Prefix:                                   **/app**
       Source hash:                              **57e9d9d**
       Constraints hash:                         **0551a64**
       Magic hash:                               **4877c9d**
       External storage:                         **private and public**
       GHC version:                              **7.8.4**
       Cabal version:                            **1.20.0.3**
       Cabal repository:                         **Hackage**

-----> Restoring GHC directory
       Downloading s3://dev.halcyon.sh/linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz... 404 (not found)
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz... done
       Uploading s3://dev.halcyon.sh/linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz... done
       Extracting halcyon-ghc-7.8.4.tar.gz... done, 701MB

-----> Locating Cabal directories
       Listing s3://dev.halcyon.sh/?prefix=linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-... done
       Listing https://halcyon.global.ssl.fastly.net/?prefix=linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-... done
-----> Restoring Cabal directory
       Downloading s3://dev.halcyon.sh/linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... 404 (not found)
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done
       Uploading s3://dev.halcyon.sh/linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done
       Extracting halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz... done, 182MB

-----> Restoring sandbox directory
       Downloading s3://dev.halcyon.sh/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-0551a64-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
       Downloading https://halcyon.global.ssl.fastly.net/linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-0551a64-haskell-on-heroku-tutorial-1.0.tar.gz... 404 (not found)
-----> Locating sandbox directories
       Listing s3://dev.halcyon.sh/?prefix=linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-... done
       Listing https://halcyon.global.ssl.fastly.net/?prefix=linux-ubuntu-14.04-x86_64/ghc-7.8.4/halcyon-sandbox-... done
**   *** ERROR: Cannot build sandbox directory**
**   *** ERROR: Failed to deploy app**
**   *** ERROR: Deploying buildpack only**

       To continue, build the app on a one-off PX dyno:
       $ heroku run -s PX build

       Next, deploy the app:
       $ git commit --amend --no-edit
       $ git push -f heroku master


-----> Discovering process types
       Procfile declares types -> (none)

-----> Compressing... done, 130.1MB
-----> Launching... done, v15
       https://still-earth-4767.herokuapp.com/ deployed to Heroku
```
</div>

> ---------------------|---
> _Expected time:_     | _1–2 minutes_

In this step, Halcyon restores a Cabal directory and a Cabal directory by extracting archives downloaded from public storage, and tries to locate the right sandbox directory for the current version of the app.  This fails, and so Halcyon runs into the default dependency build restriction.

All downloaded archives are uploaded to your private storage:

```
$ s3_list example-bucket linux-ubuntu-14
       Listing s3://example-bucket/?prefix=linux-ubuntu-14... done
linux-ubuntu-14.04-x86_64/halcyon-cabal-1.20.0.3-hackage-2015-01-25.tar.gz
linux-ubuntu-14.04-x86_64/halcyon-ghc-7.8.4.tar.gz
```

It’s important to notice only _the buildpack_ is now deployed, and not your app.  This trick allows us to get around the Heroku 15-minute build [time limit](https://devcenter.heroku.com/articles/slug-compiler#time-limit).

Remember to unset [`HALCYON_PURGE_CACHE`](https://halcyon.sh/reference/#halcyon_purge_cache) before the next step:

```
$ heroku config:unset HALCYON_PURGE_CACHE
Unsetting HALCYON_PURGE_CACHE and restarting still-earth-4767... done, v16
```


### Options

If you want to avoid downloading any archives from public storage, set [`HALCYON_NO_PUBLIC_STORAGE`](https://halcyon.sh/reference/#halcyon_no_public_storage) to `1` before populating your private storage.


Provision an add-on
-------------------

_TODO_


Use a database
--------------

_TODO_


Next steps
----------

You now know how to use Haskell on Heroku to develop and deploy Haskell web apps.  You have also developed and deployed a simple Haskell web service.

Here’s some recommended reading:

- _TODO_

- _TODO_


---

_**Work in progress.**  For updates, follow <a href="https://twitter.com/mietek">@mietek</a>._
