####################################################################
##
##   Simulating M/M/s/c queues 
##
##   date:   11/7/2018
##   author: Balint Tamasi
##
####################################################################

sim_queueMM  <- function(Tmax, lambda, mu, s = 1, c = Inf) {
  ## ==============================
  ## Simulates M/M/s/c queue
  ## s: # of servers
  ## c: capacity (including served)
  ## ==============================
  stopifnot(c >= s)
  out_n <- n <- 0
  out_t <- t <- 0
  while (t < Tmax) {
    rate_up   <- (n < c) * lambda
    rate_down <- min(s, n) * mu
    t <- t + rexp(1, rate_up + rate_down)
    n <- n + ifelse(runif(1) < rate_up / (rate_up + rate_down), 1, -1)
    out_n <- c(out_n, n)
    out_t <- c(out_t, t)
  }
  return(list(T = out_t, N = out_n))
}

####################################################################
## M/M/3/0
####################################################################
lambda <- 1.2
mu <- 1

set.seed(100)
q <- sim_queueMM(1e4, lambda, mu, s = 3, c = 3)
plot(q$T[1:30], q$N[1:30], type = "s")
tapply(diff(q$T), q$N[-length(q$N)], sum) / max(q$T)

## analytical probabilities (stationary distr)
rho <- lambda / mu
p0 <- 1 / sum(sapply(0:3, function(x) rho^x/factorial(x)))
(p <- p0 * c(1, sapply(1:3, function(x) rho^x / factorial(x))))


####################################################################
## M/M/1/Inf
####################################################################
lambda <- 0.8
mu <- 1
rho <- lambda / mu

set.seed(100)
q <- sim_queueMM(10000, lambda, mu, s = 1, c = Inf)
plot(q$T[1:30], q$N[1:30], type = "s")
## Prob of server idle
sum(diff(q$T)[q$N[-length(q$N)] == 0]) / max(q$T)
## analytical
1 - rho
## stationary distribution
p <- tapply(diff(q$T), q$N[-length(q$N)], sum) / max(q$T)
n <- as.numeric(names(p))
plot(n, p, type = "h")
points(n, (1-rho)*rho^(n), pch = 20, col = 2) ## geom distribution (analytical)
## customers in the system
p %*% n
rho / (1-rho)
## mean waiting time
w <- q$N[-length(q$N)] > 1
sum(diff(q$T)[w] * (q$N[-length(q$N)][w]-1)) / sum(q$N[-length(q$N)][w]-1)