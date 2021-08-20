## Insert values after specified values in a vector

insert_after <- function(x, vals, idx) {
    stopifnot(length(vals) == length(idx))
    id <- c(seq_along(x), idx + 0.5) # the trick!
    new_x <- c(x, vals)
    new_x <- new_x[order(id)]
    return(new_x)
}


y <- 1:10
i <- c(3, 6, 8)
v <- rep(100, 3)

print(y)
print(insert_after(y, v, i))
