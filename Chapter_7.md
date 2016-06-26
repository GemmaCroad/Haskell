## Chapter 7 - More functional patterns


#### Make it funcy-y

* A function is an instruction for producing an output from an input, or argument
* Functions are applied to their arguments
* Arguments are passed to function
* These arguments are then evaluated to produce the output or result

#### Arguments

* All Haskell values can be arguments to function, including functions
* A value that can be used as an argument to a function is a first-class value
	* In Haskell this includes functions
* You declare arguments in Haskell by putting the name of the argument between the name of the function (which is always at the left margin) and the equals sign

	Example

		myNum :: Integr
		myNum = 1

		myVal = myNum

If we query the type of myVal:

		Prelude> :t myVal
		myVal :: Integer

The value myVal has the same type as myNum because it is equal to it - we can see from the type that it's just a value without any arguments

Now let's introduce an argument named f:

		myNum :: Integer
		myNum = 1

		myVal f = myNum

And let's see how that has changed the type:

		Prelude> :t myVal
		myVal :: t -> Integer

By writing f after myVal we declare an argument which we reer to as f

This changes out type from Integer to t ->  Integer

The type t is polymorphic because we don't do anything with it - it could be anything

If we do something with the f the type will change:

		Prelude> let myNum = 1 :: Integer
		Prelude> let myVal f = f + myNum
		Prelude> :t myVal
		myVal :: Integer -> Integer

Now it knows f has to be a type Integer because we added it to myNum

* We can tell a simple value from a function in part because a simple, literal value is not applied to any arguments while functions are necessarily applied to arguments
* Although Haskell can only take one argument per function, we can declare multiple argument in a term-level function definition

	Example

		myNum = 1
		-- [1]

		myVal f = f + myNum
		--		 [2]

		stillAFunction a b c = a ++ b ++ c
		--				[3]

	[1] Declaration of a value of type Num a => a 
	We can tell it's not a function because it accepts no explicit arguments between the name of the declared value and the =
	Also the value 1 is not a function

	[2] Here f is an argument to the function myVal
	The function type is Num a => a -> a
	If you assign the type Integer to myNum, myNum and myVal change to the types Inteegr and Integer -> respectively

	[3] Here a, b and c are arguments to the function stillAFunction
	The underlying logic is of nested functions each applied to one argument rather than one function taking several arguments, even though this is how it appears at term level

What happens to the types if we add more arguments?

		Prelude> let myVal f g = myNum
		Prelude> :t myVal
		myVal :: t -> t1 -> Integer

		Prelude> let myVal f g h = myNum
		Prelude> :t myVal
		myVal :: t -> t1 -> t2 -> Integer

* The types are t, t1 and t2, which could all be different types
* They are allowed to be different types, but are not required to be
* They are all polymorphic because we gave the type inference nothing to go on with respect to what type they could be
* The type variables are different because nothing in our code is preventing them from varying, so they are potentially different

#### Binding variables to values

* We bind a variable to a value when we apply it
* When we apply a type variable to an argument, we bind it to a type - whether concrete, constrained or polymorphic
When we apply a function argument to a value we bind the argument to the value
* The binding of variables concerns not only the application of a function argument, but also things like let and where clauses

		addOne :: Integer -> Integer
		addOne x = x + 1

* We don't know the Integer result until the addOne function is applied to an Integer value argument
* When the argument referred to as x is applied to a value, we say that x is now bound to the value the function was applied to
* The function is applied to its argument but it can't return a result until we bind the variable argument to a value

		addOne 1 -- x is now bound to 1
		addOne 1 = 1 + 1
				 =     2

	 	addOne 10 -- x is bound to 10
	 	addOne 10 = 10 + 10 + 1
	 			  =          11

* In addition to binding variables through function argument application, we can use let expressions to declare and bind variables as well

		bindExp :: Integer -> String
		condExp x = let y = 5 in
						"the integer was: " ++ show x
						++ " and y was: " ++ show y

