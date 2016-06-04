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
