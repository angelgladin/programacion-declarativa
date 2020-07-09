-- |
-- Author : Ángel Iván Gladín García
--
-- I am following this table for time convertion as reference:
-- https://www.freecodecamp.org/news/mathematics-converting-am-pm-to-24-hour-clock/
--
-- There are no guards checking if the time is correct. It is assumed that the user
-- will put a well-formated time.
module Time
    -- * Time and Period
  ( Time(..)
  , Period
   -- * Transforming
  , to24
  , to12
   -- * Querying
  , eqTime
  , showTime
  , ltTime
  ) where

-- | Algebraic type used for representing the AM or PM in 12-hour format.
data Period
  = AM
  | PM
  deriving (Show, Eq)

-- | Representation of the time in 24-hour and 12-hour format.
data Time
  = StandardTime
      { hours :: Int
      , minutes :: Int
      }
  | PeriodTime
      { hours :: Int
      , minutes :: Int
      , period :: Period
      }

instance Show Time where
  show (StandardTime h m) = prettyFormat h ++ ":" ++ prettyFormat m ++ "HRS"
  show (PeriodTime h m p) =
    if h == 12 && p == AM && m == 0
      then "Medianoche"
      else if h == 12 && p == PM && m == 0
             then "Mediodia"
             else prettyFormat h ++ ":" ++ prettyFormat m ++ show p

-- | Format a single digit into a '0' concatenated with the number.
prettyFormat :: Int -> String
prettyFormat n =
  (if n <= 9
     then "0"
     else "") ++
  show n

instance Eq Time where
  (StandardTime h1 m1) == (StandardTime h2 m2) = h1 == h2 && m1 == m2
  t1@(PeriodTime h1 m1 p1) == t2@(PeriodTime h2 m2 p2) =
    h1 == h2 && m1 == m2 && p1 == p2
  t1@(StandardTime _ _) == t2@(PeriodTime _ _ _) = t1 == (to24 t2)
  t1@(PeriodTime _ _ _) == t2@(StandardTime _ _) = t2 == t1

instance Ord Time where
  (StandardTime h1 m1) `compare` (StandardTime h2 m2) =
    let t1 = h1 * 100 + m1
        t2 = h2 * 100 + m2
     in t1 `compare` t2
  t1@(PeriodTime _ _ _) `compare` t2@(PeriodTime _ _ _) =
    (to24 t1) `compare` (to24 t2)
  t1@(StandardTime _ _) `compare` t2@(PeriodTime _ _ _) = t1 `compare` (to24 t2)
  t1@(PeriodTime _ _ _) `compare` t2@(StandardTime _ _) = t2 `compare` t1

-- | Convert time to 24-hour format.
to24 :: Time -> Time
to24 t@(StandardTime _ _) = t
to24 (PeriodTime h m p) =
  let newH =
        if h == 12 && p == AM
          then 0
          else if h == 12 && p == PM
                 then 12
                 else if h >= 1 && h <= 11 && p == AM
                        then h
                        else h + 12
   in (StandardTime newH m)

-- | Convert time to 12-hour format.
to12 :: Time -> Time
to12 (StandardTime h m) =
  let (newH, p) =
        if h == 0
          then (12, AM)
          else if h >= 1 && h <= 11
                 then (h, AM)
                 else if h == 12
                        then (h, PM)
                        else (h - 12, PM)
   in (PeriodTime newH m p)
to12 t@(PeriodTime h m p) = t

-- | Check if two time data type are equal.
eqTime :: Time -> Time -> Bool
eqTime = (==)

-- | Shows the time in human-readable format as string.
showTime :: Time -> String
showTime = show

-- | Compare two timw data times.
ltTime :: Time -> Time -> Ordering
ltTime = compare

-----------------------
-- Some examples     --
-----------------------
t1 = StandardTime 00 00
t2 = StandardTime 23 37

t3 = PeriodTime 9 18 AM
t4 = PeriodTime 12 00 AM
t5 = PeriodTime 11 28 PM
    