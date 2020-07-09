scan r f e = map (foldr f e) . tails
