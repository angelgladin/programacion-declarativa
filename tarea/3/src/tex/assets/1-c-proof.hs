-- Caso ([])
    foldr f e ([] ++ ys)    -- Caso ([])
        = foldr f e ys      -- Por ((++).1)

    foldr f (foldr f e ys) []    -- Caso ([])
        = foldr f e ys           -- Por (foldr.1)

    -- Teniendo que se cumple el caso ([]) por la igualdad anterior.

-- Caso (x:xs)
    foldr f e ((x:xs) ++ ys)                 -- Caso (x:xs)
        = foldr f e (x : (xs ++ ys))         -- Por ((++).2) 
        = f x (foldr f e (xs ++ ys))         -- Por (foldr.2) 
        = f x (foldr f e (xs ++ ys))         -- Por (foldr.2) 
        = f x (foldr f (foldr f e ys) xs)    -- Por hipótesis de inducción
        = foldr f (foldr f e ys) x           -- Por (foldr.2)
