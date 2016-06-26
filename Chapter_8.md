Chapter 8: Recursion
Recursion
Recursion is defining a function in terms of itself via self-referential expressions
The function will continue to call itself and repeat its behaviour until some condition is met to return a result
Allows the data we are processing to decide when we are done and means we don't have to repeat ourselves
Being able to write recursive functions though is essential to Turing completeness
We use a combinator - known as the Y combinator or fixed-point combinator - to write recursive function in Lambda calculus
Haskell has native recursion based on the same principal as this
Factorial
One of the classic functions for demonstrating recursion is factorial
4! is the notation for the factorial function

The way to stop a recursive expression is by having a base case that stops the self-application to further arguments - otherwise the function will not terminate or will terminate incorrectly
Here is what this looks like for factorial:

Because we have the base case factorial 0 = 1 in the fixed version, here is how our reduction changes:

Something about bottom????
Another way to look at recursion
Recursion is self-referential composition
Bottom
⊥ (also referred to as the uptack, zero or empty type) or bottom is a term used in Haskell to refer to computations that do not successfully result in a value
The two main varieties of bottom are:
Computations that failed with an error
Computations that failed to terminate
In logic, ⊥ corresponds to false
 
Examples
This is an example of bottom because it will never return a result:

Here GHCi detected that let x = x in x was never going to return and short circuited the never ending computation
We can write our own functions that will return exceptions:

If we look at this in GHCi:

In the first case we evaluated F False and got 0, that didn't result in a "bottom" value - when we evaluate f True we get an exception which is a means of expressing that a computation failed
Another example of bottom would be a partial function
Functions can fail if we don't define ways to handle all potential inputs, for example through an "otherwise" case
A partial function doesn't handle all of it's inputs, a total function does
Need to go through the just and maybe stuff on page 262/263
http://stackoverflow.com/questions/18808258/what-does-the-just-syntax-mean-in-haskell
Fibonacci numbers
The Fibonacci sequence is a sequence of numbers where each number of the sum of the previous two: 
1, 1, 2, 3, 5, 8, 13, 21, 34... and so on
It is a perfect candidate for a recursive function
The steps on how we would write such a function and the reasoning process:
1. Consider the types:
The sequence only involves positive whole numbers
We are looking at values that of the Int or Integer types
We could use one of those concrete types or use a typeclass for constrained polymorphism
Our type signature will look something like this:

2. Consider the base case
Sometimes it is hard to determine the base case up front
You want to ensure the function will terminate
Fibonacci numbers are positive numbers so a reasonable base case would be zero
The Fibonacci sequence is actually a bit tricker as it really requires two base cases
The sequence has to start off with two numbers since two numbers are always involved for computing the next
Our base case will look something like this:

3. Consider the arguments
We only need to have one variable as an argument in this function
That argument will also be used as arguments within the function due to the recursive process
Every Fibonacci numbers is the result of the preceding two numbers so in addition to a variable x we will need to use (x - 1) and (x - 2) to get both the numbers before the argument
Our argument will look something like this:

4. Consider the recursion
In what way will this function refer to itself and call itself?
We need to add (x - 1) and (x - 2) together to produce a result
But if we do ((6 - 1) + (6 - 2)) = 9 the sixth number of the sequence is not 9!
What we need to do is add the fifth number of the sequence to the fourth so we have to make the function refer to itself:

Now if we apply this function to the value 6 we will get a different result:

This is because it now evaluates recursively:

Zero and one have been defined as being equal to zero and one so that is where the recursion stops and starts adding the result:


Integral division from scratch
Example

 