map :: (a -> b) -> [a] -> [b]
map f []     = []                -- (map.1)
map f (x:xs) = f x : map f xs    -- (map.2)