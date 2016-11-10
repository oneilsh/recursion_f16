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
