tails :: [a] -> [[a]]
tails [] = [[]]                   -- (tails.1)
tails (x:xs) = (x:xs):tails xs    -- (tails.2)