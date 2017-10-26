## Getting the diagonals of a matrix

## data
set.seed(1)
dat <- matrix(sample(100, 25), ncol = 5, byrow = TRUE)

## diagonals of the matrix indexed by their distance from the main diagonal
abs(row(dat) - col(dat)) + 1

## Example application: Weight matrices for Cohen's Kappa
## Quadratic weights
W_q <- 1 - (row(dat) - col(dat))^2 / (nrow(dat) - 1)^2
## Linear weights
W_l <- 1 - abs(row(dat) - col(dat)) / (nrow(dat) - 1)
