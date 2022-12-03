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
getGroupValue (Group r1 r2 r3) = getOverlapValue . head $ intersect r1 (r2 `intersect` r3)

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
