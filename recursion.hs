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


