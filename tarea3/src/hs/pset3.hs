module Pset3 where

-------------
----  1  ----
-------------
concat' :: [[a]] -> [a]
concat' = foldr (++) []

minimum' :: (Ord a) => [a] -> a
minimum' [] = error "empty list"
minimum' (x:xs) = foldr min x xs

reverse' :: [a] -> [a]
reverse' = foldr (\x xs -> xs ++ [x]) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' p =
  foldr
    (\x xs ->
       if p x
         then (x : xs)
         else xs)
    []

inits' :: [a] -> [[a]]
inits' = foldr (\x xs -> [] : map (x :) xs) [[]]

-------------
----  2  ----
-------------
foldi :: (a -> a) -> a -> Int -> a
foldi f q 0 = q
foldi f q i = f (foldi f q (pred i))

add :: Int -> Int -> Int
add a b = foldi (+ 1) a b

mult :: Int -> Int -> Int
mult a b = foldi (+ a) 0 b

expt :: Int -> Int -> Int
expt a b = foldi (* a) 1 b

-------------
----  3  ----
-------------
sumq :: Int -> Int
sumq n = foldl (\a b -> a + b ^ 2) 0 [0 .. n - 1]

remove :: (Eq a) => [a] -> [a] -> [a]
remove xs ys =
  foldr
    (\z zs ->
       if z `elem` xs
         then zs
         else z : zs)
    []
    ys

remdups :: (Eq a) => [a] -> [a]
remdups = foldr adj []
  where
    adj :: (Eq a) => a -> [a] -> [a]
    adj x [] = [x]
    adj x xs =
      if x == head xs
        then xs
        else x : xs

rotate :: [a] -> [[a]]
rotate xs = scanl (\x _ -> shift x) xs $ take (length xs - 1) (cycle xs)
  where
    shift :: [a] -> [a]
    shift [] = []
    shift (x:xs) = xs ++ [x]

-------------
----  4  ----
-------------
unmerge :: [a] -> [([a], [a])]
unmerge [x, y] = [([x], [y]), ([y], [x])]
unmerge (x:xs) = [([x], xs), (xs, [x])] ++ concatMap (add' x) (unmerge xs)
  where
    add' x (ys, zs) = [(x:ys, zs), (ys, x:zs)]
