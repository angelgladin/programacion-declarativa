concat :: [[a]] -> [a]
concat _ = []

minimum :: (Ord a) => [a] -> a
minimum _ = error ""

reverse :: [a] -> [a]
reverse _ = []

filter :: (a -> Bool) -> [a] -> [a]
filter _ _ = []

inits :: [a] -> [[a]]
inits _ = []

foldi :: (a -> a) -> a -> Int -> a
foldi f q 0 = q
foldi f q i = f (foldi f q (pred i))

sumq :: Int -> Int
sumq _ = 1

remove :: (Eq a) => [a] -> [a] -> [a]
remove _ _ = []

remdups :: (Eq a) => [a] -> [a]
remdups _ = []

rotate :: [a] -> [[a]]
rotate _ = []

unmerge :: (Ord a) => [a] -> [([a], [a])]
unmerge _ = []
--unmerge xs = [(ys,zs) | merge ys zs == xs ...
