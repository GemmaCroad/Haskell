Chapter 10: Folding lists
Folds
Folds as a general concept are called catamorphisms
"Cata-" means "down" or "against" as in "catacombs"
Catamporhisms are a means of deconstructing data
If a spine of a list is the structure of a list, then a fold is what can reduce that structure
Folds allow us to reduce a data structure (like a list) to a single value
Folds can be used to implement any function where you transverse a list once, element by element, and then return something based on that
Bringing you into the fold
The type signature for fold right (foldr) is as follows:

A fold takes a binary function a starting value (often called an accumulator) and a list to fold up
Lists can be folded up from the left or from the right, fold right is more commonly used with lists
The fold function calls the given binary function, using the accumulator and the first (or last) element of the list as parameters
The resulting value is the new accumulator
Then the fold function calls the binary function again with the new accumulator and the new first (or last element) of the list, resulting in another new accumulator
This repeats until the function has transversed the entire list and reduced it down to a single accumulator value
Where map applies a function to each member of a list and returns a list, a fold replaces the cons constructor with the function and reduces the list:

Recursive patterns

Fold right
We call foldr the "right fold" because the fold is right associative
This is reflected in the definition of foldr:
