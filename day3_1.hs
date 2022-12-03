{-# LANGUAGE GADTs #-}

import Data.Char
import Data.List

data Rucksack where
  Rucksack :: {p1 :: String, p2 :: String} -> Rucksack
  deriving (Show)

getRucksack :: String -> Rucksack
getRucksack [] = Rucksack [] []
getRucksack l =
  let mid = length l `div` 2
   in Rucksack (take mid l) (drop mid l)

getRucksackOverlap :: Rucksack -> Char
getRucksackOverlap (Rucksack p1 p2) = head $ intersect p1 p2

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
