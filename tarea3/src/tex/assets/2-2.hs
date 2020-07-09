foldT :: (b -> a -> b -> b) -> b -> Tree a -> b
foldT _ v Void = v
foldT f v (Node t1 r t2) = f t1' r t2'
    where t1' = foldT f v t1
          t2' = foldT f v t2