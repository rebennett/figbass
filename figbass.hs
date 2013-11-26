import Data.Char
import Data.List
import System.Environment( getArgs )
import System.Random
import System.Console.GetOpt

main = do
  args <- getArgs
  let key = head args
  randomNote <- randomRIO (0, 6) 
  randomSuff <- randomRIO (0, 6)
-- prints random key in scale
  putStrLn $ (deriveScale key !! randomNote)
-- prints random suffix
  putStrLn $ (suffix !! randomSuff)

-- sharp chromatic scale, for mapping
sharps = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
-- flat chromatic scale, for mapping
flats = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
suffix = ["", "6", "6\n4", "7", "6\n5", "4\n3", "4\n2"]

-- isSharps a returns True if key a is a sharp key, 
-- and False if key a is a flat key
isSharps :: String -> Bool
-- edge case: the only element in sharps that is a flat key
isSharps a | a == "F" = False
           | (map toUpper a) `elem` sharps = True
isSharps a = False

{- deriveOffset a returns the offset from the key of C
   e.g.) deriveOffset D returns 2, because D is offset from C by 2
   deriveOffset :: String -> Int
   
   these are our outside cases, not appearing in sharps 
   (we only need to determine index here): 
   Db, db, Eb, eb, Gb, gb, Ab, ab, Bb, bb
   
   we match both sides toLower equivalent 
   e.g.) map toLower Bb == "bb"
   because matching toUpper results in B not matching -} 
deriveOffset key | map toLower key == "db" = 1
                 | map toLower key == "eb" = 3
                 | map toLower key == "gb" = 6
                 | map toLower key == "ab" = 8
                 | map toLower key == "bb" = 10
deriveOffset key               = head (elemIndices (map toUpper key) sharps)

-- maps sharp or flat scale over scale intervals from derivedModality
deriveScale :: String -> [String]
deriveScale a | isSharps a = map (sharps !!) (deriveModality a)
deriveScale a              = map (flats !!) (deriveModality a)

-- creates scale intervals (major or minor), using offset amount
deriveModality :: String -> [Int]
-- key is major
deriveModality a | isUpper (head a) = [(0 + offset) `mod` 12, (2 + offset) `mod` 12, (4 + offset) `mod` 12, (5 + offset) `mod` 12, (7 + offset) `mod` 12, (9 + offset) `mod` 12, (11 + offset) `mod` 12] where offset = deriveOffset a
-- key is minor
deriveModality a                  = [(0 + offset) `mod` 12, (2 + offset) `mod` 12, (3 + offset) `mod` 12, (5 + offset) `mod` 12, (7 + offset) `mod` 12, (8 + offset) `mod` 12, (10 + offset) `mod` 12] where offset = deriveOffset a
