## Short-circuit evaluation: with && and || is only evaluated if first argument
## does not suffice to determine the value of the expression. In the example,
## the validity of the argument is evaluated with short-circuiting: if the input
## is not numerical, the function returns FALSE.

is_all_even <- function(x) {
    is.numeric(x) && all(x %% 2 == 0)
}

print(is_all_even(c(2, 4, 10)))

print(is_all_even(c("a", 2, 10)))
