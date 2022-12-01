import System.IO
import Data.List

main :: IO()

getCalories :: [String] -> [Int]
getCalories inputLines = foldr step [] inputLines
    where step x [] = if null x
                        then 0:[]
                        else read x : []
          step x (current:others) = if null x
                                        then 0:current:others
                                        else ((read x) + current) : others

main = do
    puzzleInput <- getContents
    print $ sumTopThree (getCalories $ lines puzzleInput)
    where sumTopThree = foldr1 (+) . take 3 . reverse . sort
