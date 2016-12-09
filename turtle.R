# Da package for drawing
library(TurtleGraphics)

# Initiate the turtle, let him go off the screen 
# if he wants
turtle_init(mode = "clip")

# get his current position and angle
print(turtle_getpos())
print(turtle_getangle())

# some basic turtle commands
turtle_forward(10)
turtle_up()
turtle_forward(10)
turtle_down()
turtle_forward(10)
turtle_turn(45, "right")
turtle_col("red")
turtle_forward(10)
turtle_lwd(4)
turtle_forward(10)

# let's hide the turtle
turtle_init(mode = "clip")
turtle_hide()

# this makes it easier to draw more complex stuff
for(size in seq(1,20)) {
  turtle_forward(size)
  simple_tree(size)
  turtle_turn(30, "left")
}

# a helper function to get the turtles "state" (x, y, pos)
turtle_getstate <- function() {
  s <- c(turtle_getpos(), turtle_getangle()) # x,y,angle vector
  return(s)  
}

# a helper function to set the turtles "state" (x, y, pos)
turtle_setstate <- function(s) {
  turtle_setpos(s[1], s[2])
  turtle_setangle(s[3])
}


# example get state, set state
turtle_init(mode = "clip")
turtle_hide()

s <- turtle_getstate()
turtle_turn(45, "right")
turtle_forward(10)
turtle_setstate(s)
turtle_forward(20)


# tree function - recursive!
simple_tree <- function(size) {
  if(size < 1.0) {
    return(invisible())
  }
  stored_state <- turtle_getstate() # 1
  turtle_forward(size)              # 2
  turtle_turn(30, "left")           # 3
  turtle_forward(size * 0.5)        # 4
  simple_tree(size * 0.7)
  turtle_up()
  turtle_backward(size * 0.5)       # 5
  turtle_down()
  turtle_turn(70, "right")          # 6
  turtle_forward(size * 0.5)        # 7
  simple_tree(size * 0.65)
  turtle_setstate(stored_state)     # 8
}

# here's a try
turtle_init(mode = "clip")
turtle_hide()

turtle_setstate(c(50, 10, 0)) # x y angle
simple_tree(16)


# recursive function for drawing the koch curve
koch_curve <- function(size, limit) {
  if(size < limit) {
    turtle_forward(size)
  } else {
    koch_curve(size/3, limit)
    turtle_turn(60, "left")
    koch_curve(size/3, limit)
    turtle_turn(120, "right")
    koch_curve(size/3, limit)
    turtle_turn(60, "left")
    koch_curve(size/3, limit)
  }
}

# draw a few koch curves
turtle_init(mode = "clip")
turtle_hide()

turtle_setstate(c(10, 90, 90)) # x y angle
koch_curve(80, limit = 81)
turtle_setstate(c(10, 65, 90)) # x y angle
koch_curve(80, limit = 40)
turtle_setstate(c(10, 45, 90)) # x y angle
koch_curve(80, limit = 15)
turtle_setstate(c(10, 25, 90)) # x y angle
koch_curve(80, limit = 7)
turtle_setstate(c(10, 5, 90)) # x y angle
koch_curve(80, limit = 1.5)


# function that tells the turtle to draw some text
turtle_text <- function(label, col = "black", fontsize = 20) {
  grid.text(label, 
            turtle_getpos()[1], 
            turtle_getpos()[2], 
            rot = -1*turtle_getangle(), 
            default.units = "native", 
            gp = gpar(fontsize = fontsize, col = col))  
}

# example of drawing text
turtle_init(mode = "clip")
turtle_hide()

turtle_forward(10)
turtle_text("hi!")



# binary search tree; either NULL or
# list(left, el, right), where left and right
# are also binary search trees
# inserting a new element in the right spot, based on the rules
insert_tree <- function(data, new_el) {
  if(is.null(data)) {
    return(list(NULL, new_el, NULL))
  }
  
  left <- data[[1]]
  el <- data[[2]]
  right <- data[[3]]
  
  if(new_el < el) {
    new_left <- insert_tree(left, new_el)
    return(list(new_left, el, right))
  } else {
    new_right <- insert_tree(right, new_el)
    return(list(left, el, new_right))
  }
}


# a function that draws a binary search tree--recursively!
draw_tree <- function(data) {
  if(is.null(data)) {
    return(invisible())
  }
  
  left <- data[[1]]
  el <- data[[2]]
  right <- data[[3]]
  
  current_state <- turtle_getstate()
  turtle_text(el)
  
  turtle_turn(30, "left")
  turtle_forward(10)
  draw_tree(left)
  turtle_setstate(current_state)
  turtle_turn(30, "right")
  turtle_forward(10)
  draw_tree(right)
}




# lets create a binary search tree t with random elements
nums <- sample(seq(1,20), 20) # random nums
print(nums)

t <- NULL
for(num in nums) {
  t <- insert_tree(t, num)
}