* y in show y is in scope because the let expression binds the variable y to 5
* y is only in scope inside the let expression
* In some cases function arguments are not visible n the function if they have been shadowed:

		bindExp :: Integer -> String
		bindExp x = let x = 10; y = 5 in
						"the integer was: " ++ show x
						++ " and y was: " ++ show y

* If you apply this argument the result never changes:

		Prelude> bindExp 9001
		"the integer was: 10 and y was: 5"

* The definition of x that is innermost in the code takes precedence because Haskell is lexically scoped
* Lexical scoping means that resolving the value for a named entity depends on the location in the code and the lexical content

	Example

		bindExp :: Integer -> String
		bindExp x = let x = 10; y = 5 in "x : " ++ show x
		--     [1]     [2] 							   [3]
					++ " y: " ++ show y


	[1] The argument x introduced in the definition of bindExp - this gets shadowed by the x in [2]

	[2] This is a let-binding and shadows the definition of x introduced as an argument in [1]

	[3] A use of the x bound by [2] - given Haskell's static (lexical) scoping it will always refer to the x defined as x = 10 in the let binding

#### Anonymous functions

* In programming anonymous, or "without a name", refers to the ability to construct objects and use them without naming them
* This is a named function:
	
		triple :: Integer -> Integer
		triple x = x * 3

* This is the same function but with anonymous function syntax:

		(\x -> x * 3) :: Integer -> Intger

(\x -> x * 3) :: Integer -> IntgerAnonymous functions in Haskell are represented by the lambda syntax (\)
(\x -> x * 3) :: Integer -> IntgerAnonymous functions need to be wrapped in parentheses so that our intent is clear

#### Pattern matching

* Pattern matching is a way of matching values against patterns, and where appropriate, binding variables to successful matches
* Patterns can include anything as diverse as undefined variables, numeric literal and list syntax
* Pattern matching allows you to expose and dispatch on data in your function definitions by deconstructing values to expose their inner workings
* We can write functions that can decide between two or more possibilities based on which value it matches
* Patterns are matched against values, or data constructors, not types
* Matching a pattern may fail, proceeding to the next available pattern to match or succeed
* When a match succeeds the variables exposed in the pattern are bound
* Pattern matching proceed from left to right, and outside to inside
* We can pattern match on numbers, in the following example, when the Integer equals true the function returns true, otherwise it is false:

		isItTwo :: Integer -> Bool
		isItTwo 2 = True
		isItTwo _ = False

* The use of the underscore _ after the match against the value 2 is the means of defining a universal pattern that never fails to match, like the"anything else" case
* The order of pattern matches matters!
* The following version of the function will always return False because it will match to the "anything else" case first:

		isItTwo :: Integer -> Bool
		isItTwo _ = False
		isItTwo 2 = True

* Try and order your patterns from the most specific to the least specific
* Bottom is what you get when you don't handle all the possible data

#### Pattern matching against data constructors

* Pattern matching enables us to vary what our functions do given different inputs
* It allows us to unpack and expose the content of our data

		-- registeredUser1.hs
		module RegisteredUser where 

		newtype Username = Username String
		newtype AccountNumber = AccountNumber Integer
		
		data User = UnregisteredUser
          		  | RegisteredUser Username AccountNumber

* With the above example User is a sum with two constructors, UnregisteredUser and RegisteredUser
* Pattern matching can be used to dispatch our function differently depending on the value we get
* The RegisteredUser constructor is a product of two newtypes, Username and AccountNumber
* We can use pattern matching to break down not only the contents of RegisterUser but also that of the newtypes if all the constructors are in scope
* Passing the function an UnregisteredUser returns:

		Prelude> printUser UnregisteredUser
		UnregisteredUser

* The following asks it to match on data constructor RegisteredUser and allows us to construct a User out of a String and Integer:

		Prelude> let myUser = (Username "callen")
		Prelude> let myAcct = (AccountNumber 10456)
		Prelude> printUser $ RegisteredUser myUser myAcct
		callen 10456

