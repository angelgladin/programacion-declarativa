-- Ángel Iván Gladín García

module Rep_2 where

-- | 'todos' Decide si todos los elementos de una lista cumplen un predicado.
--
-- > todos (== 0) [0,0,0] = True
--
todos :: (a -> Bool) -> [a] -> Bool
todos p = and . map p

-- | 'alguno' Decide si al menos un elemento de una lista cumple un predicado.
--
-- > todos (== 0) [0,1,2] = True
--
alguno :: (a -> Bool) -> [a] -> Bool
alguno p = or . map p

-- | 'toma' Selecciona elementos de una lista mientas cumplan un predicado (equivalente a
-- takeWhile del preludio).
toma :: (a -> Bool) -> [a] -> [a]
toma _ [] = []
toma p (x:xs)
  | p x = x : toma p xs
  | otherwise = []

-- | 'deja' elimina elementos de una lista mientas cumplan el predicado.
deja :: (a -> Bool) -> [a] -> [a]
deja _ [] = []
deja f (x:xs)
  | f x = deja f xs
  | otherwise = x : xs

-- | 'altMap' que aplica alternadamente las funciones que recibe como argumentos a
-- los elementos de la lista, en otras palabras a los elementos en posiciones pares
-- les aplica la primera funci ́on mientras que a los elementos en posiciones impares
-- les aplica la segunda
--
-- > altMap (+10) (+100) [0,1,2,3,4] == [10 ,101 ,12 ,103 ,14]
--
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ [] = []
altMap f g (x:xs) = f x : altMap g f xs

-- | 'luhn' Algoritmo de Luhn para verificar si una tarjeta es válida.
--
-- > luhn [3,3,7,9,5,1,3,5,6,1,1,0,8,7,9,5] == True
--
luhn :: [Int] -> Bool
luhn = mod10 . sum . (altMap f id)
  where
    mod10 x = x `mod` 10 == 0
    f x =
      let n = x * 2
       in if n > 9
            then n - 9
            else n
