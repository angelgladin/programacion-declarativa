import Data.Char


-------------
-- Strings --
-------------

quitaMayusculas :: [Char] -> [Char]
quitaMayusculas xs = [x | x <- xs, (not . isUpper) x]

soloLetras :: [Char] -> [Char]
soloLetras xs = [x | x <- xs, isAlpha x]

prefijo :: (Eq a) => [a] -> [a] -> Bool
prefijo [] _ = True
prefijo _ [] = False
prefijo (x:xs) (y:ys) = x == y && prefijo xs ys

----------------
-- Merge Sort --
----------------

mergeSort :: (Ord a) => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = mezcla (mergeSort f) (mergeSort s)
  where
    (f, s) = parte xs

parte :: [a] -> ([a], [a])
parte xs = splitAt (length xs `div` 2) xs

mezcla :: (Ord a) => [a] -> [a] -> [a]
mezcla [] [] = []
mezcla xs [] = xs
mezcla [] xs = xs
mezcla xss@(x:xs) yss@(y:ys)
  | x < y = x : mezcla xs yss
  | otherwise = y : mezcla xss ys

mezclaCon :: (Ord a) => (a -> a -> Ordering) -> [a] -> [a] -> [a]
mezclaCon _ [] [] = []
mezclaCon _ xs [] = xs
mezclaCon _ [] xs = xs
mezclaCon f xss@(x:xs) yss@(y:ys) =
  case f x y of
    LT -> x : mezclaCon f xs yss
    _ -> y : mezclaCon f xss ys

mergeSortCon :: (Ord a) => (a -> a -> Ordering) -> [a] -> [a]
mergeSortCon _ [] = []
mergeSortCon _ [x] = [x]
mergeSortCon f xs = mezclaCon f (mergeSortCon f a) (mergeSortCon f b)
  where
    (a, b) = parte xs


----------------
-- Coloración --
----------------

data Color
  = Rojo
  | Amarillo
  | Verde
  | Azul
  deriving (Eq, Show)

data Balcanes
  = Albania
  | Bulgaria
  | BosniayHerzegovina
  | Kosovo
  | Macedonia
  | Montenegro
  deriving (Eq, Show)

type Ady = [(Balcanes, Balcanes)]

adyacencias :: Ady
adyacencias =
  [ (Albania, Montenegro)
  , (Albania, Kosovo)
  , (Albania, Macedonia)
  , (Bulgaria, Macedonia)
  , (BosniayHerzegovina, Montenegro)
  , (Kosovo, Macedonia)
  , (Kosovo, Montenegro)
  ]

type Coloracion = [(Color, Balcanes)]

esBuena :: Ady -> Coloracion -> Bool
esBuena [] _ = True
esBuena ((u, v):xs) coloring =
  let colorU = lookupColoring u coloring
      colorV = lookupColoring v coloring
   in if colorU /= colorV
        then esBuena xs coloring
        else False

lookupColoring :: (Eq a) => a -> [(b, a)] -> Maybe b
lookupColoring key [] = Nothing
lookupColoring key ((x, y):xys)
  | key == y = Just x
  | otherwise = lookupColoring key xys

coloraciones :: Ady -> [Coloracion]
coloraciones ady =
  let colors = [Rojo, Amarillo, Verde, Azul]
      combinations =
        [ [ (c1, Albania)
          , (c2, Bulgaria)
          , (c3, BosniayHerzegovina)
          , (c4, Kosovo)
          , (c5, Macedonia)
          , (c6, Montenegro)
        ]
        | c1 <- colors
        , c2 <- colors
        , c3 <- colors
        , c4 <- colors
        , c5 <- colors
        , c6 <- colors
        ]
   in filter (esBuena ady) combinations