* Through the use of pattern matching we were able to unpack the RegisteredUser value of the User type and vary behaviour over the different constructor types

#### Pattern matching tuples

* We can also use pattern matching rather than functions for operating on the contents of tuples

		f :: (a, b) -> (c, d) -> ((b, d), (a, c))
		f (a, b) (c, d) = ((b, d), (a, c))

* This allows the function to look like its type
* Some more examples, though the second is not a pattern match, but all the others are:

		-- matchingTuples1.hs
		module TupleFunctions where

		-- These have to be the same type because --(+)isa->a->a 
		addEmUp2::Numa=>(a,a)->a 
		addEmUp2(x,y)=x+y

		-- addEmUp2 could also be written like so
		addEmUp2Alt :: Num a => (a, a) -> a 
		addEmUp2Alt tup = (fst tup) + (snd tup)

		fst3::(a,b,c)->a 
		fst3(x,_,_)=x

		third3::(a,b,c)->c 
		third3(_,_,x)=x

		Prelude> :l code/matchingTuples1.hs
		[1 of 1] Compiling TupleFunctions
		Ok, modules loaded: TupleFunctions.

Using :browse we can see the list of type signatures and functions

		Prelude> :browse TupleFunctions 
		addEmUp2::Numa=>(a,a)->a 
		addEmUp2Alt :: Num a => (a, a) -> a 
		fst3::(a,b,c)->a 
		third3::(a,b,c)->c

		Prelude> addEmUp2 (10, 20)
		30
		Prelude> addEmUp2Alt (10, 20)
		30
		
		Prelude> fst3 ("blah", 2, [])
		"blah"
		Prelude> third3 ("blah", 2, [])
		[]

#### Case expressions

* Case expressions are a way, similar to if-then-else, of making a function return a different result based on different inputs
* Case expressions can be used with any datatype that has visible data constructors

	Example

		data Bool = False | True
		--	 [1]      [2]    [3]

	[1] Type constructor, we only use this in type signatures, not in ordinary term-level code like case expressions

	[2] Data constructor for the inhabitant of Bool named False - we can match on this

	[3] Data constructor for the inhabitant of Bool named True - we can match on this as well

* Any time we case match or pattern match on a sum type like Bool, we must define how we handle each constructor or provide a default that matches all of them
* We must handle both cases or we will have written a partial function that can throw an error at runtime
* We can write a case expression matching on the constructors of Bool:

		funcZ x = 
			case x + 1 == 1 of
				True -> "Awesome"
				False -> "wut"

* We could also write a simple case expression to tell us if something is a palindrome or not:

		pal xs =
			case xs == reverse xs of
				True  -> "yes"
				False -> "no"

* This can also be written with a where clause in cases where you may need to reuse the y:

		pal' xs =
			case y of
				True  -> "yes"
				False -> "no"
			where y = xs == reverse xs

#### Higher-order functions

* Higher-order functions are functions that accept functions as arguments
* Functions are just arguments, that is why they can be passed around like any other values
* An example of this is the higher-order function flip:

		Prelude> :t flip
		flip :: (a -> b -> c) -> b -> a -> c
		Prelude> let sub = (-)
		Prelude> sub 10 1
		9
		Prelude> let rSub = flip sub
		Prelude> rSub 10 1
		-9
		Prelude> rSub 5 10
		5
		
		
* The implementation of flip is:

		flip :: (a -> b -> c) -> b -> a -> c
		flip f x y = f y x

* Alternatively it could be written as:

		myFlip :: (a -> b -> c) -> b -> a -> c
		myFlip f = \ x y -> f y x

