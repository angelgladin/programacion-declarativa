reverse :: [a] -> [a]
reverse = foldl (flip (:)) []    -- (reverse.1)
