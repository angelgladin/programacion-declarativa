-- |
-- Author : Ángel Iván Gladín García
--

module ExpressionEvaluator where

data Log a = Log{value :: a, logs :: [String]}
               deriving (Show)

instance Functor Log where
        fmap f (Log x logs) = Log (f x) logs

instance Applicative Log where
        pure x = Log x []
        Log f log <*> Log x log' = Log (f x) (log ++ log')

instance Monad Log where
        return = pure
        (Log x log) >>= f = let Log y new = f x in Log y (log ++ new)

gcdlog :: Int -> Int -> Log Int
gcdlog x y
  | x < y =
    do Log () ["swap(" ++ show y ++ "," ++ show x ++ ")"]
       gcdlog y x
  | y == 0 =
    do Log () ["gcd=" ++ show x]
       return x
  | otherwise =
    do Log () [" mod(" ++ show y ++ ", " ++ show x ++ ")=" ++ show (x `mod` y)]
       gcdlog y (x `mod` y)
