## Chapter 1 - All You Need is Lambda


* Lambda calculus was devised by Alonzo Church in the 1930s as a way to formalise the concept of effective computability
* The goal of this is to determine which problems, or classes of problems, can be solved

#### Functions:

* A function is a relation between two sets, a set of inputs and a set of outputs
* Inputs referred to as the domain
* Outputs referred to as codomain
* Uniqueness property is important

    Example 

        if there was a function names "f" that defines the following relations where the first value is the input and the second is the output
        The inputs are { 1, 2, 3 } and the outputs are { A, B, C }
 
        f: 1 -> A
        f: 2 -> B
        f: 3 -> C

* Having duplicate values in the set of inputs is problematic as you cannot return two different results for the same input
* A given value can only occur once in a set
* A function can only relate a value in its domain to a single unique value in the codomain

    think of functions as a way of mapping a unique set of inputs to a unique set of outputs
  
        f(x) = x + 1
        f(1) = 1 + 1
        f(1) = 2

#### What is functional programming?

* Functional programming is a computer programming paradigm that relies on definition and application of functions as the basis for programs
* The essence of this is that programs are a combination of expressions to be evaluated
* Expressions are a superset that includes concrete values, variables and functions
* Functions have a more specific definition: they are expressions that are applied to an argument, and once applied can be reduced or evaluated
* There is a need for better methods of handling parallel and concurrent processing and aid the maintaining and refactoring large codebases

#### Purity:

* All functional programming languages are based on the lambda calculus and rely on expressions
* Not all FP languages are equally pure - pure FP is just the lambda calculus
* Impure FP can add ambient effects, mutations and side effects
* In pure programming the same function, given the same values to evaluate, will always return the same result, as it would in math
* Haskell is pure and functional and has a high degree if abstraction and composability
* This means it is easier to write shorter more concise programs by factoring out common, repeated structures into more generic code that can be reused
* Haskell programs are built up as separate independent functions (like LEGO bricks - can be assembled and reassembled as needed)
* Haskell has a minimalistic syntax eg. functions calls are just white space

#### Lambda Calculus:

* Lambda calculus has three basic components:
- expressions
- variables
- abstraction (a lambda itself 'λ' and dot '.')
* Functions (abstractions) have two parts:
- Head - the head of the function is a lambda followed by a variable name that is the parameter or argument of that function
- Body - the body of the function is another expression
* Lambda abstraction of x which would be the same as the identity function:
    
        f(x) = x  
        λ x . x

The following is a basic structure of a lambda abstraction:

    λ x . x
    ^___^
      |______ the extend of the head of the lambda

    λ x . x
      ^______ the single argument the lambda takes
              the variable is bound when the function is applied

    λ x . x
          ^__ the body, the experession the lambda returns when applied
              this is a bound variable

* The . separates the arguments of the lambda from the function body
* The only argument introduced is x
* This is also the identity function in the lambda calculus, so all it does is accept a single argument (x) and return the same value
* When applying the function to an argument eliminate the head
* The head has already done its job which which was to bind a variable
* Replace the instances of bound variables with the argument

    λ x . x (2)
        -- eliminate the head
        -- substitute 2 for each x in the body
    2
    
#### Beta reduction:

* Function application consists of applying the abstraction to another expression
* When applying the function, substitute the input expression for the all instances of bound variables within the abstraction - this process known as beta-reduction
* At the same time the head that binds the variables is eliminated
* When there are no more heads, or lambdas, then you're done
* Computation = initial lambda expression (or two if you want to separate the function and the input) plus a finite sequence of lambda terms, each deduced from the preceding term by one application of beta-reduction
* Keep following the rules of application
* Substitute arguments in for bound variables until there are not more heads left to evaluate
* Or no more arguments to apply to them

    Example

    This is the lambda that is going to be applied to an argument:

        λx.xy

    The lambda is going to be applied to the argument z, the argument x is bound to z, there are then no more arguments to apply in the head so the enclosing lambda has been applied out of existence

        (λx.xy)z.

    Now all occurrences of x can be replaced with, [x := z] indicates that x is bound to z so z will be substituted for all occurrences of x in the expression

        (λ[x := z].xy)

    Replace the x with z, thereby changing the expression

        (λ[x := z].zy)

    Drop the head of the lambda since it's been applied away, then there can be no further reduction

        zy

#### Bound and free variables:

* The head of the lambda abstraction binds variables, its purpose is to tell us which variables to replace when we apply the function
* A bound variable must have the same value throughout the expression
* Sometimes the body of the expression has variables that are not named in the head eg. λx.xy
* The x in the above function is a bound variable because it shows up in the head of the function
* The y is not mentioned in the head of the function so this means it is a free variable
* When we apply this function to an argument nothing can be done with the y, it remains unreducible
* Multiple variables can be bound in a function λxy.xy
* This means a function has been created with nested heads
* When going through beta-reduction, one head is eliminated at a time, starting from the outermost, or leftmost, head

#### Alpha equivalence:

* A basic form of equivalence definable in lambda terms is alpha equivalence
* They take the form of an identity function e.g. λx.x
* Take one argument and kick it back out
* This intuition does not apply for free variables as they are not defined by the enclosing lambda alone
* Each lambda accepts one argument
* Functions that require multiple arguments have multiple, nested heads

    Example

    This is a multiple arguments lambda

        λxy.x

    Apply both lambdas, one nested with the other

        (λx.(λy.x))1 2
    
    Apply the second lambda to the second argument, in this example this means x is bound to 1

        (λy.1)2

    Now the head gets dropped because the last lambda was applied to 2 but there are no variables left in the body expression to bind it to

        λ2.1

    The final result, because nothing could be done with the second argument y because it didn't occur in the body anywhere
        
        1

    Further example

        (λxyz.xz(yz))(λmn.m)(λp.p)
        (λx.λy.λz.xz(yz))(λm.λn.m)(λp.p)
        λz(λm.λn.m)(z)((λp.p)z)
        λz(λn.z)((λp.p)z)
        λz.z

#### Evaluation:

* There are multiple "normal forms" in lambda calculus
* Beta normal form is when you cannot beta reduce the terms any further
* This corresponds to a fully evaluated expression (in programming this would be called a fully executed program)
* An identity function is fully reduced because it hasn't yet been applied to anything and is therefore already in beta normal form λx.x
* (λx.x)z is not in beta normal because the identity function has been applied to a free variable (z) and hasn't been reduced yet

#### Combinators:

* A combinator is a lambda term with no free variables
* Combinators serve only to combine the arguments they are given
* The following are all examples of combinators because there are one or more free variables:
        λy.x
        λx.xz
* Combinators can take one or more functions as their inputs and return another function as an output
* They provide for higher-order functions as well as certain types of recursive functions

####Divergence:

* Not all reducible lambda terms will reduce neatly to a beta normal form
* This is not because they are already fully reduced - they diverge
* Divergence means the reduction process never terminates or ends
* Reducing terms should ordinarily converge to unique beta normal form, divergence is the opposite of convergence 

    Example

    x in the first lambda's head becomes the second lambda
    
        (λx.xx)(λx.xx)
    
    Using [var := expr] to denote what x has been bound to
    
        ([x := (λx.xx]xx)
    
    Substituting (λx.xx) in each for the occurence  of x. 
    
        (λx.xx)(λx.xx) 
