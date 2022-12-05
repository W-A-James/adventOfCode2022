import Data.Bifunctor (bimap)

data Outcome = Win | Loss | Draw deriving (Show)

data Move = Rock | Paper | Scissors deriving (Eq, Show)

getRounds :: [String] -> [(Move, Move)]
getRounds = map (bimap toOpMove toPlMove . getRound . words)
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

    toPlMove "X" = Rock
    toPlMove "Y" = Paper
    toPlMove "Z" = Scissors
    toPlMove _ = error "Invalid player move"

getOutcome :: Move -> Move -> Outcome
getOutcome Rock Scissors = Loss
getOutcome Rock Paper = Win
getOutcome Paper Scissors = Win
getOutcome Paper Rock = Loss
getOutcome Scissors Paper = Loss
getOutcome Scissors Rock = Win
getOutcome _ _ = Draw

getScore :: [(Move, Move)] -> Int
getScore = foldr (\(op, pl) acc -> getScore_ (getOutcome op pl) pl + acc) 0
  where
    getScore_ outcome pl = getOutcomeScore outcome + getPlScore pl
      where
        getPlScore Rock = 1
        getPlScore Paper = 2
        getPlScore Scissors = 3

        getOutcomeScore Win = 6
        getOutcomeScore Draw = 3
        getOutcomeScore Loss = 0

main :: IO ()
main = do
  score <- fmap (getScore . getRounds . lines) getContents
  print score
