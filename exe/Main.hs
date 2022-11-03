module Main where

import Data.Default
import Plutarch (printTerm)

import Lib

main :: IO ()
main = do
  putStrLn $ printTerm def alwaysSucceeds
