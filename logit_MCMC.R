####################################################################
##
##   Logistic regression with Metropolis sampling
##    - Random walk proposals
##    - Drawing proposals independently
##
##   date:   20/3/2018
##   author: Balint Tamasi
##
####################################################################

####################################################################
## Simulate data
####################################################################
set.seed(100)
beta0 <- 2
beta1 <- -100
n <- sample(c(15, 20, 25, 30, 35, 40), 8, replace = TRUE)
x <- runif(length(n), 0.001, 0.05)
p <- plogis(beta0 + beta1 * x)
y <- mapply(function(n, p) rbinom(1, n, p), n = n, p = p)
dat <- data.frame(x = x, y = y, n = n)


####################################################################
## Log posterior kernel of logistic regression parameters
####################################################################
log_post_logit <- function(y, n, x, b0, b1) {
  p <- plogis(b0 + b1 * x)
  ## Likelihood
  lik <- sum(dbinom(y, n, p, log = TRUE))
  ## Prior: independent normals
  pri_b0 <- dnorm(b0, mean = 0, sd = 100, log = TRUE)
  pri_b1 <- dnorm(b1, mean = 0, sd = 100, log = TRUE)
  return(pri_b0 + pri_b1 + lik)
}


####################################################################
## Parameters to be tweaked
####################################################################
n_sim    <- 10000 ## # of draws to be saved
n_burnin <- 5000  ## burn-in pariod
thin     <- 5     ## thinning the Markov chain
s0       <- 1     ## SD of the proposal for intercept
s1       <- 10    ## SD of the proposal for slope


####################################################################
## MCMC
####################################################################
set.seed(100)

post <- matrix(0, nrow = n_sim, ncol = 2)
b1_old <- 0 ## initial slope
b0_old <- 1 ## initial intercept
for (i in 1:(n_sim*thin + n_burnin)) {
  ## Intercept, conditional on slope
  b0 <- b0_old + rnorm(1, mean = 0, sd = s0) ## RW proposal
  acc_prob <- min(0, log_post_logit(dat$y, dat$n, dat$x, b0, b1_old) -
                    log_post_logit(dat$y, dat$n, dat$x, b0_old, b1_old))
  if (acc_prob > log(runif(1))) {
    b0_old <- b0
  } else {
    b0 <- b0_old
  }
  ## Slope, conditional on intercept
  b1 <- b1_old + rnorm(1, mean = 0, sd = s1) ## RW proposal
  acc_prob <- min(0, log_post_logit(dat$y, dat$n, dat$x, b0, b1) -
                    log_post_logit(dat$y, dat$n, dat$x, b0, b1_old))
  if (acc_prob > log(runif(1))) {
    b1_old <- b1
  } else {
    b1 <- b1_old
  }
  
  if (i > n_burnin & (i - n_burnin) %% thin == 0) {
    post[(i - n_burnin) / thin, ] <- c(b0, b1)
  }
}


####################################################################
## Results
####################################################################
sim_sum <- function(x) 
  c(mean = mean(x), sd = sd(x), quantile(x, c(0.025, 0.5, 0.975)))

sim_sum(post[, 1])
sim_sum(post[, 2])

par(mfrow = c(2, 2), cex = 0.7)
plot(post[, 1], type = "l", ylab = "Intercept", col = grey(0.3,0.4))
hist(post[, 1], col = grey(0.3, 0.4), breaks = 30,
     main = "Intercept", xlab = "")
abline(v = beta0, col = "red")
plot(post[, 2], type = "l", ylab = "Slope", col = grey(0.3,0.4))
hist(post[, 2], col = grey(0.3, 0.4), breaks = 30,
     main = "Slope", xlab = "")
abline(v = beta1, col = "red")