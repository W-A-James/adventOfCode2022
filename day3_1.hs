import Data.Char
import Data.List

data Rucksack = Rucksack {p1 :: String, p2 :: String} deriving (Show)

getRucksack :: String -> Rucksack
getRucksack [] = Rucksack [] []
getRucksack l =
  let mid = length l `div` 2
   in Rucksack (take mid l) (drop mid l)

getRucksackOverlap :: Rucksack -> Char
getRucksackOverlap r = head $ intersect (p1 r) (p2 r)

getOverlapValue :: Char -> Int
getOverlapValue c
  | isUpper c = ord c - ord 'A' + 27
  | otherwise = ord c - ord 'a' + 1

doMain :: String -> Int
doMain = sum . map (getOverlapValue . getRucksackOverlap . getRucksack) . lines

main :: IO ()
main = do
  contents <- getContents

  print $ doMain contents
