import qualified Data.ByteString.Char8 as B
import Data.List
import qualified Data.Maybe as M
import System.IO

getMaxCalories :: [B.ByteString] -> Int
getMaxCalories inputLines = snd $ foldr step (0, 0) inputLines
  where
    step x (current, maxCalories)
      | isEmpty = (0, max maxCalories current)
      | otherwise = (convertToInt x + current, maxCalories)
      where
        isEmpty = B.null x
        convertToInt = fst . M.fromJust . B.readInt

main :: IO ()
main = do
  maxCalories <- fmap (getMaxCalories . B.split '\n') B.getContents
  print maxCalories
