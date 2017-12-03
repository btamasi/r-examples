####################################################################
##
## Setting contrasts for factors in lm()
##
####################################################################
set.seed(100)
y <- c(rnorm(500, mean = 5, sd = 1), 
       rnorm(500, mean = 15, sd = 1),
       rnorm(500, mean = 25, sd = 1))
x <- factor(rep(c("a", "b", "c"), each = 500))
df <- data.frame(y, x)

summary(lm(y ~ x, data = df, contrasts = list(x = "contr.treatment")))
summary(lm(y ~ x, data = df, contrasts = list(x = "contr.sum")))
