## Connection between Binomial and Poisson distributions
## As n -> infinity, keeping n*p = lambda constant, Bin(n, p) approaches
## Pois(lambda)

set.seed(100)
par(mfrow = c(2,2), cex = 0.9)

lambda <- 5
n <- c(10, 50, 100, 1000)

for (nn in n) {
  x <- rbinom(10000, size = nn, prob = lambda / nn)
  plot.ecdf(x, xlim = c(0, lambda*2 + 4), ylab = expression(P(X<=x)), 
            main = bquote(lambda ~ "=" ~ .(lambda) * ", n =" ~ .(nn)
                          * ", p =" ~ .(lambda / nn)))
  cdf <- c(0, ppois(0:(lambda*2 + 4), lambda))
  plot(stepfun(0:(lambda*2 + 4), cdf, f = 0), col = "red", 
       add = TRUE, verticals = FALSE, pch = 1)
  legend("bottomright", 
         c("ECDF Bin(n, p)", expression("CDF Pois" * (lambda))),
         col = c(1, 2), pch = c(16, 1), lty = 1, bty = "n", cex = 0.9)
}