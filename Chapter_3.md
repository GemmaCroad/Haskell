## Chapter 3 - Types


#### A first look at types

* Types are a way of categorising values
* There are several types for numbers, for example, depending on whether they are integers, fractional numbers, etc.
* There is a type for boolean values, specifically the values true and false
* Char - 'character'
* String - strings are lists of characters, in Haskell string is represeneted by a linked-list of char values [char]
* To find out the type of a value, expression or function in GHCi use the :type command
* The character needs to be enclosed in single quotes to let GHCi know that it is not a variable
* The :: symbol is read as "has the type" - type signature
* With a string of text we need to use double quoatation marks so that GHCi knows we have a string
* The square brackets around the Char in the type information for the string are the syntactic sugar for list (eg. "Hello!" has the type list of Char)

	Example

		Prelude> :type 'a'
		'a' :: Char

		Prelude> :type "Hello!"
		"Hello!" :: [Char]

#### Printing simple strings

* We can use print to tell GHCi to print the string to the display
* We can also print using putStr and putStrLn though it has slightly different results

		Prelude> putStrLn "hello world!"
		hello world!
		Prelude> 

		Prelude> putStr "hello world!"
		hello world!Prelude>

* Can also print from source files
* IO ( ) - stands for input / output
* A special type used by Haskell when the results of a running program involve side-effects as opposed to being a pure function or expression e.g. printing

#### String concatenation

* Concatenation, or to concatenate something, means to "link together"
* "hello" ++ " world" - new space will result in "hello world" otherwise it would be "helloworld"
* Could also use "hello" ++ " " ++ "world"

#### Global versus local definitions

* Scope is where a variable referred to by name is valid
* Local bindings are bindings local to particular expressions
* Global or top level bindings in Haskell means bindings are visible to all code within a module, and if made available, can be imported by other modules or programs
* If something is at the top level of a module it means it is defined globally, not locally
* To be be defined locally the declaration would need to be nested within some other expression and is not visible to code importing the module
where and let clauses in Haskell introduce local bindings or declarations

#### Types of concatenation functions

* ++ is an infix operator
* When we need to refer to an infix operator in a position that is not infix we must put parentheses around it
* concat is a normal function so parentheses would not be necessary

	Examples

		++		has the type [a] -> [a] -> [a]
		concat has the type [[a]] -> [a]

		-- Here's how we query that in ghci:
		Prelude> :t (++)
		(++) :: [a] -> [a] -> [a]
		Prelude> :t concat
		concat :: [[a]] -> [a]

		(++) :: [a] -> [a] -> [a]
				[1]    [2]    [3]


	[1] Take an argument of type [a], which is a list of elements whose type we don't know yet

	[2] Take another argument of type [a], a list of elements who type we don't know - because these variables are the same, they must be the same type though (a == a)

	[3] Return a result of type [a]

#### Concatenation and scoping

Not sure on!

#### More list functions

* These functions can be used for manipulating lists on strings, a string is just a list of characters [char] under the hood

		Prelude> :t 'c'
		'c' :: Char
		Prelude> :t "c"
		"c" :: [Char] -- List of Char is String, same thing.
		-- the : operator, called "cons," builds a list
		Prelude> 'c' : "hris"
		"chris"
		Prelude> 'P' : ""
		"P"
		 
		-- head returns the head or first element of a list
		Prelude> head "Papuchon"
		'P'
		 
		-- tail returns the list with the head chopped off
		Prelude> tail "Papuchon"
		"apuchon"
		 
		 
		-- take returns the specified number of elements
		-- from the list, starting from the left:
		Prelude> take 1 "Papuchon"
		"P"
		Prelude> take 0 "Papuchon"
		""
		Prelude> take 6 "Papuchon"
		"Papuch"
		 
		 
		-- drop returns the remainder of the list after the
		-- specified number of elements has been dropped:
		Prelude> drop 4 "Papuchon"
		"chon"
		Prelude> drop 9001 "Papuchon"
		""
		Prelude> drop 1 "Papuchon"
		"apuchon"
		 
		-- we've already seen the ++ operator
		Prelude> "Papu" ++ "chon"
		"Papuchon"
		Prelude> "Papu" ++ ""
		"Papu"
		-- !! returns the element that is in the specified
		-- position in the list. Note that this is an
		-- indexing function, and indices in Haskell start
		-- from 0. That means the first element of your
		-- list is 0, not 1, when using this function.
		Prelude> "Papuchon" !! 0
		'P'
		Prelude> "Papuchon" !! 4
		'c'
