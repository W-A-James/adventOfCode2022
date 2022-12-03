{-# LANGUAGE GADTs #-}
{-# LANGUAGE StrictData #-}

import Data.Char
import Data.List

data Group where
  Group :: {r1 :: String, r2 :: String, r3 :: String} -> Group
  deriving (Show)

getGroups :: [String] -> [Group]
getGroups [] = []
getGroups (l0 : l1 : l2 : ls) = Group l0 l1 l2 : getGroups ls
getGroups other = error "Length not multiple of 3"

getGroupValue :: Group -> Int
getGroupValue g = getOverlapValue . head $ intersect (r1 g) (r2 g `intersect` r3 g)

getOverlapValue :: Char -> Int
getOverlapValue c
  | isUpper c = ord c - ord 'A' + 27
  | otherwise = ord c - ord 'a' + 1

doMain :: String -> Int
doMain = sum . map getGroupValue . getGroups . lines

main :: IO ()
main = do
  contents <- getContents
  print $ doMain contents
