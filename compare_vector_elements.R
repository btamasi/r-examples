## Check whether two vectors have the same elements

x <- c(1, 1, 1, 2, 3)
y <- 3:1

print(setequal(x, y))
## TRUE

print(setequal(x, c(4, y)))
## False
