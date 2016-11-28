
#### Nov. 28, 2016
## Seq. Alignment Memoization, Cache Inspection

Memoization additions: https://github.com/oneilsh/recursion_f16/commit/e608d4ee73d9f011830c9f79556cbb6bd7250d28
Visualization additions: https://github.com/oneilsh/recursion_f16/commit/dcba679575ab6c47e8c798e0240e4cf715b30383



#### Nov. 23, 2016
## Proofs by Contradiction, Proof & Implementation of Recursive Alignment

Code: https://github.com/oneilsh/recursion_f16/commit/14febfc8e1e693db2ab1d065556b93baf848784e

**Easyish question:** (Well, somewhere in between easyish and hardish, actually.) When aligning
two sequences, one of length *m* and one of length *n*, how deep does the call stack get in terms
of *m* and *n*? You can use O()-notation if you like, though argue for your answer.

**Difficultish question:** Our friend the bee is located in a field of flowers:

![Bee Field](http://i.imgur.com/YhaAya4.png)


His task is to visit all of the flowers, but being a busy bee he wants to take the shortest route possible to do it. Figuring out the shortest route is no easy task, even for a bee. Still, we can say some things about how it will end up looking.

Prove (perhaps by contradiction...) that when he does figure out the shortest path, it *won't cross itself*. (This is an example of a [hamiltonian path](https://en.wikipedia.org/wiki/Hamiltonian_path) problem situated in geometric/Euclidean space. The hamiltonian path problem on a network/graph has been used extensively in the area of [genome assembly](http://bib.oxfordjournals.org/content/10/4/354.full)).


#### Nov. 21, 2016
## Seq. Alignment Easy Cases & Recursive Definition

Code: https://github.com/oneilsh/recursion_f16/commit/a0b867b9bdb4990e5e94dbb6fec3dcf57c091d61

**Easyish question:** 





#### Nov. 18, 2016
## Hash Tables, Memoization, Dynamic Programming, Order Notation

Code: https://github.com/oneilsh/recursion_f16/commit/49f13b923b78a9fa3cf63cafc7b5185488c76cfa

**Easyish question:** Douglas Hofstadter's "Q-Sequence" is defined recursively:

Q(1) = 1
Q(2) = 1
Q(n) = Q(n - Q(n - 1)) + Q(n - Q(n-2))

Compute the first 1,000 Q-numbers, and plot them (n on x-axis, Q(n) on y axis, with a line).

**Easyish question:** What is the run time, in Order (big-O) notation, of the following sort function? Let the length of the input vector be *n*, and argue for your answer. 

```
# sorts a vector of numbers
sorty <- function(nums) {
  for(i in seq(1, length(nums))) {
    for(j in seq(1, length(nums) - 1)) {
      if(nums[j] > nums[j+1]) {
        larger <- nums[j]
        smaller <- nums[j+1]
        nums[j] <- smaller
        nums[j+1] <- larger
      }
    }
  }
  return(nums)
}

print(sorty(c(4, 5, 6, 1, 7, 9, 2, 3, 8)))
```

**Difficultish question:** Suppose we want to implement a hash table. The ``library(openssl)``
library includes some of the functions needed; for example, if `"joe"` is the key we want to hash with,
`sha1("joe")` will return a pseudo-random number based on it in hexadecimal format. We can convert
it to a large decimal number with `bignum(sha1("joe"), hex = TRUE)`. Further, 104729 is a large
prime number. We can get the "hash bucket" of `"joe"` by getting the modulus value of `"joe"`s large
number as: `bignum(sha1("joe"), hex = TRUE) %% bignum(104729)`. 

Using this info, and lists within lists (potentially within lists...), implement a hash table with 104729 buckets as a set of functions. For example `newhash <- myhash()` should return a new hash, `updated_hash <- insert_into_myhash(newhash, "joe", 34)` should store the value 34 at the key "joe", and `print(get_value_myhash(newhash, "joe"))` should print the value 34. Be careful though: the result of `%%` could be 0, but the first element in an R list is at index 1. 





#### Nov. 16, 2016
## The Call Stack, Memoization Intro

Code: https://github.com/oneilsh/recursion_f16/commit/f4fb19e196afdacc74ac0c8157ff39f802cbc899

**Easyish question:** Write code to determine how many stack frames can be allocated in your instance of R until you get an "infinite recursion" error. Does it change depending on the "size" of the stack frames? (That is, can you recurse deeper if there are fewer and smaller local variables vs many large ones per call?)

**Difficultish question:** Here's a table of the first 20 Fibonacci numbers, and the number of calls
the recursive method uses to compute them:

```
  n fibn calls
  1    1     1
  2    1     1
  3    2     3
  4    3     5
  5    5     9
  6    8    15
  7   13    25
  8   21    41
  9   34    67
 10   55   109
 11   89   177
 12  144   287
 13  233   465
 14  377   753
 15  610  1219
 16  987  1973
 17 1597  3193
 18 2584  5167
 19 4181  8361
 20 6765 13529
```

Define an equation for *calls* in terms of *fibn* (e.g., *calls(n) = 2 fib(n)*, though this isn't quite correct). Prove that your equation is correct (using induction).





#### Nov. 14, 2016
## BST efficiency, Induction, Fibonacci/Bees, Stacks

Binary search trees are cool, "balanced" binary search trees are even cooler, as
they keep themselves, well, balanced. Here's a nice implementation of a Red-Black Tree
in R: https://github.com/tarakc02/rbst (what can I say, I like it because he cites me).
What is (as usual) interesting about these is that they are proved to stay in balance,
thus gauranteeing efficiecy. The proof is, you guessed it, based on structural induction. 

Code written for today: https://github.com/oneilsh/recursion_f16/commit/9ebd7052c4d588a2e07d0f7a641a371d65a695b4

**Easyish question:** Implement a stack by writing `insert_top()`, `without_top()`, and `peek_top()` for on  nested-list structure we explored. These functions should be pure (ie, side-effect-free), and
shouldn't need to use either loops or recursion (thus allowing them to be the same speed no matter how big it is).

**Easyish question:** Consider binary trees of the type we've been talking about. Prove (using structural  induction) that the number of nodes in such a tree is always odd. [You can consider the `NULL` values nodes or not, it won't make a difference.]



#### Nov. 9, 2016
## More recursion on lists, binary trees

**_Note:_** I've figured out what ya'll will have to do to earn a certificate for this workshop: As we go along, every day I will post some "easyish" questions, and in a about a week start mixing in some "difficultish" questions. You'll need to complete 10 easyish questions, and 2 difficultish questions.

Here's the code we wrote in class: https://github.com/oneilsh/recursion_f16/commit/71526faebb3fc43b412ee2a754ba8869d431596a

**Easyish Question:** Write a recursive `get_smallest_in_tree()` function which returns the smallest element from a binary search tree.

**Easyish Question:** Modify the `insert_tree()` function so that no duplicate items can be inserted; if the user attempts to add a duplicate item, print a warning with  `warning("Sorry, ", new_el, " is a duplicate element.")`. In this case the original tree should be returned. That is,

```
t <- NULL
t <- insert_tree(t, "A")
t <- insert_tree(t, "B")
t <- insert_tree(t, "C")
print_tree(t)
```

should print A, B, and C, and then 

```
t <- insert_tree(t, "B")
print_tree(t)
```

should result in a warning and again print A, B, C.





#### Nov. 7, 2016
## Functions, lists, etc.

Here's the code we wrote in class today: https://github.com/oneilsh/recursion_f16/commit/7668e60eca3f920479fec828a1d5cd456d6399eb

**Easyish Question:** Without writing any code, try to figure what would happen if `print(el)` was called *after* `print_list(rest)` in the `print_list()` function. Try it in code, and describe in some detail what happens and why.


#### Nov. 4, 2016
## Workshop Description

* Times: Mon/Wed/Fri @ 9am - 10am, Nov. 7 to Dec. 2 
* No meeting Fri Nov. 25 [Thanksgiving], nor Fri Nov. 11 [Veterans Day]
* Location: Kearney 305 (probably)
* TA: None
* Textbook: None (yet)
* Office Hours: Generally after class, and by appt.

Description: 

This course explores and implements several problem-solving techniques that are related and particularly beautiful: recursion, (self-referential processes), dynamic programming (guided deconstruction of problems into subproblems), and induction (the mathematical proof technique). After some practice with basic recursive methods (the Fibonacci sequence and predator-prey recurrence relations), we'll cover variations of the sequence-alignment problem from multiple perspectives, including the local heuristic used by BLAST.

Topics covered along the way include memoization, dynamic programming, proofs by contradiction, and data structures like lists, hash tables, stacks, trees, and the call stack. Finally, we'll explore graphical modeling of plants with L-system fractals and if time allows other applications that utilize recursion and dynamic programming (e.g. Hidden Markov Models).




#### Nov. 3, 2016
## Recursion and Dynamic Programming workshop, Fall 2016

Since my computer is being a bit flaky currently, I think I'll go the "easy" way out and use a github repo as the class website. There are a few advantages and disadvantages to this--we'll have to take em as we get em. 

You may be curious how you can "sync" this repo (which is essentially just a folder with some files) to your own desktop  (aka "clone"). It's easy! Well, almost: first you will need to install git: https://git-scm.com/downloads

Next, in RStudio, select File -> New Project -> Version Control -> Git. In the Clone URL, enter https://github.com/oneilsh/recursion_f16.git You can use whatever you like for the "project directory name" but I would suggest recursion_f16. You can also browse with the "Browse" button to select where it should be saved.

When contents of this repository are updated (which should be every class day, if I am good about remembering to do so), you can get the latest version by selecting the "Git" button within the RStudio interface (assuming you have the project open in RStudio), and select "Pull Branches".
