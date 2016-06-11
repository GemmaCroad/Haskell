## Chapter 6 - Typeclasses


#### What are typeclasses?

* Typeclasses allow us to generalise over a set of types in order to define and execute a standard set of features for those types
	* For example if we wanted to test values for equality we would want to be able to use that function for data of various types
	* We can test any data that has a type that implements the typeclass known as Eq for equality
	* We do not need separate equality functions for each different type of data
	* As long as our datatype implements or instantiates the Eq typeclass we can use the standard functions
* Philip Wadler - "The goal is to define a datatype by cases, where one can add new cases to the datatype and new functions over the datatype, without recompiling existing code, and while retaining static safety (e.g. no casts)..."

#### Back to Bool

* Remember to use :info to query information, including the typeclass info, about any function or type (and even some values)

		Prelude> :i Bool
		data Bool = False | True 	-- Defined in ‘GHC.Types’
		instance Bounded Bool -- Defined in ‘GHC.Enum’
		instance Enum Bool -- Defined in ‘GHC.Enum’
		instance Eq Bool -- Defined in ‘GHC.Classes’
		instance Ord Bool -- Defined in ‘GHC.Classes’
		instance Read Bool -- Defined in ‘GHC.Read’
		instance Show Bool -- Defined in ‘GHC.Show’
		Prelude>

* It tells us where the datatype and instances are defined for the compiler
* Then it lists the instances - each of these instances is a typeclass that Bool implements
* These instances are the unique specifications of how Bool makes use of the methods from that typeclass
instance Bounded Bool - Bounded for types that have an upper and lower bound
	* instance Enum Bool - Enum for things that can be enumerated
	* instance Eq Bool - Eq for things that can be tested for equality
	* instance Read Bool - Read parses strings into things * use with caution
	* instance Show Bool - Show renders things into strings

#### Eq

* Some programming languages bake equality into every object, but some datatypes do not have a sensible notion of equality so Haskell does not do this - Eq is defined in the following way:

		Prelude> :i Eq
		class Eq a where
		  (==) :: a -> a -> Bool
		  (/=) :: a -> a -> Bool
		  	-- Defined in ‘GHC.Classes’
		instance Eq Integer
		  -- Defined in ‘integer-gmp-1.0.0.0:GHC.Integer.Type’
		instance (Eq a, Eq b) => Eq (Either a b)
		  -- Defined in ‘Data.Either’
		instance Eq a => Eq [a] -- Defined in ‘GHC.Classes’
		instance Eq Word -- Defined in ‘GHC.Classes’
		instance Eq Ordering -- Defined in ‘GHC.Classes’
		instance Eq Int -- Defined in ‘GHC.Classes’
		instance Eq Float -- Defined in ‘GHC.Classes’
		instance Eq Double -- Defined in ‘GHC.Classes’
		instance Eq Char -- Defined in ‘GHC.Classes’
		instance Eq Bool -- Defined in ‘GHC.Classes’
		-- lots more info 

* The types of (==) and (/=) in Eq tell us something important about these functions:

		(==) :: Eq a => a -> a -> Bool
		(/=) :: Eq a => a -> a -> Bool

* They can be used for any type a which implements the Eq typeclass
* Both functions will take two arguments of the same type and return Bool
* What happens if the arguments aren't the same type e.g. (1, 2) == "puppies!"
	* It will throw an error because '[Char]' doesn't match (t0, t1)
* The type of a is usually set by the leftmost instance of it

#### Num

* Num is  a typeclass implemented by most numeric types and is defined in the following way:

		Prelude> :i Num
		class Num a where
		  (+) :: a -> a -> a
		  (-) :: a -> a -> a
		  (*) :: a -> a -> a
		  negate :: a -> a
		  abs :: a -> a
		  signum :: a -> a
		  fromInteger :: Integer -> a
		  	-- Defined in ‘GHC.Num’
		instance Num Word -- Defined in ‘GHC.Num’
		instance Num Integer -- Defined in ‘GHC.Num’
		instance Num Int -- Defined in ‘GHC.Num’
		instance Num Float -- Defined in ‘GHC.Float’
		instance Num Double -- Defined in ‘GHC.Float’
		Prelude>

#### Integral

* The typeclass Integral has the following definition:

		Prelude> :i Integral
		class (Real a, Enum a) => Integral a where
		  quot :: a -> a -> a
		  rem :: a -> a -> a
		  div :: a -> a -> a
		  mod :: a -> a -> a
		  quotRem :: a -> a -> (a, a)
		  divMod :: a -> a -> (a, a)
		  toInteger :: a -> Integer
		  	-- Defined in ‘GHC.Real’
		instance Integral Word -- Defined in ‘GHC.Real’
		instance Integral Integer -- Defined in ‘GHC.Real’
		instance Integral Int -- Defined in ‘GHC.Real’
		Prelude>

