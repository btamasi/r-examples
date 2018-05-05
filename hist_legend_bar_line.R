## Histogram with legend for both bar and line

set.seed(100)
x <- rnorm(10000)

par(cex = 0.8)
hist(x, breaks = 30, freq = FALSE, col = "grey60",
     main = "Distribution of X")
curve(dnorm(x), add = TRUE, lwd = 2)
legend("topright", c("Simulated", "Theoretical"), 
       pch = c(22, NA), pt.cex = 2.5, pt.bg = "grey60", ## Trick!
       lty = c(NA, 1), lwd = c(1, 2),
       bty = "n")