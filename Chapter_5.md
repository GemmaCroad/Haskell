## Chapter 5 - Types


#### What are types?

* Expressions when evaluated reduce to values, and every value has a type
Types that share something in common can be grouped together
Data constructors are the values of a particular type
In Haskell you cannot create untyped data
Strong typing means that you are guranteed not to have certain sorts of error in the code - if a function expects an integral value you cannot out a string or some other type of value in there, it will not typecheck and it will not compile
A strong, static type system if often a lot of upfront cost but comes wiht a later payoff
Static typing - types are known to the compiler and checked for mismathces, or type errors, at compile time
Type inference - the compiler will infer types for expressions that have no declared type

Querying and reading types
When we query numeric values, we see typeclass information because the compiler doesn't know which specific numeric type a value is until the type is either declared or the compiler is forced to infer a specific type based on the function
Example
Prelude> :type 13
13 :: Num a => a
13 may look like it is just an integer, but that would only allow us to use it in computations that take integers and not in something like fractional division
For that reason the compiler gives it the type with the broadest applicability and saya it's a constrained polymorphic Num  a => a value
-> is the type constructor for functions in Haskell and is baked into the language
Syntactically it works like all the other types except it takes arguments and has no data constructors

Since it has no data constructors the value of type > that shows up at termlevel is the function
Functions are values
The two-tuple is very similar 

Example
The function fst is a value of type (a,b) -> a where -> is an infix that type that takes two arguments

[1] Argument to fst has the type (a, b), note that the tuple type itself (,) takes two arguments
[2] The function type -> here is taking two arguments, one is the the argument (a, b) and one is the result a
[3] The result of the function which has type a, is the same a that was in the tuple (a, b)
Typeclass constrained type variables
The act of wrapping an infix operator in parentheses allows us to use the function just like a normal prefix function, including being able to query the type

To describe addition we can say it takes one numeric argument, adds it to a second numeric argument of the same type and returns a number value of the same type as a result
To describe the fractional devision we can say that takes a fractional value, divides it by a second fractional value and returns a third fractional value as a result
The compiler will give the least specific and most general type it can
Num and fractional are typeclasses, not concrete types
Each typeclass offers a standard set of functions that can be used across several concrete types
When a typeclass is constraining a type variable in this way the variable could represent any of the concrete types that have instances of that typeclass
We say something is constrained because we still don't know the concrete type of a, but we do know it can only be one of the types that has a Num instance
A type signature can have multiple typeclass constraints on one or more of the variables

Currying
All functions in Haskell take one argument and return one result
There is no support built into Haskell for multiple arguments however there are syntactic conveniences that construct curried functions by default
The arrows in type signatures denote the function type, each arrow represents one argument and one result with the final type being the final result
Example

[1] Typeclass constraint saying that a must have an instance of num
[2] The boundaries of 2 demarcate what we could call the two "arguments" of the functions (+), but really all functions take one argument and return one result - this is because all functions in Haskell and nested and the -> represents successive function applications, each taking one argument and returning one result - this is called currying
 [3] The result type for this function
The way the type constructor for functions is defined makes currying the default in Haskell
This is because it is an infix operator and right associative

The way the type constructor for functions is defined makes currying the default in Haskell
This is because it is an infix operator and right associative

Binding variables to types
Need to come back and go over this!
Manual currying and uncurry
Haskell is curried by default, but you can uncurry functions
Uncurrying means un-nesting the functions and replacing the two functions with a tuple of two values (these would need to be the two values you want to use as arguments)
If you uncurry (+) the type changes from Num => a -> a -> a to Num a => (a, a) -> a which better fits the description "take two arguments, return one result"
Uncurried functions: one function, many arguments
Curried functions: many functions, one argument apiece
Polymorphism
Polymorph comes from the Greek words poly for "many" and morph for "form" - so polymorphic means made of many forms
This is in contrast with monomorphic which is made of one form
Type signatures may have three kinds of types:
Concrete
Constrained polymorphic
Parametrically polymorphic
If a type is a set of possible values, then a type variable represents a set of possible types
Typeclass constraints limit the set of potential types while also passing along the common functions that can be used with those values
Concrete types have even more flexibility in terms of computation, this is because of the additive nature of typeclass for one thing
Polymorphic constants
There are several types of numbers in Haskell and there are constraints on using different types of numbers in different functions
(-10) + 6.3 works just fine, but why?

We can see that the type of (-10) is given maximum polymorphism by only being an instance of the num typeclass which could be any type of number
This is called a polymorphic constant
Type inference
Haskell does not obligate us to assert a type for every expression or value in our programs because it has type inference
Type inference is an algorithm for determining the types of expressions
Haskell's type inference is built on an extended version of the Damas-Hindley-Milner type system
The compiler starts from the values whose type it knows and then works out the types of the other values
It is considered good practice to explicitly declare the types of functions
Examples

The compiler knows the function ++ and has one value to work with already and knows that is a string - it doesn't have to work very hard to infer a type signature from that information

We are back to a polymorphic type signature, the same as the signature for (++) itself because the compiler has no information by which to infer the types for any of the variables other then they are lists of some sort
Asserting types for declarations
It is good practice to declare types rather than relying on type inference
Can provide guidance for writing functions
Can help the compiler give you information about where the code is going wrong
If we allow the compiler to infer the type on the following function it looks like this:

The triple function was made from the (*) function which has type (*) :: Num a => a ->  -> a but we have already applied one of the arguments (3) so there is one less parameter in the type signature
It is still polymorphic because it can't tell what type 3 is yet
If we want to ensure that our input and result are only integers then we would declare it:

It is possible to declare types locally with and where clauses
There are constraints on our ability to declare types, for example making the (+) function return a string
Definitions
Parametricity is the property that holds in the presence of parametric polymorphism
States the behaviour of a function will be uniform across all concrete applications of the function
Typeclass is a means of expressing faculties or interfaces that multiple datatypes may have in common and then write code just in terms of those commonalities without repeating for each instance
Type variable is a way to refer to an unspecified type or set of types in Haskell type signatures
Type inference is a faculty some programming languages have to infer principal types from terms without needing explicit type annotations
Principle type is the most generic type which still typechecks
Polymorphism refers to type variables which may refer to more than one concrete type
Ad-hoc polymorphism (also called 'constrained polymorphism') is polymorphism that applies one or more typeclass constraints to what would have otherwise been a parametrically polymorphic type variable