* The typeclass constraint (Real a, Enum a) => means that any type that implements Integral must already have instances for Real and Enum typeclasses
* An integral can employ the methods of both the real number and enumerable typeclasses
* In turn the Real typeclass itself requires an instance of Num
* The Integral typeclass may put the methods of Real and Num into effect, in addition to those of Enum
* Since Real cannot override the methods of Num, this typeclass inheritance is only additive and the ambiguity problems caused by multiple inheritance are avoided
* This is sometimes called the "deadly diamond of death

#### Fractional

* The fractional typeclass has the following definition:

		Prelude> :i Fractional
		class Num a => Fractional a where
		  (/) :: a -> a -> a
		  recip :: a -> a
		  fromRational :: Rational -> a
		  	-- Defined in ‘GHC.Real’
		instance Fractional Float -- Defined in ‘GHC.Float’
		instance Fractional Double -- Defined in ‘GHC.Float’
		Prelude>

* Fractional requires its type argument a to have an instance of Num in order to create an instance of Fractional
* Fractional applies to fewer numbers than Num does 
* Instances of the Fractional class can use the functions defined in Num but not all Num can use functions defined in Fractional
* This is because noting in Num's definition requires an instance of Fractional
 
#### Type-defaulting typeclasses

* When you have a type-class constrained polymorphic value and need to evaluate it, the polymorphism must be resolved to a specific concrete type
* The concrete type must have an instance for all the required typeclass instances
	* e.g. if it is required to implement Num and Fractional then the concrete type can't be an Int
* Ordinarily the concrete type would come from the type signature you've specified or from type inference
* If working in the REPL you may not have specified a concrete type for a polymorphic value
	* In this situation the typeclass will default to a concrete type

		default Num Integer
		default Real Integer
		default Enum Integer
		default Integral Integer
		default Fractional Double
		defauly RealFrac Double
		default Floating Double
		default RealFlot Double

* Monomorphic functions? P173
* Lost generality?
* Types can be made more specific, but not more general or polymorphic

#### Ord

* The typeclass Ord has the following definition:

		Prelude> :i Ord
		class Eq a => Ord a where
		  compare :: a -> a -> Ordering
		  (<) :: a -> a -> Bool
		  (<=) :: a -> a -> Bool
		  (>) :: a -> a -> Bool
		  (>=) :: a -> a -> Bool
		  max :: a -> a -> a
		  min :: a -> a -> a
		  	-- Defined in ‘GHC.Classes’
		instance Ord Integer
		  -- Defined in ‘integer-gmp-1.0.0.0:GHC.Integer.Type’
		instance (Ord a, Ord b) => Ord (Either a b)
		  -- Defined in ‘Data.Either’
		instance Ord a => Ord [a] -- Defined in ‘GHC.Classes’
		instance Ord Word -- Defined in ‘GHC.Classes’
		-- lots more in GHCi

* Ord is constrained by Eq because if we are going to compare items in a list and put them in order then we have to have a way to discover if they are equal in value
* The compare function works for any of the list types listed that implement the Ord typeclass, including Bool
	* Unlike <, >, >= and <= operators this returns an ordering value instead of a Bool value
* True is greater than false
* The max and min functions works similarly

#### Enum

* The typeclass Enum has the following definition:

		Prelude> :i Enum
		class Enum a where
		  succ :: a -> a
		  pred :: a -> a
		  toEnum :: Int -> a
		  fromEnum :: a -> Int
		  enumFrom :: a -> [a]
		  enumFromThen :: a -> a -> [a]
		  enumFromTo :: a -> a -> [a]
		  enumFromThenTo :: a -> a -> a -> [a]
		  	-- Defined in ‘GHC.Enum’
		instance Enum Word -- Defined in ‘GHC.Enum’
		instance Enum Ordering -- Defined in ‘GHC.Enum’
		instance Enum Integer -- Defined in ‘GHC.Enum’
		instance Enum Int -- Defined in ‘GHC.Enum’
		instance Enum Char -- Defined in ‘GHC.Enum’
		instance Enum Bool -- Defined in ‘GHC.Enum’
		instance Enum () -- Defined in ‘GHC.Enum’
		instance Enum Float -- Defined in ‘GHC.Float’
		instance Enum Double -- Defined in ‘GHC.Float’
		Prelude>

* Seems similar to Ord but is slightly different, this typeclass covers types that are enumerable, therefore known to have predecessors and successors
* This can be obtained with the succ and pred funcitons
* The Enum typeclass can use its values in list ranges

#### Show

