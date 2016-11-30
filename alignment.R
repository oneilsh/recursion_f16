library(stringr)
library(hash)
library(rstackdeque)
library(ggplot2)

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
    answer$a_aln <- rep("-", length(b_in))
    answer$a_aln[1] <- ""
    # named elements should always be added in the same order so all answer lists have the same structure
    answer$b_aln <- b_in
  } else if(length(b_in) == 1) {
    answer$a_aln <- a_in
    answer$b_aln <- rep("-", length(a_in))
    answer$b_aln[1] <- ""  
  } else {
    stop("Um, this doesn't look like any easy case...")  
  }
  
  answer$score <- score_aln(answer$a_aln, answer$b_aln)
  answer$from_a <- a_in
  answer$from_b <- b_in
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
                      score = left$score + score_pair(ea, "-"),
                      from_a = left$a,
                      from_b = left$b)
  center_answer <- list(a = a_in, b = b_in,
                      a_aln = c(center$a_aln, ea),
                      b_aln = c(center$b_aln, eb),
                      score = center$score + score_pair(ea, eb),
                      from_a = center$a,
                      from_b = center$b)
  right_answer <- list(a = a_in, b = b_in,
                        a_aln = c(right$a_aln, "-"),
                        b_aln = c(right$b_aln, eb),
                        score = right$score + score_pair("-", eb),
                        from_a = right$a,
                        from_b = right$b)


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
a <- char_vec("TATCTGCAACGA", prepend = "")
b <- char_vec("TTGTGC", prepend = "")
best <- global_aln(a, b)
print(best)


print(CACHE[["TATCT,TTG"]])



# converts the values of a hash (assuming they are
# lists of the same structure) into rows of a data frame
hash_vals_to_df <- function(thehash) {
  tempstack <- rstack()
  
  for(key in keys(thehash)) {
    answer_list <- thehash[[key]]
    
    # unvec_char all character vectors
    for(i in seq(1, length(answer_list))) {
      if(is.character(answer_list[[i]])) {
        answer_list[[i]] <- unvec_char(answer_list[[i]])
      }
    }
    tempstack <- insert_top(tempstack, answer_list)
  }
  return(as.data.frame(tempstack, stringsAsFactors = FALSE))
}


cache_df <- hash_vals_to_df(CACHE)
print(head(cache_df))



p <- ggplot(cache_df) +
  geom_tile(aes(x = reorder(a, nchar(a)), 
                y = reorder(b, -1*nchar(b)),
                fill = score)) +
  geom_text(aes(x = a, y = b, label = score)) +
  geom_segment(aes(x = a, y = b,
                   xend = from_a, yend = from_b),
               arrow = arrow(length = unit(0.4, "cm")),
               position = position_jitter(width = 0.1, height = 0.1),
               color = "red") +
  coord_equal() +
  scale_x_discrete(name = "a Input") +
  scale_y_discrete(name = "b Input") +
  scale_fill_continuous(name = "Optimal Score") +
  theme_bw(14) +
  theme(axis.text.x = element_text(angle = 25, hjust = 1)) 
plot(p)





global_aln_dp <- function(a_in, b_in) {
  # create tables of the right size
  score <- matrix(0, nrow = length(b_in), ncol = length(a_in))
  from <- matrix("?", nrow = length(b_in), ncol = length(a_in))
  
  # build gap scores along top row
  row <- 1
  for(col in seq(2, ncol(score))) {
    score[row,col] <- score[row, col-1] + score_pair("-", a_in[col])
    from[row, col] <- "left"
  }
  
  # build gap scores along left col
  col <- 1
  for(row in seq(2, nrow(score))) {
    score[row,col] <- score[row-1, col] + score_pair(b_in[row], "-")
    from[row, col] <- "up"
  }
  
  # fill in the rest of the table
  for(row in seq(2, nrow(score))) {
    for(col in seq(2, ncol(score))) { # this was accidentally nrow(score), whoooops
      # three potential scores for this cell
      leftscore <- score[row, col-1] + score_pair(b_in[row], "-")
      diagscore <- score[row-1, col-1] + score_pair(b_in[row], a_in[col])
      upscore <- score[row-1, col] + score_pair("-", a_in[col])
      
      # we want the best, and to set the "from" info based on that
      bestscore <- leftscore
      bestfrom <- "left"
      if(diagscore > bestscore) {
        bestscore <- diagscore
        bestfrom <- "diag"
      }
      
      if(upscore > bestscore) {
        bestscore <- upscore
        bestfrom <- "up"
      }
      
      score[row,col] <- bestscore
      from[row,col] <- bestfrom
      
    }
  }
  
  # start in the lower-right
  currentrow <- nrow(score)
  currentcol <- ncol(score)
  # we'll build our alignment in two stacks for convenience
  a_aln <- rstack()
  b_aln <- rstack()
  final_score <- score[currentrow, currentcol]
  
  # while we're not done....
  while(currentrow != 1 & currentcol != 1) {
    arrow <- from[currentrow, currentcol]
    if(arrow == "left") {
      a_aln <- insert_top(a_aln, a_in[currentcol])
      b_aln <- insert_top(b_aln, "-")
      currentcol <- currentcol - 1
    } else if(arrow == "diag") {
      a_aln <- insert_top(a_aln, a_in[currentcol])
      b_aln <- insert_top(b_aln, b_in[currentrow])
      currentcol <- currentcol - 1
      currentrow <- currentrow - 1
    } else {
      a_aln <- insert_top(a_aln, "-")
      b_aln <- insert_top(b_aln, b_in[currentrow])
      currentrow <- currentrow - 1
    }
  }
  
  # just for fun, let's see the tables
  print(score)
  print(from)
  
  # pull the alignment out of the stacks and put in
  # an R character vector, inside an answer list
  answer <- list(a = a_in, b = b_in,
                 a_aln = as.character(as.list(a_aln)),
                 b_aln = as.character(as.list(b_aln)),
                 score = final_score)

  # and return it!
  return(answer)
}

a <- char_vec("TATCTGCAACGA", prepend = "")
b <- char_vec("TTGTGC", prepend = "")
best <- global_aln_dp(a, b)
print(best)



