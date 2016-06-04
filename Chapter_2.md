## Chapter 2 - Hello, Haskell!


#### Interacting with Haskell code

* Two primary ways of writing and compiling code
* First is inputting it directly into the interactive environment known as GHCi or the REPL
* The second is typing it into a text editor, saving the file and then loading the source file into GHCi
* REPL: Read-Eval-Print Loop
* GHCi: stack ghci to open and :quit or :q to exit

#### Saving scripts and loading them

* .hs file extension denotes a Haskell source code file
* Create a test.hs file
* Inside the file write the code:
	sayHello x = putStrLn ("Hello, " ++ x ++ "!")
	sayHello :: String -> IO ()
* :: is the way to write down a type signature, it’s a way of saying “has the type
* In the same directory the .hs file is stored in open ghci and  do the following:
	Prelude> :load test.hs
	Prelude> sayHello "Tina"
	Hello, Tina!
	Prelude>
* : and :load are not Haskell code, just a GHCi feature
* After loading the sayHello function is visible in the REPL and a string argument can be passed in

#### Understanding expressions

* Everything in Haskell is an expression or declarations
* Expressions may be values, combinations of values, and/or functions applied to values
* Expressions evaluate to a result
* Haskell’s expressions evaluate to a result in a predictable, transparent manner
* If we enter 1 into GHCi it prints 1 because it cannot be reduced any further
* If we enter 1 + 2 it prints the number 3 because the reduction terminates there, there are no more terms to evaluate
* Expressions can be nested in numbers e.g. ((1+2)*3)+100 which prints 109
* We say that expressions are in normal form when there are no more evaluation steps that can be taken or when they have reached an irreducible form
* 1 + 1 is a reducible expression, while 2 is an expression it is no longer reducible, it can’t evaluate into anything other than itself
* Reducible expressions are also called redexes

#### Functions

* Expressions are the most basic unit of Haskell programming
* Functions are a specific type of expression
* Related to functions in mathematics where they map an input or set of inputs to an output
* As in lambda calculus all functions in Haskell take one argument and return one result
* If we are passing in multiple arguments to a function, we are actually applying a series of nested functions, each to one argument
* This is called currying?
* Functions allows us to use abstract parts of the code we may want to reuse for different literal values
* Functions are how we factor out a pattern into something we can reuse with different inputs

#### Defining Functions

* Function definitions all share a few things in common:
* They start with the name of the function
* This is followed by the formal arguments or parameters
* Then there is an equals sign which does not imply equality of value
* Then there is an expression that is the body of the function
* To introduce definitions of values or functions in GHCI it needs to looks like this: 

	Prelude> let triple x = x * 3

* In a source file (triple.hs) it would look like this:

	Triple x = x * 3

* Function names in Haskell should start with a lowercase letter
* Names of modules and names of types (such as Integer) should start with a capital letter
* They can also be CamelCase with multiple-word names
* Variables are lowercase

#### Evaluating Functions

* Calling a function by name and introducing a value for the argument makes a function a reducible expression
* In a pure functional language like Haskell, applications of functions can be replaced with their definitions and the outcome would be the same result still

Example

	triple 2
	(triple x = x * 3) 2
	(triple 2 = 2 * 3)
	2 * 3
	6

#### Conventions for variables