* There is no semantic or meaning difference between flip and myFlip
* One declares the arguments in the function definition, the other declares them instead in the anonymous function value being returned

	Examples

		flip :: (a -> b -> c) -> b -> a -> c
				[     1      ]
		flip f x y = f y x
			[2]     [3]

	[1] When we want to express a function argument within a function type we must use parentheses to nest it

	[2] The argument f is the function a -> b -> c

	[3] We apply f to x and y, but flip will "flip" the order of the application apply f to y and then x instead of the usual order

		data Employee = Coder
	              | Manager
				  | Veep
				  | CEO
				  deriving (Eq, Ord, Show)

		reportBoss :: Employee -> Employee -> IO () 
		reportBoss e e' =
			putStrLn$showe++"isthebossof"++showe'

		employeeRank :: Employee -> Employee -> IO () 
		employeeRank e e' =
			case compare e e' of 
				GT -> reportBoss e e' 
			--	[ 		 1 			]
				EQ -> putStrLn "Neither employee is the boss" 
			--  [ 					2 						]
				LT -> (flip reportBoss) e e' 
			--	[ 			  3 			]

The case in the employeeRank function is a case expression, this function says:

	[1] In the case of comparing e and e' and finding e is greater that e', return reportBoss e e'

	[2] In the case of finding them equal, return the string "neither employee is the boss"

	[3] In the case of find e less than e', flip the function reportBoss - this could also have been written reportBoss e e'

Guards
Guards rely on truth values to decide between two or more possibilities 
if-then-else are not guards!

Where if if condition is an expression that results in a Bool value
The :{ :} notation can be used to write multi-line blocks of code in GHCi (indentation isn't required)

Guard syntax allows us to write compact functions that allow for two or more possible outcomes depending on the truth of the conditions
myAbs with if-then-else

myAbs with a guard block

Each guard has its own equals sign
We don't put one after the argument in the first line of the function definition because each case needs its own expression to return if its branch succeeds
Example

[1] The name of our function, myAbs
[2] Introducing an argument for our function and naming it x
[3] Rather than an = immediately after the introduction of any argument(s) we start a new line and use the | ("pipe") to begin a guard case
 [4] This is the expression we're using to test to see if this branch should be evaluated or not - the guard case expression between the | and = must evaluate to Bool
[5] The = here denotes that we're declaring what expression to return should our x < 0 be true
[6] Then after the = we have the expression (-x) which will be returned if x < 0
[7] Another new line and a | to begin a new guard case
[8] otherwise is just another name for True, used here as a fallback case in case x < 0 was false
[9] Another = to begin declaring the expression to return if we hit the otherwise case
[10] We kick x back out if it wasn't less than 0
We can also use where expressions with guard blocks

The variable y is introduced, not as an argument to the named function but in the guard expression and is defined in the where expression
By defining it there it is in scope for all the guards above it
otherwise was left out, it could have been used for the final case but used less than instead
Wise to use otherwise in the final guard because GHCi can't always tell you when you haven't accounted for all possible cases
Function composition
Function composition is a type of higher-order function that allows us to combine functions such that the result of applying one function gets passed to the next function as an argument
Example


[1] is a function from 'b' to 'c' passed as an argument, hence the parentheses
[2] is a function from 'a' to 'b'
[3] is a value of type 'a', the same as [2] expects as an argument
[4] is a value of type 'c', the same as [1] returns as a result
With the addition of parentheses:

In English:
[1] given a function b to c
[2] given a function a to b
[3] return a function a to c
The basic syntax of function composition looks like this:

The composition operator ( . ) takes two functions here named f and g
The f function corresponds to the (b -> c) in the type signature
The g corresponds to the (a -> b)
The g function is applied to the polymorphic x argument
The result of that application then passes to the f function as its argument
The f function is in turn applied to that argument and evaluated to reach the final result
We can think of the ( . ) or composition operator as being a way of pipelining data through multiple functions
Pointfree style
Pointfree refers to a style of composing functions without specifying their arguments
The "point" in pointfree refers to the arguments, not to the function operator
Pointfree code is tidier and easier to read as it helps the reader focus on the functions rather than the data
Functions in composition are applied from right to left
Demonstrating composition
come back to the print example