# draw it!
turtle_init(mode = "clip")
turtle_hide()

turtle_setstate(c(50, 90, 180)) # x, y, angle
draw_tree(t)






# utility functions
############################
# eg "ACT" -> c("", "A", "C", "T")
char_vec <- function(input, prepend = c()) {
  c_vec <- str_split(input, "")[[1]]
  c_vec <- c(prepend, c_vec)
  return(c_vec)
}

# e.g. c("", "A", "T") -> "AT"
unvec_char <- function(input) {
  ret <- str_c(input, collapse = "")
  return(ret)
}


charst <- list(list(NULL, "A", NULL),
               "C",
               list(list(NULL, "D", NULL), "F", NULL))

print_tree <- function(data) {
  left <- data[[1]]
  el <- data[[2]]
  right <- data[[3]]
  if(!is.null(left)) {  # "short-circuit the base case", aka "arms-length recursion"
    print_tree(left)
  }
  print(el[[1]])
  if(!is.null(right)) {
    print_tree(right)
  }
}

print_tree(charst)





library(TurtleGraphics)

turtle_init(mode = "clip")
turtle_forward(10)
print(turtle_getpos()) # returns x, y vector
turtle_turn(45, "right")
print(turtle_getangle()) # return angle vector
turtle_col("red")
turtle_forward(10)
turtle_up()   # lift pen
turtle_forward(5)
turtle_down() # put pen down
turtle_forward(5)

turtle_lwd(4)  # pen width
turtle_turn(165, "left")
turtle_forward(10)

turtle_setpos(10, 10)
turtle_setangle(0)


turtle_setstate <- function(state) {
  turtle_setpos(state[1], state[2])
  turtle_setangle(state[3])
}

turtle_getstate <- function() {
  state <- c(turtle_getpos(), turtle_getangle())
  return(state)
}

print(turtle_getstate())
s <- turtle_getstate()
turtle_forward(10)
turtle_setstate(s)


turtle_init(mode = "clip")
turtle_hide()

for(size in seq(1,20)) {
  turtle_forward(size)
  turtle_turn(30, "left")
}






simple_tree <- function(size) {
  stored_state <- turtle_getstate() # 1
  if(size < 1.0) {
    return()
  }
  turtle_forward(size)             # 2
  
  turtle_turn(30, "left")         # 3
  turtle_forward(size * 0.5)      # 4
  simple_tree(size * 0.7)
  turtle_up()
  turtle_backward(size * 0.5)     # 5
  turtle_down()
  
  turtle_turn(60, "right")        #6
  turtle_forward(size * 0.5)      # 7
  simple_tree(size * 0.65)
  turtle_setstate(stored_state)   # 8
}

turtle_init(mode = "clip")
turtle_hide()

turtle_setstate(c(30, 10, 0)) # x y angle
simple_tree(10)

turtle_setstate(c(70, 10, 0)) # x y angle
simple_tree(0.5)




turtle_init(mode = "clip")
turtle_hide()

for(size in seq(1,20)) {
  turtle_forward(size)
  simple_tree(size)
  turtle_turn(30, "left")
}

turtle_init(mode = "clip")
turtle_hide()

turtle_setstate(c(50, 10, 0)) # x y angle
simple_tree(16)




koch_curve <- function(size, limit) {
  if(size < limit) {
    turtle_forward(size)
  } else {
    koch_curve(size/3, limit)
    turtle_turn(60, "left")
    koch_curve(size/3, limit)
    turtle_turn(120, "right")
    koch_curve(size/3, limit)
    turtle_turn(60, "left")
    koch_curve(size/3, limit)
  }
}


turtle_init(mode = "clip")
turtle_hide()

turtle_setstate(c(10, 90, 90))
koch_curve(80, limit = 81)
turtle_setstate(c(10, 65, 90))
koch_curve(80, limit = 40)
turtle_setstate(c(10, 45, 90))
koch_curve(80, limit = 15)
turtle_setstate(c(10, 25, 90))
koch_curve(80, limit = 7)
turtle_setstate(c(10, 5, 90))
koch_curve(80, limit = 1.5)




turtle_text <- function(label, col = "black", fontsize = 20) {
  grid.text(label, 
            turtle_getpos()[1], 
            turtle_getpos()[2], 
            rot = -1*turtle_getangle(), 
            default.units = "native", 
            gp = gpar(fontsize = fontsize, col = col))  
}

turtle_init(mode = "clip")
turtle_hide()

turtle_forward(10)
turtle_text("hi!")





simple_tree <- function(size) {
  stored_state <- turtle_getstate()
  turtle_forward(size)
  
  turtle_turn(30, "left")
  turtle_forward(size * 0.5)
  
  turtle_up()
  turtle_backward(size * 0.5)
  turtle_down()
  
  turtle_turn(30, "right")
  turtle_forward(size * 0.5)
  
  turtle_setstate(stored_state)
}



