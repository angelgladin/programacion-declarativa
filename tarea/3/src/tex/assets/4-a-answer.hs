-- `f` es: 
op xs xss = [x:ys | x <- xs, ys <- xss]

-- `e` es:
[[]]

-- Teniendo así que:
cp = foldr op [[]]
    where op xs xss = [x:ys | x <- xs, ys <- xss]
