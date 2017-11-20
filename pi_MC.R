####################################################################
##
##   Approximation of the value of pi with Monte Carlo methods
##
##   date:   12/11/2017
##   author: Balint Tamasi
##
####################################################################


####################################################################
## 'Hit-or-miss' method
####################################################################
set.seed(123)
N <- 1e5
x <- runif(N)^2 + runif(N)^2 < 1   ## Binary draws
p <- cumsum(x) / 1:N               ## Success rate
y <- 4 * p                         ## Approximation of pi
se <- sqrt(16 * p * (1-p) / 1:N)   ## Numerical standard error

plot(seq_along(y)[-(1:9)], y[-(1:9)], type = "l", log = "x",
     lwd = 2, xlab = "# of draws", ylab = "",
     main = expression(paste("Approximation of ", pi, 
                              " with the 'hit-or-miss' method")),
     ylim = c(2.8, 3.6),
     xaxt = "n")
axis(1, at = 10^(1:5), 
     labels = sapply(1:5, function(i) as.expression(bquote(10^.(i)))))
lines(seq_along(y)[-(1:9)], y[-(1:9)] + 2 * se[-(1:9)],
        lty = 3)
lines(seq_along(y)[-(1:9)], y[-(1:9)] - 2 * se[-(1:9)],
      lty = 3)
abline(h = pi, lty = 2, lwd = 2)
legend("topright", 
       c(expression(pi), "Estimation", "Estimation +/- 2*SE"),
       lty = c(2, 1, 3), lwd = c(2, 2, 1), bty = "n")


####################################################################
## Sample mean method
####################################################################
set.seed(321)
N <- 1e5
x <- 4 * sqrt(1 - runif(N)^2)               ## Integrand at rnd smpl 
m <- cumsum(x) / 1:N                        ## Mean: estimate of pi
se <- sqrt((cumsum(x^2)/1:N - m^2)/1:N)     ## Numerical SE

plot(seq_along(m)[-(1:9)], m[-(1:9)], type = "l", log = "x",
     lwd = 2, xlab = "# of draws", ylab = "",
     main = expression(paste("Approximation of ", pi, 
                             " with the sample mean method")),
     ylim = c(2.9, 3.5),
     xaxt = "n")
axis(1, at = 10^(1:5), 
     labels = sapply(1:5, function(i) as.expression(bquote(10^.(i)))))
lines(seq_along(m)[-(1:9)], m[-(1:9)] + 2 * se[-(1:9)],
      lty = 3)
lines(seq_along(m)[-(1:9)], m[-(1:9)] - 2 * se[-(1:9)],
      lty = 3)
abline(h = pi, lty = 2, lwd = 2)
legend("topright", 
       c(expression(pi), "Estimation", "Estimation +/- 2*SE"),
       lty = c(2, 1, 3), lwd = c(2, 2, 1), bty = "n")


####################################################################
## Comparing accuracies of the two methods
####################################################################
library("foreach")
library("doParallel")
registerDoParallel(cores = 4)

N <- 5000   ## # of repetitions
n <- 1e5    ## # of draws

set.seed(1234) ## !!! does not work
piest <- foreach(i = 1:N, .combine = rbind) %dopar% {
  y1 <- mean((runif(n)^2 + runif(n)^2 < 1) * 4)
  y2 <- mean(4 * sqrt(1 - runif(n)^2))
  c(y1, y2)
}

hist(piest[, 1], freq = FALSE,
     breaks = seq(3.115, 3.165, length.out = 40), 
     col = rgb(1, 0, 0, 0.3), lty = 0, xlim = c(3.115, 3.165),
     xlab = "Monte Carlo estimates", ylim = c(0, 150), 
     main = expression(
       paste("Histogram of Monte Carlo estimates of ", pi)))
hist(piest[, 2], freq = FALSE,
     breaks = seq(3.115, 3.165, length.out = 40), 
     col = rgb(0, 0, 1, 0.3), lty = 0, xlim = c(3.115, 3.165),
     add = TRUE)
lines(density(piest[, 1]), col = "red", lwd = 1.5)
lines(density(piest[, 2]), col = "blue", lwd = 1.5)
box()
abline(v = pi, lwd = 2, lty = 2)
text(pi, 20, expression(pi), pos = 4, cex = 1.5)
legend("topleft", 
       legend = c("Hit-or-miss method", "Sample mean method"),
       fill = c(rgb(1, 0, 0, 0.3), rgb(0, 0, 1, 0.3)),
       bty = "n")

