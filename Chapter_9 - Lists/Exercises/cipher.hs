module Cipher where

import Data.Char

--substitution cipher that replaces each letter with a letter that is a fixed number of places down the alaphabet
--a rightward shift of 3 from 'A' means it will become 'D'
--a leftward shift of 5 means it would become 'V'

letterToNumber :: Char -> Int
letterToNumber c = ord c

numberToLetter :: Int -> Char
numberToLetter n = chr n

--will take the number entered and then convert the starting letter to the new letter
calculateSingleLetterShift :: Int -> Char -> Char
calculateSingleLetterShift shiftValue inputLetter = numberToLetter ((letterToNumber inputLetter) + shiftValue)


encryptWord :: Int -> String -> String
encryptWord n xs = [calculateSingleLetterShift n x | x <- xs]