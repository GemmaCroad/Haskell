data TisAnInteger = TisAn Integer 

instance Eq TisAnInteger where
  (==) (TisAn a) (TisAn b) = (a == b)



data TwoIntegers = Two Integer Integer

instance Eq TwoIntegers where
  (==) (Two a b) (Two c d) = ((a == c) && (b == d))



data StringOrInt = TisAnInt Int | TisAString String

instance Eq StringOrInt where
  (==) (TisAnInt a) (TisAnInt b) = (a == b)
  (==) (TisAString a) (TisAString b) = (a == b)



data Pair a = Pair a a

instance Eq a => Eq (Pair a) where
  (==) (Pair a a') (Pair b b') = (a == b) && (a' == b')



data Tuple a b = Tuple a b

instance Ord a, Ord b, Ord c, Ord d => Eq (Tuple a b) where
  (==) (Tuple a b) (Tuple c d) = (a == c) && ( b == d)
