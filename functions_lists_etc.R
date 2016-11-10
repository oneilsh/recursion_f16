
# a simple function
add_two_nums <- function(first, second) {
  temp <- first + second
  return(temp)
}

# local variables are, well, local
a <- 27
b <- 3
c <- 8
x <- add_two_nums(a, b)
y <- add_two_nums(b, c)
print(y)
print(temp)  # error!
print(first) # error!

# and they shadow existing variables
first <- "Shawn"
temp <- -2000
a <- 27
b <- 3
c <- 8
x <- add_two_nums(a, b)
y <- add_two_nums(b, c)
print(y)
print(temp)  # -2000
print(first) # "Shawn"


# Global vars
CALL_COUNTER <<- 0

add_two_nums <- function(first, second) {
  temp <- first + second
  CALL_COUNTER <<- CALL_COUNTER + 1
  return(temp)
}

print(add_two_nums(11, 4)) # 15
print(CALL_COUNTER)        # 1
print(add_two_nums(2, 3))  # 5
print(CALL_COUNTER)        # 2




# lists and storing stuff in them
a_list <- list("A", "B", list("X", "Y"), NULL)
if(is.null(a_list[[4]])) {
  print("It's null")
} else {
  print("not null")
}


# nested list
chars <- list("A", list("C", list("D", list("F", NULL))))
third_el <- chars[[2]][[2]][[1]]
print(third_el)

# printing all elements in order, with a while-loop
data <- chars
while(!is.null(data)) {
  el <- data[[1]]
  rest <- data[[2]]
  print(el)
  data <- rest
}

# printing all elements in order, with
# a *recursive function*
# works because of local variables!
print_list <- function(data) {
  if(is.null(data)) {
    return(invisible())
  } 
  el <- data[[1]]
  rest <- data[[2]]
  print(el)
  print_list(rest)
}

print_list(chars)


# I figured out how to get a function to return nothing
# and not cause the returned NULL to be printed!
afunc <- function(data) {
  return(invisible())
}

afunc(1)

# Here's a cool one: use recursion to get the i'th element from a nested list
get_ith <- function(data, i) {
  if(is.null(data)) {
    return(NA)
  }
  el <- data[[1]]
  rest <- data[[2]]
  if(i == 1) {
    return(el)
  } 
  answer <- get_ith(rest, i - 1)
  return(answer)
}

print("printing third item")
print(get_ith(chars, 3))
print("printing 7th item")
print(get_ith(chars, 7))   # prints NA

# How about appending to the end of a nested list, and returning an updated copy?
append_end <- function(data, new_el) {
  if(is.null(data)) {
    return(list(new_el, NULL))
  }
  el <- data[[1]]
  rest <- data[[2]]
  new_rest <- append_end(rest, new_el)
  return(list(el, new_rest))
}

print("printing chars5 nested list")
chars5 <- append_end(chars, "Q")
print_list(chars5)



# Binary search tree!
chars4 <- list(list(NULL, "A", NULL), 
              "C", 
              list(list(NULL, "D", NULL), 
                   "F", 
                   NULL))

# print all the elements in order
print_tree <- function(data) {
  if(is.null(data)) {
    return(invisible())
  }
  left <- data[[1]]
  el <- data[[2]]
  right <- data[[3]]
  print_tree(left)
  print(el)
  print_tree(right)
}

print("printing chars4 tree")
print_tree(chars4)


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

print("printing chars5 tree")
chars5 <- insert_tree(chars4, "B")
print_tree(chars5)


