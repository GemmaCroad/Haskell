## Chapter 4 - Basic datatypes


#### Basic datatypes

* Types are a powerful means of classifying, organising and delimiting data to only the form we want to process in our programs
* Types provide the means to build programs more quickly and also allow for greater ease of maintenance
* So far we have looked at numbers, characters and lists or characters (also called strings), these are some of the standard built-in datatypes that categorise and delimit values

#### Anatomy of a data declaration

* Data declarations are how datatypes are defined
* The type constructor is the name of the type and is capitalised
* Data constructors are the values that inhabit the type they are defined in 

	Example

		-- the definition of Bool
		data Bool = False | True
		--    [1]    [2] [3] [4]

	[1] The type constructor for datatype Bool - this is the name of the type and shows up in the type signatures

	[2] Data constructor for the value false

	[3] Pipe | indicates logical disjunction, "or", so a Bool value is true or false

	[4] Data constructor for the value true

* The above is called a data declaration
* Some data declarations have datatypes that use logical conjunction ("and") instead of disjunction
* Some type constructors may have arguments
* They all have keyword data followed by the type constructor (name of the type that will appear in type signatures), the equals sign to denote a definition and then data constructors of names of values
* :t not takes one Bool and returns another Bool
* When we use the not functions we use the data constructors, not the values, in our code
* Our expression evaluates to another data constructor or value, in this case the other data constructor for the same datatype

#### Numeric types

* It's important to understand that Haskell does not just use one type of number
* Integral numbers: whole numbers, positive and negative
	* Int: a fixed-precision integer, meaning it has a range, with a maximum and a minimum and so it cannot be arbitrarily large or small
	* Integer: this type is also for integers but supports arbitrarily large or small numbers
* Fractional: these are not integers and include the following four types:
	* Float: used for single-prevision floating point numbers, where fixed point number representations have immutable numbers of digits assigned for the parts of the number before and after the decimal point, floating point ca shift how many bits it uses to represent numbers before or after the decimal point - should be used with great case and shouldn't be used in business applications
	* Double: a double-precision floating point number type that has twice as many bits with which to describe numbers as the float type
	* Rational: a fractional number that represents a ratio of two integers, is arbitrarily precise, but not as efficient as scientific
	* Scientific: a space efficient and almost arbitrary precision scientific number type, there numbers are represented using scientific notation - it stores the coefficient as an integer and the exponent as an int, since the int isn't arbitrarily large there is technically a limit to the size of the number you can express but the chance of hitting that limit is unlikely
* All of these numeric datatypes have instances of a typeclass called num
* Typeclasses are a way of adding functionality to types that is reusable across all the types that have instances of that typeclass
* The num typeclass is what provides the standard (+), (-) and (*) operators

#### Integral numbers

* There are two types integral numbers: int and integer
* Integral numbers are whole numbers with no fractional component

#### Integer

* Integer numbers can be positive or negative and can extend as far in either direction as needs be
* In the case of integer there are an infinite number of possibilities so the data constructors are not written out

#### Why do we have int?

* The int number type is an artefact of what computer hardware has supported natively over the years
* Unless the limitations of the type are understood and the performance makes a difference, it's generally better to use integer and not int

#### Fractional numbers

* The four common fractional types used in Haskell are float, double, rational and scientific
* Some computations involving numbers will be fractional rather than integral, see example below

	Example

		Prelude> :t (/)
		(/) :: Fractional a => a -> a -> a
 
* The notation Fractional a => denoted a typeclass constraint
* This can be read as "the type variable a must implement the Fractional typeclass". 
* Fractional is a typeclass that requires types to already have an instance of the num typeclass
* We can describe this relationship by saying that num is a superclass of fractional

#### Comparing values

* '==' is equal to
* '<' less than
* '>' greater than
* '/=' is not qual to
* Comparison functions are polymorphic
* Type information for these infix operators will list the result type as bool

		Prelude> :t (==)
		(==) :: Eq a => a -> a -> Bool
		Prelude :t (<)
		(<) :: Ord a => a -> a -> Bool

* Eq is a typeclass that includes everything that can be compared and determined to be equal in value
* Ord is a typeclass that includes all things that can be ordered
* Neither of the above is limited to just numbers
* Numbers can be compared and ordered of course, but so can letters, so this typeclass constraint allows for the maximum amount of flexibility

		Prelude> 'a' == 'a'
		True
		Prelude>  'a' == 'b'
		False
		Prelude> 'a' < 'b'
		True
		Prelude> 'a' > 'b'
		False
		Prelude> 'a' == 'A'
		False
		Prelude> "Julie" == "Chris"
		False

* You can only compare list items where the items themselves also have an instance of ord
* A datatype that has not instance of ord will not work

#### if-then-else

* Haskell doesn't have 'if' statements but it does have if expressions
* It's a built in bit of syntax that works with the bool datatype

		Prelude> if True then "Truthin'" else "Falsin'"
		"Truthin"
		Prelude> if False then "Truthin'" else "Falsin'"
		"Falsin'"
		Prelude> :t if True then "Truthin'" else "Falsin'"
		if True then "Truthin'" else "Falsin'" :: [Char] 


* The structure here is if condition then expression_a else expression_b
* If the condition (which must evaluate to bool) reduces to the bool value true then expression_a is the result, otherwise it will be expression_b
* If-expressions in Haskell can be thought of as a way to choose between two values
* You can embed a variety of expressions with the if of an if-then-else as long as it evaluates to bool
* The types of the expressions in the then and else clauses must be the same

	Example

		-- Given:
		x = 0

		if (x + 1 == 1) then "AWESOME" else "wut"
		-- x is zero

		if (0 + 1 == 1) then "AWESOME" else "wut"
		-- reduce 0 + 1 so we can see it it's equal to 1

		if (1 == 1) then "AWESOME else "wut"
		-- Does 1 equal 1?

		if True then "AWESOME" else "wut"
		-- pick the branch based on the Bool value

		"AWESOME"

#### Tuples

* The tuple is Haskell is a type that allows you to store and pass around multiple values within a single value
* Tuples have a distinctive built-in syntax that is used at both type and term levels
* Each tuple has a fixed number of constituents
* We refer to tuples by how many constituents are in each tuple
* The two-tuple, or pair, has two values inside of it (x, y)
* The three-tuple, or triple, has three values inside of it (x, y, z) and so on
* The two-tuple in Haskell has some default convenience functions for getting the first and second values, they are named fst and snd:

		fst :: (a, b) -> a
		snd :: (a, b) -> b

* These functions can only return the first and second values respectively
* The variables can be polymorphic so variables a and b can be different types (integer, string) or (integer, integer)
* It's generally unwise to use tuples of an overly large size, most should be 5-tuple of smaller

#### Lists

* Lists in Haskell are another type used to contain multiple values within a single value
* All constituents of a list must be of the same type
* Lists have their own distinct syntax [ ]
* The number of constituents in a list can change as you operate on the list, unlike tuples where the arity is set in the type and is immutable
* Arity is the number of arguments a function accepts
* A type alias is a way to refer to a type constructor or type constant by an alternate name, usually to communicate something more specific
