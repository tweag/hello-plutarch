{-# LANGUAGE TypeOperators #-}

module Lib where

import Data.Default (def)
import Data.Either.Combinators (fromRight')

import Plutarch (compile)
import Plutarch.Prelude
import Plutarch.Api.V1.Contexts
import Plutarch.Api.V1.Scripts
import PlutusLedgerApi.V1 (Script)

sayHello :: String -> IO ()
sayHello s = putStrLn $ "Hello, " <> s <> "!"

alwaysSucceeds :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
alwaysSucceeds = plam $ \datm redm ctx -> pconstant ()

alwaysSucceeds' :: Script
alwaysSucceeds' = fromRight' $ compile def alwaysSucceeds