nums <- sample(seq(1,20), 20)
print(nums)

t <- NULL
for(num in nums) {
  t <- insert_tree(t, num)
}
print_tree(t)


turtle_init(mode = "clip")
turtle_hide()

turtle_setstate(c(50, 90, 180)) # x y angle
draw_tree(t)











library(hash)
library(stringr)

## splits a single string into a vector of characters
## char_vec("TAGAC") -> "T" "A" "G" "A" "C"
## if given a prepend, then this will be added to the front, e.g.
## char_vec("TAGAC", "") -> "" "T" "A" "G" "A" "C"
char_vec <- function(input, prepend = c()) {
  c_vec <- str_split(input, "")[[1]]   # str_split() from stringr library
  c_vec <- c(prepend, c_vec)
  return(c_vec)
}


## Undoes char_vec(); 
## eg unvec_char(c("T", "G", "A", "C")) -> "TGAC"
unvec_char <- function(input) {
  ret <- str_c(input, collapse = "")   # also from stringr library
  return(ret)
}





sentence <- c("M", "F")
# or
sentence <- char_vec("MFMFF")
# or just
sentence <- c("M")

rules <- hash()
rules[["M"]] <- c("F")
rules[["F"]] <- c("M", "F")



## note: because this function appends to an R vector
## from within a loop, it will be slow for very long sentences.
## (could be sped up by using a stack and then converting to a vector)
lproduce <- function(sentence, rules) {
  newsentence <- c()  # start with an empty sentence
  for(symbol in sentence) {
    if(has.key(symbol, rules)) {
      newsentence <- c(newsentence, rules[[symbol]])
    } else {
      newsentence <- c(newsentence, symbol)
    }
  }
  return(newsentence)
}







sentence <- c("M")

rules <- hash()
rules[["M"]] <- c("F")
rules[["F"]] <- c("M", "F")


sentence <- lproduce(sentence, rules)
print(unvec_char(sentence))

sentence <- lproduce(sentence, rules)
print(unvec_char(sentence))

sentence <- lproduce(sentence, rules)
print(unvec_char(sentence))

sentence <- lproduce(sentence, rules)
print(unvec_char(sentence))




library(rstackdeque)

draw_sentence <- function(sentence, fsize, langle, rangle) {
  pos_stack <- rstack()
  for(symbol in sentence) {
    if(symbol == "F") {
      turtle_forward(fsize)
    } else if(symbol == "+") {
      turtle_turn(rangle, "right")
    } else if(symbol == "-") {
      turtle_turn(langle, "left")
    } else if(symbol == "[") {
      pos_stack <- insert_top(pos_stack, turtle_getstate())
    } else if(symbol == "]") {
      turtle_setstate(peek_top(pos_stack))
      pos_stack <- without_top(pos_stack)
    } else {   # if all else fails, just interpret the symbol as text to draw
      turtle_text(symbol)
    }
  }
}




turtle_init(mode = "clip")
turtle_hide()
turtle_setstate(c(50, 20, 0)) # x y angle

sentence <- char_vec("F[-F]F[+F]F")
draw_sentence(sentence, 10, 30, 30)




sentence <- "F"
rules <- hash()
rules[["F"]] <- char_vec("F[-F]F[+F]F")

sentence <- lproduce(sentence, rules)
print(unvec_char(sentence))

sentence <- lproduce(sentence, rules)
print(unvec_char(sentence))

turtle_init(mode = "clip")
turtle_hide()
turtle_setstate(c(50, 20, 0)) # x y angle

draw_sentence(sentence, 6, 30, 30)






sentence <- "F"
rules <- hash()
rules[["F"]] <- char_vec("F[-F]F[+F]F")

for(i in seq(1, 4)) {
  sentence <- lproduce(sentence, rules)
  print(unvec_char(sentence))
}

turtle_init(mode = "clip")
turtle_hide()
turtle_setstate(c(50, 20, 0)) # x y angle

draw_sentence(sentence, 6, 30, 30)











draw_phylip <- function(sentence, size, langle, rangle) {
  pos_stack <- rstack()
  for(symbol in sentence) {
    if(symbol == "(") {
      pos_stack <- insert_top(pos_stack, turtle_getstate())
      turtle_forward(size)
      #turtle_turn(-10)
    } else if(symbol == ",") {
      turtle_turn(runif(1,20,40))
    } else if(symbol == ")") {
      turtle_setstate(peek_top(pos_stack))
      pos_stack <- without_top(pos_stack)    
    } else {
      state <- turtle_getstate()
      turtle_forward(size)
      turtle_setangle(0)
      turtle_text(symbol)
      turtle_setstate(state)
    }
  }
}


turtle_init(mode = "clip")
turtle_hide()
turtle_setstate(c(50, 50, 0))

draw_phylip(c(char_vec("A,((1,2,3),Y,Z),C,(Q,L),D,E")), 15, 20, 20)




