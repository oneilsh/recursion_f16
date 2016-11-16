print_string_stack <- function(s) {
  char_vec <- as.character(as.list(s))
  print(rev(char_vec))
}

# The fibonacci function, recursively computed
library(stringr)
fib <- function(n) {
  key <- str_c("n=", as.character(n))
  CALL_STACK <<- insert_top(CALL_STACK, key)
  print_string_stack(CALL_STACK)
  
  CALL_COUNTER <<- CALL_COUNTER + 1
  if(n == 1 |  n == 2) {
    CALL_STACK <<- without_top(CALL_STACK)
    print_string_stack(CALL_STACK)
    return(1)
  }
  
  a <- fib(n-1)
  b <- fib(n-2)
  answer <- a + b
  
  CALL_STACK <<- without_top(CALL_STACK)
  print_string_stack(CALL_STACK)
  return(answer)
}

CALL_COUNTER <<- 0  # reset the counter
CALL_STACK <<- rstack()  # make an empty "call stack"
print(fib(6))
#print(CALL_COUNTER) # should be 5

library(rstackdeque)
info <- rstack()
for(i in seq(1, 20)) {
  CALL_COUNTER <<- 0
  fib_computed <- fib(i)
  row <- list(n = i, fibn = fib_computed, calls = CALL_COUNTER)
  info <- insert_top(info, row)
}
info_df <- as.data.frame(info)
print(info_df)

library(ggplot2)
p <- ggplot(info_df) +
  geom_line(aes(x = n, y = fibn), color = "red") +
  geom_line(aes(x = n, y = calls), color = "blue") 
plot(p)

  
# quick review of data frames and plotting w/ ggplot2
people <- data.frame(names = c("Joe", "Bob", "Kim"),
                     ages = c(15, 23, 19),
                     heights = c(5.2, 5.3, 5.7))
print(people)
print(people$names)

library(ggplot2)

p <- ggplot(people) +
  geom_text(aes(x = ages, y = heights, label = names))
plot(p)


# rstack(): an implementation of a stack structure in R
# (rstackdeque also has FIFO queues and double-ended queues)
library(rstackdeque)
s <- rstack()
s <- insert_top(s, "A")
s <- insert_top(s, "B")
s <- insert_top(s, "C")
print(s)

top_el <- peek_top(s)   # "C"
s2 <- without_top(s)
print(s2)

s_as_list <- as.list(s)
print(s_as_list)

rows <- rstack()
rows <- insert_top(rows, list(name = "Bob", age = 24))
rows <- insert_top(rows, list(name = "Joe", age = 37))
rows <- insert_top(rows, list(name = "Kim", age = 31))
print(rows)

rows_df <- as.data.frame(rows)
print(rows_df)
