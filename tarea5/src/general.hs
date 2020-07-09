-- |
-- Author : Ángel Iván Gladín García
--

module GeneralTree
    -- * Trees
  ( Gtree(..)
  , BT(..)
    -- * Querying
  , size
  , depth
  , searchg
    -- * Construction
  , tran
    -- * Consuming
  , foldg
    -- * Transforming
  , mapg
  ) where

-- | A general tree is a structure holding multiples branches in every node.
data Gtree a =
  Node a [Gtree a]
  deriving (Show)

-- | A simple binary tree.
data BT a
  = Leaf
  | BNode (BT a) a (BT a)
  deriving (Show)

-- | Returns the number of elements in a 'Gtree'.
size :: Gtree a -> Int
size = go
  where
    go (Node x xs) =
      case xs of
        [] -> 1
        _ -> 1 + sum (map go xs)

-- | Returns the depth (number of levels) in a 'Gtree'.
depth :: Gtree a -> Int
depth = go
  where
    go (Node x xs) =
      case xs of
        [] -> 1
        _ -> 1 + maximum (map go xs)

-- Transforms a general tree into a binary tree.
--
-- Follows the divide-and-conquer strategy, splitting a list into two halves,
-- taking the element in the middle as root, and the first half as the left subtree
-- and the other half in the right.
--
-- Trying to make a binary tree as complete as possible.
tran :: Gtree a -> BT a
tran = createBT . flatten
  where
    createBT :: [a] -> BT a
    createBT [] = Leaf
    createBT xs = BNode (createBT front) x (createBT back)
      where
        n = length xs
        (front, x:back) = splitAt (n `div` 2) xs

-- | Follows the same behavior based on 'map' function in lists.
mapg :: (a -> b) -> Gtree a -> Gtree b
mapg f (Node x xs) = Node (f x) (map (mapg f) xs)

-- | Fold over a tree.
-- What is the pattern that encapsulates the 'foldg' function?
-- The 'foldr' pattern.
foldg :: (a -> [b] -> b) -> Gtree a -> b
foldg f = go
  where
    go (Node x xs) = f x (map go xs)

-- | Checks if a elements is contained in the general tree.
searchg :: (Eq a) => a -> Gtree a -> Bool
searchg x t =
  let xs = flatten t
   in x `elem` xs

-- | Flats a general tree in a list.
flatten :: Gtree a -> [a]
flatten (Node x xs) = x : concatMap flatten xs
