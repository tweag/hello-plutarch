{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}

module Lib where

import qualified GHC.Generics as GHC

import Plutarch.Prelude
import Plutarch.Api.V1.Contexts (PScriptContext)
import Plutarch.Api.V1.Scripts (PRedeemer, PDatum)
import Plutarch.Api.V1 (PCurrencySymbol, PTokenName, PValue, PPOSIXTime)
import PlutusLedgerApi.V1 (Script)
import Plutarch.Api.V2 (PPubKeyHash, KeyGuarantees (..), AmountGuarantees (..))

-- An empty Plutarch record
type PEmptyRec s = Term s (PDataRecord '[  ])

data PLotteryRedeemer (s :: S)
  = Initialise (PEmptyRec s)
  | Play (PEmptyRec s)
  | Resolve (Term s (PDataRecord '[ "_0" ':= PString ]))
  deriving stock (Generic)
  deriving anyclass (PlutusType, PIsData)
instance DerivePlutusType (PLotteryRedeemer) where type DPTStrat _ = PlutusTypeData

data PLotteryDatum (s :: S) = PLotteryDatum (Term s (PDataRecord
        '[ "secretHash" ':= PString
         , "deadline" ':= PPOSIXTime
         , "valueToPlay" ':= PValue 'Sorted 'Positive
         , "players" ':= PList (PBuiltinPair PPubKeyHash PString) ]
        ))
  deriving stock (Generic)
  deriving anyclass (PlutusType, PIsData)
instance DerivePlutusType (PLotteryDatum) where type DPTStrat _ = PlutusTypeData

theValidator
  :: Term s (PAsData PLotteryDatum
             :--> PAsData PLotteryRedeemer
             :--> PAsData PScriptContext
             :--> POpaque)
theValidator = plam $ \datum redeemer ctx ->
  pmatch (pfromData redeemer) (\l ->
    case l of
      Initialise _ -> popaque $ pconstant True
      _ -> popaque $ pconstant True)
