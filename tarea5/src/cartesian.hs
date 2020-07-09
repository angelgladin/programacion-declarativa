-- |
-- Author : Ángel Iván Gladín García
--

module CartesianTree
    -- * Trees
  ( CartT(..)
    -- * Construction
  , cart
    -- * Consuming
  , inorder
  ) where

-- | A simple binary tree.
data CartT a
  = Void
  | Node (CartT a) a (CartT a)
  deriving (Show)

-- | Builds a cartesian tree from a given list following this algorithm
-- https://iq.opengenus.org/cartesian-tree/a
cart :: (Ord a) => [a] -> CartT a
cart = build . indexed
  where
    build :: Ord a => [(a, Int)] -> CartT a
    build [] = Void
    build xs =
      let root = minimum xs
          left = take (snd root) xs
          right = drop (succ $ snd root) xs
       in Node (build $ reIndex left) (fst root) (build $ reIndex right)
    indexed :: (Num b, Enum b) => [a] -> [(a, b)]
    indexed = flip zip [0 ..]
    reIndex :: (Num b1, Enum b1) => [(a, b2)] -> [(a, b1)]
    reIndex = indexed . fst . unzip

-- | Returns a list of the tree elements in an inorder fashion.
-- Must asserts that:
-- >>> inorder (cart xs) == xs
inorder :: CartT a -> [a]
inorder Void = []
inorder (Node l x r) = inorder l ++ [x] ++ inorder r
