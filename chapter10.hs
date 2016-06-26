
stops = "pbtdkg"
vowels = "aeiou"

--tupleMaker :: [a] -> [b] -> [(a, b, a)]
-- don't need a signature here?

tupleMaker = [ (a, b, c) | a <- stops, b <- vowels, c <- stops ]

tupleMakerP = [ (a, b, c) | a <- stops, b <- vowels, c <- stops, (a == 'p')]



nouns = ["bat","bed","book","boy","bun","can","cake","cap","car","cat","cow","cub","cup","dad","day","dog","doll","dust","fan","feet","girl","gun","hall","hat","hen","jar","kite","man","map","men","mum","pan","pet","pie","pig","pot","rat","son","sun","toe","tub","van"]

verbs = ["be","have","do","say","get","make","go","know","take","see","come","think","look","want","give","use","find","tell","ask","work","seem","feel","try","leave","call"]

sentenceMaker = [ (a ++ " " ++ b ++ " " ++ c) | a <- nouns, b <- verbs, c <- nouns ]


seekritFunc x = div(sum(map length(words x)))( length(words x))

seekritFunc2 x = (/)(fromIntegral(sum(map length(words x))))( fromIntegral(length(words x)))

