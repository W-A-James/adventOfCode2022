import Data.Bifunctor (bimap)

data Outcome = Win | Loss | Draw deriving (Show)

data Move = Rock | Paper | Scissors deriving (Eq, Show)

getRounds :: [String] -> [(Move, Outcome)]
getRounds = map (bimap toOpMove toOutcome . getRound . words)
  where
    getRound (x : xs)
      | isLengthOne = (x, head xs)
      | otherwise = error "parse error"
      where
        isLengthOne = length xs == 1
    getRound [] = error "parse error"
    toOpMove "A" = Rock
    toOpMove "B" = Paper
    toOpMove "C" = Scissors
    toOpMove _ = error "Invalid opponent move"

    toOutcome "X" = Loss
    toOutcome "Y" = Draw
    toOutcome "Z" = Win
    toOutcome _ = error "Invalid outcome"

getMove :: Move -> Outcome -> Move
getMove x Draw = x
getMove Rock Loss = Scissors
getMove Rock Win = Paper
getMove Paper Loss = Rock
getMove Paper Win = Scissors
getMove Scissors Loss = Paper
getMove Scissors Win = Rock

getScore :: [(Move, Outcome)] -> Int
getScore = foldr (\(op, outcome) acc -> getScore_ (getMove op outcome) outcome + acc) 0
  where
    getScore_ pl outcome = getOutcomeScore outcome + getMoveScore pl
      where
        getMoveScore Rock = 1
        getMoveScore Paper = 2
        getMoveScore Scissors = 3

        getOutcomeScore Win = 6
        getOutcomeScore Draw = 3
        getOutcomeScore Loss = 0

main :: IO ()
main = do
  score <- fmap (getScore . getRounds . lines) getContents
  print score
