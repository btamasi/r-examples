### ====================================================
### Posterior simulation using rejection sampling
### Author: Balint Tamasi
### Date: 31-08-2019
### ====================================================

## Reference:
## Smith & Gelfand (1992): Bayesian Statistics Without Tears: A Sampling-Resampling Perspective
## DOI: 10.2307/2684170

## Rejection sampling:
## -------------------
## g(x): proposal pdf
## h(x): target pdf (up to a normalizing constant)
## M: constant, such that h(x) <= M*g(x)
## 1) Draw from the proposal x' ~ g(x)
## 2) Accept with probability h(x') / M*g(x')
## 3) Repeat
##
## Bayesian setting:
## -----------------
## g(x): prior pdf: p(x)
## h(x): unnormalized posterior: p(x)*l(x)
## M: maximum likelihood estimate: l_mle
## Acceptance prob: (p(x)*l(x) / (l_mle * p(x)) = l(x) / l_ml
##
## Example:
## Binomial distr. sample, uniform prior

set.seed(100)

## Simulate data
rho <- 0.2 # True prob of success
n <- 50 # Sample size
x <- rbinom(1, size = n, prob = 0.2)

## Log-likelihood and its max value
## (Working with logs for numerical stability)
ll <- function(p) dbinom(x = x, size = n, prob = p, log = TRUE)
ll_mle <- ll(x / n) # x/n is the MLE

i <- 0
count <- 0 # counter for calculating the acceptance rate
ndraw <- 1e4
smpl <- vector("numeric", ndraw)
while (i < ndraw) {
  count <- count + 1
  prop <- runif(1) # proposal
  if (log(runif(1)) < (ll(prop) - ll_mle)) {
    i <- i + 1
    smpl[i] <- prop
  }
}

## Acceptance rate
ndraw / count

## Posterior distribution with the true parameter value
hist(smpl, breaks = 40,
     xlab = expression(rho), xlim = c(0, 0.6),
     col = grey(0.6, alpha = 0.75), lty = 0,
     panel.first = abline(v = seq(0, 1, length.out = 7),
         h = seq(0, 1, length.out = 7),
         col = "black", lty = "dotted"),
     main = expression(paste("Posterior distribution of ", rho)))
rug(smpl, col = grey(0.6, alpha = 0.2))
abline(v = 0.2, col = "red", lwd = 2)
box()
