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
import Plutarch.Api.V2 (KeyGuarantees (..), AmountGuarantees (..))

alwaysSucceeds :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
alwaysSucceeds = plam $ \datm redm ctx -> pconstant ()

-- An empty Plutarch record
type PEmptyRec s = Term s (PDataRecord '[  ])

data PLotteryRedeemer (s :: S)
  = Initialise (PEmptyRec s)
  | Bid (PEmptyRec s)
  | Reveal (PEmptyRec s)
  | Compute (PEmptyRec s)
  | Claim (PEmptyRec s)
  | Restart (PEmptyRec s)
  deriving stock (Generic)
  deriving anyclass (PlutusType, PIsData)
instance DerivePlutusType (PLotteryRedeemer) where type DPTStrat _ = PlutusTypeData

type MainMode =
  PDataRecord
    '[ "secret" ':= PString -- ^ Either hash or clear
     , "deadlineBid" ':= PPOSIXTime
     , "bidValue" ':= PValue 'Sorted 'Positive
     , "currency" ':= PCurrencySymbol
     -- Only useful from phase 2 onwards
     , "deadlineCompute" ':= PPOSIXTime
     , "deadlineClaim" ':= PPOSIXTime
     , "totalScore" ':= PInteger ]

type CertificateMode =
  PDataRecord
    '[ "mainLottery" ':= PTokenName -- ^ The NFT of the associated lottery
     , "guessOrScore" ':= PEither PString PInteger
     -- ^ REVIEW: The expected type is always known, could we get rid
     -- of the constructors (union type-ish)
     ]

data PLotteryDatum s
  = Main ( Term s MainMode )
  | Certificate ( Term s CertificateMode )
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
