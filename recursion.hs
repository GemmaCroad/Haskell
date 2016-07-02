f :: Bool -> Int
f True = error "blah"
f False = 0


fib :: Int -> Int 
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)


mc91 :: Int -> Int
mc91 x
    | x > 100 = (x - 10)
    | otherwise = mc91 . mc91 $ x + 11

mc91result min max = map mc91 [min..max]


--Custom version of the maximum function
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of an empty lists!"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)


--Custom version of the replicate function
replicate' :: Int -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x : replicate' (n-1) x


--Custom version of the take function
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : take' (n-1) xs


--Custom version of the reverse function
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]


--Custom version of the repeat function
repeat' :: a -> [a]
repeat' x = x:repeat' x


--Custom version of the zip function
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys


--Custom version of the elem function
elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x = True
    | otherwise = a `elem'` xs
