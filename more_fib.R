library(stringr)
library(rstackdeque)
library(hash)
library(ggplot2)

# A helper function to print a stack of strings as a character
# vector, with the top element last
print_string_stack <- function(s) {
  char_vec <- as.character(as.list(s))
  print(rev(char_vec))
} 



# The fibonacci function, 
# using CALL_COUNTER global variable
# and keeping our own version of a CALL_STACK
fib <- function(n) {
  key <- str_c("n=", as.character(n))
  CALL_STACK <<- insert_top(CALL_STACK, key)
  print_string_stack(CALL_STACK)
  
  CALL_COUNTER <<- CALL_COUNTER + 1
  if(has.key(key, CACHE)) {
    CALL_STACK <<- without_top(CALL_STACK)
    print_string_stack(CALL_STACK)
    return(CACHE[[key]])
  }
  
  if(n == 1 |  n == 2) {
    CALL_STACK <<- without_top(CALL_STACK)
    print_string_stack(CALL_STACK)
    CACHE[[key]] <<- 1
    return(1)
  }
  
  a <- fib(n-1)
  b <- fib(n-2)
  answer <- a + b
  
  CALL_STACK <<- without_top(CALL_STACK)
  print_string_stack(CALL_STACK)
  CACHE[[key]] <<- answer
  return(answer)
}

# a quick vis of the call stack over time,
# and how many calls it takes to compute fib(8)
CACHE <<- hash()
CALL_STACK <- rstack()
CALL_COUNTER <- 0
test <- fib(8)
print(CALL_COUNTER)
print(CACHE)


# let's track the top 20 fibonacci numbers, 
# and the number of calls it takes to compute them
info <- rstack()
for(i in seq(1, 20)) {
  CALL_COUNTER <<- 0       # reset call counter
  CALL_STACK <<- rstack()  # reset call stack
  CACHE <<- hash()         # reset CACHE
  fib_computed <- fib(i)
  row <- list(n = i, fibn = fib_computed, calls = CALL_COUNTER)
  info <- insert_top(info, row)
}
info_df <- as.data.frame(info)
print(info_df)

p <- ggplot(info_df) +
  geom_line(aes(x = n, y = fibn), color = "red") +
  geom_line(aes(x = n, y = calls), color = "blue") 
plot(p)



#############
## A bit about hashes
#############

cache <- hash()
cache[["bob"]] <- 24
cache[["joe"]] <- 37
print(cache)

print(cache[["joe"]])           # print 37

print(has.key("joe", cache))    # TRUE
print(has.key("jerry", cache))  # FALSE

print(keys(cache))              # "bob", "joe"

#############






# memoized fib function
# without the extra call stack/call counter stuff
fib <- function(n) {
  key <- str_c("n=", as.character(n))
  if(has.key(key, CACHE)) {
    return(CACHE[[key]])
  }
  
  if(n == 1 |  n == 2) {
    CACHE[[key]] <<- 1
    return(1)
  }
  
  a <- fib(n-1)
  b <- fib(n-2)
  answer <- a + b
  
  CACHE[[key]] <<- answer
  return(answer)
}




# a "wrapper" that we can use to make sure the cache
# gets reset each time we call it- this is pretty advanced 
# functional programming though
fib_mem <- function(n) {
  CACHE <- hash() # CACHE is local to fib_mem...
  
  # memoized fib function
  # without the extra call stack/call counter stuff
  fib <- function(n) {
    key <- str_c("n=", as.character(n))
    if(has.key(key, CACHE)) {
      return(CACHE[[key]])
    }
    
    if(n == 1 |  n == 2) {
      CACHE[[key]] <<- 1      # but "global" to fib within fib_mem
      return(1)
    }
    
    a <- fib(n-1)
    b <- fib(n-2)
    answer <- a + b
    
    CACHE[[key]] <<- answer
    return(answer)
  }
  
  return(fib(n))
}

print(fib_mem(40))

fib_dp <- function(n) { # 1 step
  fibs <- seq(1, n)     # n steps
  fibs[1] <- 1          # 1 step
  fibs[2] <- 1          # 1 step
  for(i in seq(3, n)) { # n - 2 times:
    fibs[i] <- fibs[i - 1] + fibs[i - 2] # 5 steps
  }
  return(fibs[n])       # 1 step
}

print(fib_dp(40))
