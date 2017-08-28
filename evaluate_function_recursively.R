## Evaluate a function recursively on a list of arguments.
## (i.e. fun(fun(x1, x2), x3) etc.)

merge_rec <- function(...) {
    ## Recursively merge all inputs with all = TRUE
    merge_all <- function(x, y) merge(x, y, all = TRUE)
    val <- Reduce(merge_all, list(...))
    return(val)
}

x1 <- data.frame(id = 1:3, v1 = "a")
x2 <- data.frame(id = 4:6, v2 = "b")
x3 <- data.frame(id = 7:9, v3 = "c")

x <- merge_rec(x1, x2, x3)
print(x)
