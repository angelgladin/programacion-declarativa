foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ v [] = v                         -- (foldr.1)
foldr f v (x:xs) = f x (foldr f v xs)    -- (foldr.2)
