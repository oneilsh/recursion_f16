
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
    return()
  } 
  el <- data[[1]]
  rest <- data[[2]]
  print(el)
  print_list(rest)
}

print_list(chars)