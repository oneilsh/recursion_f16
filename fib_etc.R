

# The fibonacci function, recursively computed
fib <- function(n) {
  if(n == 1) {
    return(1)
  } else if(n == 2) {
    return(2)
  }
  
  a <- fib(n-1)
  b <- fib(n-2)
  answer <- a + b
  return(answer)
}

print(fib(5))



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

