## Quantile-quantile plot for gamma distribution

## Simulate random sample
alpha = 3
beta = 1
set.seed(111)
rg <- rgamma(100, shape = alpha, rate = beta)

n <- length(rg)
## Theoretical quantiles
thquant <- qgamma(seq(1/n, 1-1/n, length.out = n), shape = alpha, rate = beta)
## QQ-plot
plot(thquant, sort(rg), type = "p", pch = 16, col = "red",
     main = "Quantile - Quantile Plot",
     xlab = "Theoretical quantiles of the gamma distribution",
     ylab = "Sample quantiles")
abline(0, 1, col = "darkgrey")