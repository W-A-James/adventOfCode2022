import Data.List

splitOn :: Char -> String -> (String, String)
splitOn c s =
  let (ss0, _ : ss1) = span (/= c) s
   in (ss0, ss1)

getRange :: String -> [Int]
getRange p =
  let (lowerBound, upperBound) = splitOn '-' p
   in [read lowerBound, read upperBound]

getPairs :: String -> [Int]
getPairs line =
  let (pair0, pair1) = splitOn ',' line
   in getRange pair0 ++ getRange pair1

hasOverlap :: [Int] -> Bool
hasOverlap (lowerBound0 : upperBound0 : lowerBound1 : upperBound1 : _) = not . null $ intersect [lowerBound0 .. upperBound0] [lowerBound1 .. upperBound1]
hasOverlap other = error "Wrong length"

main :: IO ()
main = do
  numContainOther <- fmap (length . filter hasOverlap . map getPairs . lines) getContents
  print numContainOther
