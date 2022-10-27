module Main where

import PlutusLedgerApi.V1.Scripts (Script(..))
import PlutusCore.Pretty (displayPlcDebug)
import Data.Default
import Plutarch (printTerm)

import Lib

main :: IO ()
main = do
  putStrLn $ printTerm def theValidator
