import Data.List
import System.IO

main :: IO ()
getCalories :: [String] -> [Int]
getCalories = foldr step []
  where
    step x [] =
      if null x
        then [0]
        else [read x]
    step x (current : others) =
      if null x
        then 0 : current : others
        else ((read x) + current) : others
main = do
  result <- fmap (sumTopThree . getCalories . lines) getContents
  print result
  where
    sumTopThree = sum . take 3 . reverse . sort
