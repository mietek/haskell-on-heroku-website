---
title: Examples
page-class: add-section-toc
page-head: |
  <style>
    header a.link-examples {
      color: #ac5cf0;
    }
  </style>
---


Examples
========

_Work in progress._


Real-world examples
-------------------

Existing Haskell web applications, adapted to deploy with Halcyon.

Ready to deploy to Heroku in two clicks.


### _haskell-lang.org_

> ---------------------|---
> Author:              | …
> Framework:           | …
> Source:              | [_hl_](https://github.com/mietek/hl/tree/halcyon/)

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hl/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hl/tree/halcyon/">Deploy to Heroku</a></li>
</ul>
</nav>


### _tryhaskell.org_

> ---------------------|---
> Author:              | [Chris Done](https://github.com/chrisdone/tryhaskell/)
> Framework:           | [Snap](http://snapframework.com/) 0.9.6.3
> Source:              | [_tryhaskell_](https://github.com/mietek/tryhaskell/tree/halcyon/)

<nav>
<ul class="menu open">
<!-- <li><a href="examples/tryhaskell/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/tryhaskell/tree/halcyon/">Deploy to Heroku</a></li>
</ul>
</nav>


### _tryidris.org_

> ---------------------|---
> Author:              | …
> Framework:           | …
> Source:              | [_tryidris_](https://github.com/mietek/tryidris/tree/halcyon/)

<nav>
<ul class="menu open">
<!-- <li><a href="examples/tryidris/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/tryidris/tree/halcyon/">Deploy to Heroku</a></li>
</ul>
</nav>


### _try.purescript.org_

> ---------------------|---
> Author:              | [Phil Freeman](https://github.com/purescript/trypurescript/)
> Framework:           | [Scotty](https://github.com/scotty-web/scotty/) 0.9.0
> Source:              | [_trypurescript_](https://github.com/mietek/trypurescript/tree/halcyon/)

<nav>
<ul class="menu open">
<!-- <li><a href="examples/trypurescript/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/trypurescript/tree/halcyon/">Deploy to Heroku</a></li>
</ul>
</nav>


### _howistart.org_

> ---------------------|---
> Author:              | [Tristan Sloughter](https://github.com/howistart/howistart.org/)
> Framework:           | [Snap](http://snapframework.com/) 0.9.6.3
> Source:              | [_howistart.org_](https://github.com/mietek/howistart.org/tree/halcyon/)

<nav>
<ul class="menu open">
<!-- <li><a href="examples/howistart.org/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/howistart.org/tree/halcyon/">Deploy to Heroku</a></li>
</ul>
</nav>


### _gitit.net_

> ---------------------|---
> Author:              | [John MacFarlane](https://github.com/jgm/gitit/)
> Framework:           | [Happstack](http://happstack.com/) 7.3.9
> Source:              | [_gitit_](https://github.com/mietek/gitit/tree/halcyon/)

<nav>
<ul class="menu open">
<!-- <li><a href="examples/gitit/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/gitit/tree/halcyon/">Deploy to Heroku</a></li>
</ul>
</nav>


### _tryplayg.herokuapp.com_

> ---------------------|---
> Author:              | …
> Framework:           | …
> Source:              | [_tryhplay_](https://github.com/mietek/tryhplay/tree/halcyon/)

<nav>
<ul class="menu open">
<!-- <li><a href="examples/tryhplay/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/tryhplay/tree/halcyon/">Deploy to Heroku</a></li>
</ul>
</nav>


“Hello, world!” examples
------------------------

Simple programs, written to compare the options available to the Haskell web application developer.

Ready to deploy to Heroku in two clicks.


### _hello-happstack_

> ---------------------|---
> Framework:           | [Happstack](http://happstack.com/) Lite 7.3.5
> Dependencies:        | [44](https://github.com/mietek/hello-happstack/blob/master/cabal.config)
> Source:              | [_hello-happstack_](https://github.com/mietek/hello-happstack/)

```
import Happstack.Lite
import System.Environment

main :: IO ()
main = do
    env <- getEnvironment
    let port_ = maybe 8080 read $ lookup "PORT" env
        config = defaultServerConfig { port = port_ }
    serve (Just config) $
      ok $ toResponse "Hello, world!"
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-happstack/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-happstack/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-mflow_

> ---------------------|---
> Framework:           | [MFlow](https://github.com/agocorona/MFlow/) 0.4.5.9
> Dependencies:        | [106](https://github.com/mietek/hello-mflow/blob/master/cabal.config) and _cpphs_ 1.18.6
> Source:              | [_hello-mflow_](https://github.com/mietek/hello-mflow/)

```
import MFlow.Wai.Blaze.Html.All

main :: IO ()
main =
    runNavigation "hello" $ transientNav $
      page $ "Hello, world!" ++> empty
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-mflow/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-mflow/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-miku_

> ---------------------|---
> Framework:           | [_miku_](https://github.com/nfjinjing/miku/) 2014.5.19
> Dependencies:        | [59](https://github.com/mietek/hello-miku/blob/master/cabal.config)
> Source:              | [_hello-miku_](https://github.com/mietek/hello-miku/)

```
import Network.Miku
import Hack2.Handler.SnapServer
import System.Environment

main :: IO ()
main = do
    env <- getEnvironment
    let port_ = maybe 8080 read $ lookup "PORT" env
    runWithConfig (ServerConfig port_) . miku $
      get "/" (text "Hello, world!")
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-miku/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-miku/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-scotty_

> ---------------------|---
> Framework:           | [Scotty](https://github.com/scotty-web/scotty/) 0.9.0
> Dependencies:        | [74](https://github.com/mietek/hello-scotty/blob/master/cabal.config)
> Source:              | [_hello-scotty_](https://github.com/mietek/hello-scotty/)

```
import System.Environment
import Web.Scotty

main :: IO ()
main = do
    env <- getEnvironment
    let port = maybe 8080 read $ lookup "PORT" env
    scotty port $
      get "/" $ text "Hello, world!"
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-scotty/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-scotty/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-simple_

> ---------------------|---
> Framework:           | [Simple](http://simple.cx/) 0.10.0.2
> Dependencies:        | [70](https://github.com/mietek/hello-simple/blob/master/cabal.config)
> Source:              | [_hello-simple_](https://github.com/mietek/hello-simple/)

```
import Network.Wai.Handler.Warp
import System.Environment
import Web.Simple

app :: (Application -> IO ()) -> IO ()
app runner = do
    runner $ controllerApp () $ do
      routeTop $ respond $
        ok "text/plain" "Hello, world!"

main :: IO ()
main = do
    env <- getEnvironment
    let port = maybe 8080 read $ lookup "PORT" env
    app (run port)
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-simple/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-simple/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-snap_

> ---------------------|---
> Framework:           | [Snap](http://snapframework.com/) 0.9.6.3
> Dependencies:        | [42](https://github.com/mietek/hello-snap/blob/master/cabal.config)
> Source:              | [_hello-snap_](https://github.com/mietek/hello-snap/)

```
import Snap.Core
import Snap.Http.Server
import System.Environment

main :: IO ()
main = do
    env <- getEnvironment
    let port = maybe 8080 read $ lookup "PORT" env
        config = setPort port
               . setAccessLog ConfigNoLog
               . setErrorLog ConfigNoLog
               $ defaultConfig
    httpServe config $
      ifTop $ writeBS "Hello, world!"
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-snap/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-snap/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-spock_

> ---------------------|---
> Framework:           | [Spock](https://github.com/agrafix/Spock/) 0.7.4.0
> Dependencies:        | [80](https://github.com/mietek/hello-spock/blob/master/cabal.config)
> Source:              | [_hello-spock_](https://github.com/mietek/hello-spock/)

```
import System.Environment
import Web.Spock.Safe

main :: IO ()
main = do
    env <- getEnvironment
    let port = maybe 8080 read $ lookup "PORT" env
    runSpock port $ spockT id $
      get "/" $ text "Hello, world!"
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-spock/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-spock/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-wai_

> ---------------------|---
> Framework:           | [WAI](https://hackage.haskell.org/package/wai/) 3.0.2
> Dependencies:        | [38](https://github.com/mietek/hello-wai/blob/master/cabal.config)
> Source:              | [_hello-wai_](https://github.com/mietek/hello-wai/)

```
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp
import System.Environment

app :: Application
app _ respond =
    respond $
      responseLBS status200
        [("Content-Type", "text/plain")]
        "Hello, world!"

main :: IO ()
main = do
    env <- getEnvironment
    let port = maybe 8080 read $ lookup "PORT" env
    run port app
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-wai/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-wai/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-wheb_

> ---------------------|---
> Framework:           | [Wheb](https://github.com/hansonkd/Wheb-Framework/) 0.3.1.0
> Dependencies:        | [98](https://github.com/mietek/hello-wheb/blob/master/cabal.config)
> Source:              | [_hello-wheb_](https://github.com/mietek/hello-wheb/)

```
import System.Environment
import Web.Wheb

main :: IO ()
main = do
    env <- getEnvironment
    let port = maybe (8080 :: Int) read
             $ lookup "PORT" env
    opts <- genMinOpts $ do
      addGET "." rootPat $ (text "Hello, world!")
      addSetting' "port" port
    runWhebServer opts
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-wheb/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-wheb/">Deploy to Heroku</a></li>
</ul>
</nav>


### _hello-yesod_

> ---------------------|---
> Framework:           | [Yesod](http://www.yesodweb.com/) 1.4.0
> Dependencies:        | [145](https://github.com/mietek/hello-yesod/blob/master/cabal.config)
> Source:              | [_hello-yesod_](https://github.com/mietek/hello-yesod/)

```
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

import System.Environment
import Yesod

data Hello = Hello

mkYesod "Hello" [parseRoutes|/ HomeR GET|]

instance Yesod Hello

getHomeR :: Handler String
getHomeR = return "Hello, world!"

main :: IO ()
main = do
    env <- getEnvironment
    let port = maybe 8080 read $ lookup "PORT" env
    warp port Hello
```

<nav>
<ul class="menu open">
<!-- <li><a href="examples/hello-yesod/">Learn more</a></li> -->
<li><a href="https://heroku.com/deploy?template=https://github.com/mietek/hello-yesod/">Deploy to Heroku</a></li>
</ul>
</nav>
