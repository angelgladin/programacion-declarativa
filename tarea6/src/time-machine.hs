-- |
-- Author : Ángel Iván Gladín García
--

module TimeMachine where

timeTravel :: Int -> Int -> [Int]
timeTravel 0 start = [start]
timeTravel jumps start
  = [-1, 3, 5] >>=
      \ choice -> timeTravel (jumps - 1) start >>=
        \ r -> return (choice + r)

timeTravelD :: Int -> Int -> [Int]
timeTravelD 0 start = [start]
timeTravelD jumps start
  = do choice <- [-1, 3, 5]
       r <- timeTravelD (jumps - 1) start
       return (choice + r)
