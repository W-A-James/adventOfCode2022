import System.IO
import Data.List
import qualified Data.Maybe as M
import qualified Data.ByteString.Char8 as B



getMaxCalories :: [B.ByteString] -> Int
getMaxCalories inputLines = snd $ foldr step (0,0) inputLines
    where step x (current, maxCalories)
                        | isEmpty == True = (0, max maxCalories current)
                        | isEmpty == False = (convertToInt x + current, maxCalories)
            where isEmpty = B.null x
                  convertToInt = fst . M.fromJust . B.readInt 

main :: IO()
main = do
    puzzleInput <- B.getContents
    print $ getMaxCalories (B.split '\n' puzzleInput)
