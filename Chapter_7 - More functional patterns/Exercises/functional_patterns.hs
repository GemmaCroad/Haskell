mflip f x y = f y x :: Integer

isItTwo :: Integer -> Bool
isItTwo 2 = True
isItTwo _ = False

funcZ x =
    case x + 1 == 1 of
        True -> "Awesome"
        False -> "Meh"

pal xs =
    case xs == reverse xs of
        True -> "yes, it is palindrome"
        False -> "not a palindrome"

functionC x y =
    case (x > y) of
        True -> x
        False -> y

ifEvenAdd2 n =
    case even n of
        True -> (n + 2)
        False -> n

nums x =
    case compare x 0 of
        LT -> -1
        GT -> 1
        EQ -> 0


tensDigit :: Integral a => a -> a
tensDigit x = d
  where xLast = x `div` 10
        d = xLast `mod` 10


tensDigit :: Integral a => a -> a -> (a, a)
tensDigit x = d
  where d = snd (fst (x `divMod` 100) `divMod` 10)

foldBool3 :: a -> a -> Bool -> a
foldBool3 x y True = x
foldBool3 x y False = y

foldBool x y z =
  case z of
    True -> x
    False -> y

foldBool :: a -> a -> Bool -> a
foldBool x y z
  | z == True = x
  | z == False = y
        