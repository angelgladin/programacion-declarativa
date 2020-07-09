-- Ángel Iván Gladín García

module Rep_3 where

import Data.Char (digitToInt, intToDigit)
import Numeric (showIntAtBase)

factorial :: Int -> Int
factorial n = foldl (*) 1 [1 .. n]

digits :: Int -> [Int]
digits = map digitToInt . show

--
-- > factorion 145 = 1! + 4! + 5! = 145
--
factorion :: Int -> Int
factorion = foldl (\x y -> x + (factorial y)) 0 . digits

--
-- > iflip 1720 = 271
--
iflip :: Int -> Int
iflip = foldl (\x y -> 10 * x + y) 0 . parse
  where
    parse = dropWhile (== 0) . reverse . digits

-- > binarios [1..4] = [0, 1, 10, 11, 100]
--
binarios :: [Int] -> [Int]
binarios = foldr (\x y -> (binStrToInt x) : y) []
  where
    intToBinStr x = showIntAtBase 2 intToDigit x ""
    binStrToInt s = (read (intToBinStr s) :: Int)

isTriangular = isInt . triangularNumberFormula
  where
    isInt n = ceiling n == floor n
    triangularNumberFormula x = (sqrt ((x * 8) + 1) - 1) / 2

--
-- > triangulares [1..6] = [1, 3, 6]
--
triangulares =
  foldr
    (\x xs ->
       if isTriangular x
         then (doubleToInt x) : xs
         else xs)
    [] .
  map intToDouble
  where
    intToDouble n = fromInteger n :: Double
    doubleToInt n = round n :: Int
