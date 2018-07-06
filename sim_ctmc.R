####################################################################
##
##   Simulating Continuous Time Markov Chains
##
##   date:   6/7/2018
##   author: Balint Tamasi
##
####################################################################

## Generator matrix
lambda <- 1
mu     <- 1
Q <- rbind(c(-lambda, lambda, 0, 0),
           c(mu, -(lambda+mu), lambda, 0),
           c(0, 2*mu, -(lambda+2*mu), lambda),
           c(0, 0, 2*mu, -2*mu))

sim_ctmc <- function(Tmax, Q, start = 1, S = 1:ncol(Q)) {
  ## ============================
  ## Simulates finite-state CTMC
  ## Q: generator matrix
  ## ============================
  H <- rowSums(Q) - diag(Q) ## holding rates
  ## transition matrix of embedded DTMC
  P <- Q / H
  diag(P) <- 0
  
  state <- start
  time  <- 0
  out_state <- S[state]
  out_time  <- time
  while (time < Tmax) {
    time <- time + rexp(1, H[state])
    state <- sample(1:ncol(Q), 1, prob = P[state, ])
    out_state <- c(out_state, S[state])
    out_time  <- c(out_time, time)
  }
  return(list(T = out_time, S = out_state))
}

## Simulate a long chain and plot the first part
set.seed(100)
mc <- sim_ctmc(1e4, Q, S = 0:3)
plot(mc$T[1:100], mc$S[1:100], 
     type = "s", yaxt = "n", xlab = "time", ylab = "")
axis(2, at = 0:3, labels = paste0("S", 0:3))

## Stationary distribution of the states
(p <- tapply(diff(mc$T), mc$S[-length(mc$S)], sum) / max(mc$T))
p %*% Q ## ~ 0

## Stationary distribution: analytical result
p0 <- 1 / (1 + lambda/mu + lambda^2/(2*mu^2) + lambda^3/(4*mu^3))
(pa <- c(p0, p0 * lambda/mu, p0 * lambda^2/(2*mu^2), p0 * lambda^3/(4*mu^3)))
pa %*% Q ## check if 0

## S3: a customer is waiting -> estimate average waiting time
mean(diff(mc$T)[mc$S[-length(mc$S)] == 3])