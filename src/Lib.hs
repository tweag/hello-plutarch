{-# LANGUAGE TypeOperators #-}

module Lib where

import qualified GHC.Generics as GHC

import Plutarch.Prelude
import Plutarch.Api.V2.Contexts (PScriptContext)
import Plutarch.Api.V1.Scripts (PRedeemer, PDatum)

alwaysSucceeds :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
alwaysSucceeds = plam $ \datm redm ctx -> pconstant ()
