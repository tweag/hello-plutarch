{-# LANGUAGE TypeOperators #-}

module Lib where

import Plutarch.Prelude
import Plutarch.Api.V1.Contexts
import Plutarch.Api.V1.Scripts
sayHello :: String -> IO ()
sayHello s = putStrLn $ "Hello, " <> s <> "!"

alwaysSucceeds :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
alwaysSucceeds = plam $ \datm redm ctx -> pconstant ()
