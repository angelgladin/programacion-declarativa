foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _ v [] = v                         -- (foldl.1)
foldl f v (x:xs) = foldl f (f v x) xs    -- (foldl.2)
