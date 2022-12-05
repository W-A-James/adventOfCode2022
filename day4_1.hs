import Data.List

splitOn :: Char -> String -> (String, String)
splitOn c s =
  let ss0 = takeWhile (/= c) s
      (_ : ss1) = dropWhile (/= c) s
   in (ss0, ss1)

getRange :: String -> [Int]
getRange p =
  let (lowerBound, upperBound) = splitOn '-' p
   in [read lowerBound, read upperBound]

getPairs :: String -> [Int]
getPairs line =
  let (pair0, pair1) = splitOn ',' line
   in getRange pair0 ++ getRange pair1

isTotalOverlap :: [Int] -> Bool
isTotalOverlap (lowerBound0 : upperBound0 : lowerBound1 : upperBound1 : _) = (lowerBound0 < lowerBound1 && upperBound0 < upperBound1) || (lowerBound1 < lowerBound0 && upperBound1 < upperBound0)
isTotalOverlap other = error "Wrong length"

main :: IO ()
main = do
  numContainOther <- fmap (length . filter (not . isTotalOverlap) . map getPairs . lines) getContents
  print numContainOther
