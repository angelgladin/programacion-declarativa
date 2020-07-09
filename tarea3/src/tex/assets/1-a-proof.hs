-- Caso ([])
    (foldr f e . map g) []       -- Caso ([])
        = foldr f e (map g [])   -- Aplicación de función
        = foldr f e []           -- Por (map.1)
        = e                      -- Por (foldr.1)

    foldr (f . g) e []           -- Caso ([])
        = e

-- Caso (x:xs)
    (foldr f e . map g) (x:xs)                 -- Caso (x:xs)
        = foldr f e (map g (x:xs))             -- Aplicación de función
        = foldr f e ((g x) : (map g xs)))      -- Por (map.2)
        = f (g x) (foldr f e (map g xs))       -- Por (foldr.2)
        = f (g x) ((foldr f e . map g) xs))    -- Composición de funciones
        = f (g x) ((foldr (f . g) e) xs))      -- Hipótesis de inducción
        = f (g x) (foldr (f . g) e xs)         -- Aplicación de función
        = (f . g) x (foldr (f . g) e xs)       -- Composición de función
        = foldr (f . g) e (x:xs)               -- Por (foldr.2)
