## Apply a function on grouped data: Standardize the variable x for each group
## defined by b. Check the results.

set.seed(1)

df <- data.frame(x = rnorm(1000, 10, 4),
                 g = sample(c("a", "b", "c"), 1000, replace = TRUE))

df$z <- unsplit(lapply(split(df$x, df$g), scale), df$g)
print(sapply(split(df$z, df$g),
             function(x) data.frame(mean = mean(x), sd = sd(x))))
