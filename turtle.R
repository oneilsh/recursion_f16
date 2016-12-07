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
