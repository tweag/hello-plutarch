module Main where

import PlutusLedgerApi.V1.Scripts (Script(..))
import PlutusCore.Pretty (displayPlcDebug)

import Lib

main :: IO ()
main = do
  sayHello "Plutarch"
  putStrLn $ displayPlcDebug $ unScript alwaysSucceeds'
