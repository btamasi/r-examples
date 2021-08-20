#############################################################
## 
##   Determinants of the power of a test
##
##   author: Balint Tamasi
##   date:   24/11/2017
##
#############################################################


par(mfrow = c(1, 1))
delta <- seq(-3, 3, length.out = 200)
#############################################################
## significance level (alpha)
#############################################################
sigma <- 2  ## sd
n <- 30     ## # of obs
alpha <- c(0.1, 0.05, 0.01)
plot(delta, seq_along(delta), type = "n", ylim = c(0, 1), 
     xlim = c(-3, 3),
     xlab = expression(Delta), ylab = expression(P[1-beta]))
for (i in 1:3) {
  c1 <- qnorm(1-alpha[i]/2, mean = 0, sd = sigma / sqrt(n))
  c2 <- -qnorm(1-alpha[i]/2, mean = 0, sd = sigma / sqrt(n))
  pow <- 1 - pnorm(c1, mean = delta, sd = sigma / sqrt(n)) + 
    pnorm(c2, mean = delta, sd = sigma / sqrt(n))
  lines(delta, pow, col = i)
  abline(h = alpha[i], lty = 2, col = i)
}
abline(v = 0)
legend("bottomright",
       sapply(alpha, function(x) as.expression(bquote(alpha == .(x)))),
       lty = 1, col = 1:3,
       cex = 0.8)

#############################################################
## sample size (n)
#############################################################
sigma <- 2     ## sd
alpha <- 0.05  ## significance level
n <- c(15, 30, 80)
plot(delta, seq_along(delta), type = "n", ylim = c(0, 1), 
     xlim = c(-3, 3),
     xlab = expression(Delta), ylab = expression(P[1-beta]))
for (i in 1:3) {
  c1 <- qnorm(1-alpha/2, mean = 0, sd = sigma / sqrt(n[i]))
  c2 <- -qnorm(1-alpha/2, mean = 0, sd = sigma / sqrt(n[i]))
  pow <- 1 - pnorm(c1, mean = delta, sd = sigma / sqrt(n[i])) + 
    pnorm(c2, mean = delta, sd = sigma / sqrt(n[i]))
  lines(delta, pow, col = i)
}
abline(h = alpha, v = 0, lty = c(2, 1))
legend("bottomright",
       sapply(n, function(x) as.expression(bquote(n == .(x)))),
       lty = 1, col = 1:3,
       cex = 0.8)

#############################################################
## population sd (sigma)
#############################################################
n <- 30        ## sd
alpha <- 0.05  ## significance level
sigma <- c(1, 2, 5)
plot(delta, seq_along(delta), type = "n", ylim = c(0, 1), 
     xlim = c(-3, 3),
     xlab = expression(Delta), ylab = expression(P[1-beta]))
for (i in 1:3) {
  c1 <- qnorm(1-alpha/2, mean = 0, sd = sigma[i] / sqrt(n))
  c2 <- -qnorm(1-alpha/2, mean = 0, sd = sigma[i] / sqrt(n))
  pow <- 1 - pnorm(c1, mean = delta, sd = sigma[i] / sqrt(n)) + 
    pnorm(c2, mean = delta, sd = sigma[i] / sqrt(n))
  lines(delta, pow, col = i)
}
abline(h = alpha, v = 0, lty = c(2, 1))
legend("bottomright",
       sapply(sigma, function(x) as.expression(bquote(sigma == .(x)))),
       lty = 1, col = 1:3,
       cex = 0.8)
