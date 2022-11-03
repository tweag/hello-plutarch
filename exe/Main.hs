module Main where

import PlutusCore.Pretty (displayPlcDebug)
import Data.Default
import Plutarch (printTerm)

import Lib

main :: IO ()
main = do
  putStrLn $ printTerm def theValidator