* Show is the typeclass that provides for the creating of human-readable string representations of structured data
* GHCi uses Show to create string values it can print in the terminal
* The typeclass for Show has the following definition:

		Prelude> :i Show
		class Show a where
		  showsPrec :: Int -> a -> ShowS
		  show :: a -> String
		  showList :: [a] -> ShowS
		  	-- Defined in ‘GHC.Show’
		instance Show a => Show [a] -- Defined in ‘GHC.Show’
		instance Show Word -- Defined in ‘GHC.Show’
		instance Show Ordering -- Defined in ‘GHC.Show’
		instance Show a => Show (Maybe a) -- Defined in ‘GHC.Show’
		instance Show Integer -- Defined in ‘GHC.Show’
		instance Show Int -- Defined in ‘GHC.Show’
		instance Show Char -- Defined in ‘GHC.Show’
		instance Show Bool -- Defined in ‘GHC.Show’
		instance (Show a, Show b, Show c, Show d, Show e, Show f, Show g,
		          Show h, Show i, Show j, Show k, Show l, Show m, Show n, Show o) =>
		         Show (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
		  -- Defined in ‘GHC.Show’
		-- lots more in GHCi  

* There are various number types, Bool values, tuples and characters that already instances of Show
* * They have a built-in ability to be printed to the screen
There is also a function show which takes a polymorphic a and returns it as a string allowing it to be printed

#### Printing and side effects

* The typeclass for Print has the following definition:

		Prelude> :i print
		print :: Show a => a -> IO () 	-- Defined in ‘System.IO’
		Prelude>

* The function is not just applied to the arguments that are in scope but also asked to affect the world outside its scope in some way, namely by showing the results on a screen
	* This is known as a side effect, a potentially observable result apart form the value the expression evaluates to
* Haskell managed effects by separating effecful computations from pure computations in ways that preserve the predictability and safety of function evaluation
* Importantly, effect-bearing computations themselves become more composable and easier to reason about
* The benefits of explicit effects include the fact that is makes it relatively easy to reason about and predict the results of our functions

#### Working with Show
 
* It is possible to define our own datatypes as well as our typeclasses (will cover later in depth)
* A minimal implementation of an instance of Show only requires that show or showPrec be implemented

	Example

		data Mood = Blah

		instance Show Mood where
			show _ = "Blah"

		*Main> Blah
		Blah	

* Here is what happens in GHCI when you define a datatype and ask GHCi to show it without the instance for the Show typeclass:

		Prelude> Blah

		No instance for (Show Mood) arising
			from a use of 'print'
		In a stmt of an interactive GHCi command: print it	

* Now let's look at how you define a datatype to have an instance of Show:
	
		Prelude> data Mood = Blah deriving Show
		Prelude> Blah
		Blah

* We can, and in this case should, just derive the Show instance for Mood

#### Typeclass deriving

* Typeclass instances that we can 'magically' derive are Eq, Ord, Enum, Bounded, Read and Show
* There are some constraints on deriving some of these
* Deriving means we don't have to manually write instances of these typeclasses for each new datatype we create

#### Read

* The typeclass for Read has the following definition:

		Prelude> :i Read
		class Read a where
		  readsPrec :: Int -> ReadS a
		  readList :: ReadS [a]
		  GHC.Read.readPrec :: Text.ParserCombinators.ReadPrec.ReadPrec a
		  GHC.Read.readListPrec ::
		    Text.ParserCombinators.ReadPrec.ReadPrec [a]
		  	-- Defined in ‘GHC.Read’
		instance Read a => Read [a] -- Defined in ‘GHC.Read’
		instance Read Word -- Defined in ‘GHC.Read’
		instance Read Ordering -- Defined in ‘GHC.Read’
		instance Read a => Read (Maybe a) -- Defined in ‘GHC.Read’
		instance Read Integer -- Defined in ‘GHC.Read’
		instance Read Int -- Defined in ‘GHC.Read’
		instance Read Float -- Defined in ‘GHC.Read’
		instance Read Double -- Defined in ‘GHC.Read’
		instance Read Char -- Defined in ‘GHC.Read’
		instance Read Bool -- Defined in ‘GHC.Read’
		instance (Read a, Read b, Read c, Read d, Read e, Read f, Read g,
		          Read h, Read i, Read j, Read k, Read l, Read m, Read n, Read o) =>
		         Read (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
		  -- Defined in ‘GHC.Read’

* Like Show, a lot of types have instances of Read
* Where Show takes things and turns them into human-readable string, Read takes strings and turns them into things
* Read is a problem
	* There is no way Read a => String -> a will always work
	* A string is a list, which could be empty in some cases, or stretch to infinity in other cases
* Integer has a Read instance
	* We are in no way guaranteed that the String will be a valid representation of an Integer value
	* A String value can be ANY text
	* That's way too big of a type or things we want to parse into numbers

		Prelude> read "1234567" :: Integer
		1234567
		Prelude> read "BLAH" :: Integer
		*** Exception: Prelude.read: no parse

* This error means that read is a partial function
	* A function that doesn't return a proper value as a result for all possible inputs
* Try not to use Read - Haskell gives us other options
