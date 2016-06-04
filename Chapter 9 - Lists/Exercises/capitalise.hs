import Data.Char

filterUpperCase xs = [ x | x <- xs, elem x ['A'..'Z']]

capitaliseFirstLetter :: String -> String
capitaliseFirstLetter (x:xs) = [toUpper x] ++ xs

capitaliseWord :: String -> String
capitaliseWord [] = []
capitaliseWord (x:xs) = [toUpper x] ++ capitaliseWord xs



