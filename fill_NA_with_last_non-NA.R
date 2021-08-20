## Fill NAs with the last non-NA values in a vector. Leading NAs will be left as
## NAs.

fill_na <- function(v) {
    good_i <- !is.na(v)
    good_val <- v[good_i]
    good_val <- c(NA, good_val)
    fill_idx <- cumsum(good_i) + 1
    val <- good_val[fill_idx]
    return(val)
}

set.seed(1)
x <- sample(c(1:10, rep(NA, 10)))
print(x)
print(fill_na(x))
