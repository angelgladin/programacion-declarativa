scan r f e = map (foldr f e) . tails

-- Caso ([])
    scan r f []    -- Caso ([])
        = [e]

-- Caso (x:xs)
    scan r f e (x:xs)                                    -- Caso (x:xs)
        = map (foldr f e) (tails (x:xs))                 -- Por especificación
        = map (foldr f e) ((x:xs):tails xs)              -- Por (tails.2)
        = foldr f e (x:xs):map (foldr f e) (tails xs)    -- Por (map.2)
        = f x (foldr f e xs):scan f e xs                 -- Por (foldr.2) y especific.
        = f x (head ys):ys where ys = scanr f e xs       -- Afirmando que:
                                                -- `foldr f e xs = head (scanr f e xs)`