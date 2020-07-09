reverse :: [a] -> [a]
reverse [] = []                       -- (reverse.1)
reverse (x:xs) = reverse xs ++ [x]    -- (reverse.2)