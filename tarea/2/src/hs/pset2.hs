import Data.List (nub, sort)

gtrPower2 :: Int -> Int
gtrPower2 n = maximum $ takeWhile (< n) $ map (2 ^) [1 ..]

inarow :: (Eq a) => [a] -> Int
inarow xs = maximum $ map length $ split xs []
  where
    split :: (Eq a) => [a] -> [[a]] -> [[a]]
    split (x:xs) [] = split xs [[x]]
    split (x:xs) yys@(ys:yss) =
      split xs $
      if x == (head ys)
        then (x : ys) : yss
        else [x] : yys
    split [] acc = acc

ramanujan :: Int -> [(Int, Int, Int, Int)]
ramanujan n =
  let allDistincts xs = (length xs) == (length $ nub xs)
      allTuples =
        [ sort xs
        | a <- [1 .. n]
        , b <- [1 .. n]
        , c <- [1 .. n]
        , d <- [1 .. n]
        , a ^ 3 + b ^ 3 == c ^ 3 + d ^ 3
        , let xs = [a, b, c, d]
        , allDistincts xs
        ]
   in map (\[a, b, c, d] -> (a, b, c, d)) $ nub allTuples