* These are the general naming conventions are are not definite rules:
* Type variables generally start and a and go from there, occasionally they may have numbers appended to them
* Functions can be used as arguments and in the case are typically labeled with variables starting at f, they can have numbers appended and may also sometimes be decorates with the ` character - this normally denotes that a function is closely related to or is a helper function
* Arguments to functions are most often given names starting at x, and again may occasionally be seen to be numbers e.g. x1

#### Infix Operators
* Functions in Haskell default to prefix syntax, this means that the function being applied is at the beginning of the expression rather than in the middle
* Operators are functions which can be us in infix style
* All operators are functions; not all functions are operators

Examples

	Prelude> 100 + 100
	200

	Prelude> 768395 * 21356345
	16410108716275

	Prelude> 123123 / 123
	1001.0

	Prelude>476 - 36
	440

	Prelude>10 / 4
	2.5

#### Associativity and precedence

* There is a default associativity and precedence to the infix operators
* Can access this via the :info command in GHCi, it will provide the type information and tells you whether it's an infix operator with precedence

	Examples

	:info (*)
	infixl   7   *
	--  [1] [2] [3]

	:info (+) (-)
	infixl   6   +, -
	--			  [4]

	[1] Infixl means infix operator, left associative
	[2] 7 is the precedence, higher is applied first, on a scale of 0-9
	[3] Infix function name, in this case multiplication
	[4] The comma is here to assign left-associativity and precedence 6 for two functions (+) and (-)

	-- this
	2 * 3 * 4

	-- is evaluates as if it was
	(2 * 3) * 4
	-- Because of left-associativity from infixl

	Here is an example of a right-associative infix operator 

	Prelude> :info (^)
	infixr   8   ^
	-- [1]  [2] [3]
 
	[1] Infixr means infix operator, right associative
	[2] 8 is the precedence, higher precedence is applied first
	[3] Infix function name, in this case exponentiation


* Adding parenthesis starting from the right-hand side of an expression when an operator is right-associative doesn't change anything
* However, if we parenthesise from the left we actually get a different result when the expression is evaluated
* BODMAS (brackets, orders (inc. power of), division, multiplication, addition and subtraction

#### Declaring values

* The order of declarations in a source code file doesn't matter because GHCi loads the entire file at once, so it knows all of the values that have been specified, regardless of the order they appear in
* If declarations are entered one-by-one in REPL then the order does matter

#### Troubleshooting

* Indentation in Haskell code is significant and can change the meaning of the code
* Use spaces not tabs!
* Whitespace also tends to be significant in Haskell
* To comment code out use --

#### Arithmetic functions in Haskell

Operator  Name  Purpose / application

+		plus		addition
-   	minus		subtraction
*		asterisk	multiplication
/		slash		fractional division
div		divide		integral division, round down
mod		modulo		similar to 'rem' but after modular division
quot	quotient		integral division, round towards zero
rem		remainder	remainder after division

#### Negative numbers

* Negative numbers get special treatment in Haskell due to the interaction of parentheses and infix syntax
* If you want a value that is a negative number by itself this will work just fine e.g. -1000
* However this will not work in some cases 1000 + -9 - this will give an error message saying that problem is due to precedence before any code can execute
* Addition and subtraction have the same precedence (6) and GHCi doesn't know how to resolve this to evaluate the expression
* In order to make the above work it would need to be 1000 + (-9)

#### 'Syntactic Sugar'

* The negation of numbers in Haskell by the use of a unary is a form of syntactic sugar
* Syntax is the grammar and structure of the text we use to express programs
* Syntactic sugar is a means for us to make that text easier to read and write
* It is called this because while it can make typing or reading code nicer it changes nothing about the semantics of the program and doesn't change how we solve problems in code
* When code with syntactic sugar is processed or compiled, a simple transformation from the shorter sweeter form to a more verbose, truer representation is performed after the code has been parsed

* In the specific case of -, the syntax sugar means the operator now has two possible interpretations, subtractions or a negative number
* The following are semantically identical (they have the same meaning, despite the different syntax) because the - is translated into negate

	Prelude> 2000 + (-1234)
	766

	Prelude> 2000 + (negate 1234)
	766

* Whereas this is case of - being used for subtraction

	Prelude> 2000 - 1234
	766

#### Parenthesising infix functions

* There are times when you may want to refer to an infix function without applying any arguments and there are also times you may want to use them as prefix operators instead of infix
* In both of these cases the operator must be wrapped in parenthesis
* If the infix function is >> then it would need to be written as (>>) to refer to it as a value
* (+) is the addition infix function without any arguments applied yet
* (+1) is the same addition function but with one argument applied making it return the next argument it is applied to plus one
* This is known as sectioning and allows the passing around of partially-applied functions
* If you use sectioning with a function that is not commutative the order matters

	Prelude> (1/) 2
	0.5

	Prelude>(/1) 2
	2.0

* Subtractions is a special case as these will work

	Prelude> 2 - 1
	1

	Prelude> (-) 2 1
	1

* However this won't work as enclosing a value inside of parentheses with the - indicates to GHCi that it's the argument of a function

	Prelude> (-2) 1

* You can use sectioning for subtraction but it must be the first argument

#### Laws for quotients and remainders

* Not sure about this!

#### Evaluation

* Reducing an expression means we are talking about evaluating the terms until it reaches its simplest form
* Once it is at this stage then we say it is irreducible or finished evaluating
Haskell uses a non-strict evaluation, sometimes called "lazy evaluation", strategy which defers evaluation of terms until they're forced by others terms referring to them
* Values are irreducible
* Applications of functions are reducible

#### Let and where

* Use let and where to introduce names for expressions

	Examples
	
	printInc n = print plusTwo
		where plusTwo = n + 2

	printInc2 n = let plusTwo = n + 2
				  in print plusTwo	

#### The lambdas beneath let expressions

* Anonymous function syntax in Haskell uses a backslash to represent a lambda
* It looks similar to the way it looks in lambda calculus and we can use it by wrapping it in parentheses and applying it to values

	Examples

	(\x -> x) 0 evaluates to 0

	(\x -> x) 1 evaluates to 1

	(\x -> x) "blah" evaluates to "blah"

#### Parenthesisation

* $ - evaluate everything to the right of me first
* It is a convenience operator for when you want to express something with fewer parentheses

#### Definitions

* Check if any of the ones mentioned are not covered by the above notes
