-- Caso ([])
    foldl f e []    -- Caso ([])
        = e         -- Por (foldl.1)

    foldr (flip f) e (reverse [])    -- Caso ([])
        = foldr (flip f) e []        -- Por (reverse.1)
        = e                          -- Por (foldr.1)

-- Caso (x:xs)
    foldl f e (x:xs)                            -- Caso (x:xs)
        = foldl f (f e x) xs                    -- Por (foldl.2)
        = foldr (flip f) (f e x) (reverse xs)   -- Por hipótesis de inducción

    foldr (flip f) e (reverse (x:xs))
        = foldr (flip f) e (reverse xs ++ [x])                -- Por (reverse.2)
        = foldr (flip f) (foldr (flip g) e [x]) (reverse xs)  -- Por inciso (1.c)
        = foldr (flip f) (f e x) (reverse xs)                 -- Por (*)
    
    -- Teniendo que:
    foldl f e xs = foldr (flip f) e (reverse xs)    -- Q.E.D.

-- Donde:
    foldr (flip f) e [x] = f e x    -- (*)

    foldr (flip f) e [x]
        = (flip f) x (foldr (flip f) e [])    -- Por (foldr.2)
        = f (foldr (flip f) e []) x           -- Por (flip.1)
        = f e x                               -- Por (foldr.1)
