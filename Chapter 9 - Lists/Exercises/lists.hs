--myHead [t] -> t
myHead ( x : _ ) = x


--myTail [t] -> [t]
myTail ( _ : xs ) = xs


safeTail :: [a] -> Maybe [a]
safeTail[] = Nothing
safeTail (x:[]) = Nothing
safeTail (_:xs) = Just xs


safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x



mySplitter :: Eq a => a -> [a] -> [[a]]
mySplitter x [] = []
mySplitter x cs = (takeWhile (/= x) cs) : mySplitter x (dropWhile (== x) (dropWhile (/= x) cs))

myWords :: String -> [String]
myWords = mySplitter ' '

myLines :: String -> [String]
myLines = mySplitter '\n'

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"

sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

mySqr = [x^2 | x <- [1..5]]

myCube = [y^3 | y <- [1..5]]

mySqube = [ (x, y) | x <- mySqr, y <- myCube, x < 50, y < 50]


multiple3 = filter (\x -> (rem x 3) == 0) [1..30]

lukeySays = [ x | x <- [1..30], ((rem x 3) == 0)]

badWords = ["the", "a", "an"]
myFilter xs = [ x | x <- (words xs), not (elem x badWords) ]

myZip :: [a] -> [b] -> [(a, b)]
myZip xList yList = [ (x, y) | x <- xList, y <- yList ]


















