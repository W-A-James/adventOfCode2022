import Data.List
import System.IO

main :: IO ()
getCalories :: [String] -> [Int]
getCalories = foldr step []
  where
    step x [] =
      if null x
        then 0 : []
        else read x : []
    step x (current : others) =
      if null x
        then 0 : current : others
        else ((read x) + current) : others
main = do
  puzzleInput <- getContents
  let maxFood = foldr1 max (getCalories (lines puzzleInput))
   in print $ maxFood
