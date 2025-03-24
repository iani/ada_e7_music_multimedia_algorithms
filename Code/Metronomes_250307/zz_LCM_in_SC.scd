/*
lcm is a built in operator for calculating the least common multiple
of two integers.

lcm does not operate on arrays. So if we want to calculate the lcm of
more than 2 numbers, we must use the method 'inject'.

Here we show how inject is used together with list comprehension using
anonymous arguments (_).  This is an advanced feature, but one can master
its basic use from the examples below.


*/

//:lcm of 2 numbers:
lcm(4, 6); // 12
//:lcm does not work for arrays of numbers. So we have to use inject:
[4, 6].inject(1, _.lcm(_)) // 12
// since 5 is prime, lcm of 4, 5, 6 is lcm of 4, 6 times 5:
[4, 5, 6].inject(1, _.lcm(_));
// [4, 5, 6] can be written as (4..6)
(4..6).inject(1, _.lcm(_));
//lcm of 1..100 is too large to be represented as an integer in SC:
(1..100).inject(1, _.lcm(_)) // about 697203752297329126694202333721250
//so is that of 60..160
(60..160).inject(1, _.lcm(_)) // about 10**36-10**40
//Explanation of _ anonymous argument:
(60..160).inject(1, _.lcm(_))
//translates to:
var nextValue = 1;
(60..160) do: { | item, i |
	nextValue = lcm(thisValue, nextValue, i);
};
