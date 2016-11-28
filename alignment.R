library(stringr)
library(hash)
library(rstackdeque)

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

# example usage
############################
dna <- "CTAGC"
dna_vec <- char_vec(dna, prepend = "")
print(dna_vec)

dna_back <- unvec_char(dna_vec)
print(dna_back)

# scoring functions
##########################################
# e.g. score_pair("A", "C") => -4
score_pair <- function(a, b) {
  if(a == "" & b == "") {
    return(0)          # empty vs empty, 0
  } else if(a == b & a != "-") {
    return(2)          # non-gap-to-gap match
  } else if(a == "-" | b == "-") {
    return(-4)         # gap
  } else {
    return(-3)         # other mismatch
  }
}

print(score_pair("A", "T"))   # -3
print(score_pair("T", "T"))   # 2
print(score_pair("-", "T"))   # -4


score_aln <- function(a, b) {
  if(length(a) != length(b)) {
    stop("Ack! Can't score alignment of unequal length")
  }
  score <- 0
  for(i in seq(1, length(a))) {
    score <- score + score_pair(a[i], b[i])
  }
  return(score)
}


print(score_aln(c("", "T", "-"), c("", "T", "A"))) # total: -2




# answer structure:
################################################
answer <- list(a = c("", "T", "A", "T"),
               b = c("", "T", "T"),
               a_aln = c("", "T", "A", "T"),
               b_aln = c("", "T", "-", "T"),
               score = 0)
str(answer)



# easy cases
###################################
# a function to solve easy cases; ie, 
# those where one seq is of lenght 1 (just the "")
easy_case <- function(a_in, b_in) {
  answer <- list(a = a_in, b = b_in)
  
  if(length(a_in) == 1 & length(b_in) == 1) { # a and b emtpy
    answer$a_aln <- c("")
    answer$b_aln <- c("")
  } else if(length(a_in) == 1) {  # e.g. a = "", b = "", "T", "C"
    answer$b_aln <- b_in
    answer$a_aln <- rep("-", length(b_in))
    answer$a_aln[1] <- ""
  } else if(length(b_in) == 1) {
    answer$a_aln <- a_in
    answer$b_aln <- rep("-", length(a_in))
    answer$b_aln[1] <- ""  
  } else {
    stop("Um, this doesn't look like any easy case...")  
  }
  
  answer$score <- score_aln(answer$a_aln, answer$b_aln)
  return(answer)
}


str(easy_case(c(""), c("", "T", "C")))
str(easy_case(c("", "T", "C"), c("")))

global_aln <- function(a_in, b_in) {
  key <- str_c(unvec_char(a_in), ",", unvec_char(b_in))
  if(has.key(key, CACHE)) {
    return(CACHE[[key]])
  }
  
  if(length(a_in) == 1 | length(b_in) == 1) {
    answer <- easy_case(a_in, b_in)
    answer$cache_el_num <- length(CACHE) + 1
    CACHE[[key]] <<- answer
    return(answer)
  }
  
  pa <- a_in[1:(length(a_in) - 1)]
  ea <- a_in[length(a_in)]
  pb <- b_in[1:(length(b_in) - 1)]
  eb <- b_in[length(b_in)]
  
  left <- global_aln(pa, b_in)
  center <- global_aln(pa, pb)
  right <- global_aln(a_in, pb)
  
  left_answer <- list(a = a_in, b = b_in,
                      a_aln = c(left$a_aln, ea),
                      b_aln = c(left$b_aln, "-"),
                      score = left$score + score_pair(ea, "-"))
  center_answer <- list(a = a_in, b = b_in,
                      a_aln = c(center$a_aln, ea),
                      b_aln = c(center$b_aln, eb),
                      score = center$score + score_pair(ea, eb))
  right_answer <- list(a = a_in, b = b_in,
                        a_aln = c(right$a_aln, "-"),
                        b_aln = c(right$b_aln, eb),
                        score = right$score + score_pair("-", eb))


  best_answer <- left_answer
  if(center_answer$score > best_answer$score) {
    best_answer <- center_answer
  }
  if(right_answer$score > best_answer$score) {
    best_answer <- right_answer
  }
  
  best_answer$cache_el_num <- length(CACHE) + 1
  CACHE[[key]] <<- best_answer
  return(best_answer)
}



CACHE <<- hash()
a <- char_vec("TATCGTCAGCCTAGCCT", prepend = "")
b <- char_vec("TTCGTTACCGCCTA", prepend = "")
best <- global_aln(a, b)
print(best)

print(CACHE[["TATCG,TTC"]])

