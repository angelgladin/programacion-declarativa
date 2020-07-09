-- |
-- Author : Ángel Iván Gladín García
--

module Goldbach where

import Control.Monad (guard)
import Data.List

primesTo m = sieve [2 .. m]

  where sieve (x : xs) = x : sieve (xs \\ [x, x + x .. m])
        sieve [] = []

goldbach n
  = (primesTo n) >>=
      \ i ->
        (primesTo n) >>=
          \ j ->
            (primesTo n) >>= \ k -> guard (i + j + k == n) >> return (i, j, k)

goldbachD :: Int -> [(Int, Int, Int)]
goldbachD n
  = do i <- primesTo n
       j <- primesTo n
       k <- primesTo n
       guard (i + j + k == n)
       return (i, j, k)
