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
  | isUpper c = ord c - _A + 27
  | otherwise = ord c - _a + 1
  where
    _a = ord 'a'
    _A = ord 'A'

getGroupOverlapSum :: String -> Int
getGroupOverlapSum = sum . map getGroupValue . getGroups . lines

main :: IO ()
main = do
  groupOverlapSum <- fmap getGroupOverlapSum getContents
  print groupOverlapSum
