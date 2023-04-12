# options
options(Ncpus = 4)
options(showWarnCalls = TRUE, showErrorCalls = TRUE)

# q without asking if save (same as q("no"))
q <- function(save = "no", ...) {
  quit(save = save, ...)
}

# negation of %in%
"%nin%" <- function(x, y) !(x %in% y)

# headtail; show the first and last 10 items of an object
ht <- function(d) rbind(head(d, 10), tail(d, 10))

# show the first 5 rows and first 5 columns of a data frame or matrix
hh <- function(d) d[1:5, 1:5]
