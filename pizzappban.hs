foldr :: a ( a -> b -> b) -> b -> [a] -> b

foldr (\ a b -> undefined) [] ["Pizza", "Apple", "Banana"]

foldr (\ a b -> undefined) "" ["Pizza", "Apple", "Banana"]

foldr (\ a b -> take 3 a)

((\ a b -> take 3 a ++ b) "Pizza" ( (\ a b -> take 3 a ++ b) "Apple" ( (\ a b -> take 3 a ++ b) "Banana" "")))
((\ a b -> take 3 a ++ b) "Pizza" ( (\ a b -> take 3 a ++ b) "Apple" ("Ban")))
((\ a b -> take 3 a ++ b) "Pizza" ( "AppBan" ))
("PizAppBan")