###############################################################
##
##    Comparison of confidence intervals for binomial data
##    ====================================================
##
##  To calculate the coverages:
##  - takes all possible observations, calculates the 
##    probability of that observation given the true parameter 
##    value
##  - calcuates the CI for the observation
##  - evaluates if the true parameter value is within the CI
##  - calculates the weighted sum of the cases, where the true 
##    param is inside the CI using the probability of the
##    observation at hand as a weight
##  
##  Confidence intervals: 
##    Wald, Wald for logit, Likelihood ratio, Wilson
## 
##  Reproducing Held Fig 4.9/a, b, d and e pp 117-118
##
##    Author: Balint Tamasi
##  
###############################################################

n <- 50
p <- seq(0.001, 0.999, by = 0.001)

## Wald CI
ci_wald <- function(x, n, gamma = 0.95) {
  if (x == 0) {
    p_hat <- 0
    se <- sqrt(0.5/n * (1 - 0.5/n) / n)
    ci <- c(0, p_hat + qnorm(gamma) * se) 
  } else if (x == n) {
    p_hat <- 1
    se <- sqrt((n-0.5)/n * (1 - (n-0.5)/n) / n)
    ci <- c(p_hat - qnorm(gamma) * se, 1)
  } else {
    p_hat <- x / n
    se <- sqrt(p_hat * (1 - p_hat) / n)
    ci <- c(max(0, p_hat - qnorm((1 + gamma)/2) * se),
            min(1, p_hat + qnorm((1 + gamma)/2) * se))
  }
  return(ci)
}

## Wald CI w/ logit transformation
ci_wald_logit <- function(x, n, gamma = 0.95) {
  if (x == 0) {
    x <- 0.5
    lp_hat <- log(x / (n - x))
    se <- sqrt(1 / x + 1 / (n - x))
    ci <- c(0, plogis(lp_hat + qnorm(gamma) * se)) 
  } else if (x == n) {
    x <- n - 0.5
    lp_hat <- log(x / (n - x))
    se <- sqrt(1 / x + 1 / (n - x))
    ci <- c(plogis(lp_hat - qnorm(gamma) * se), 1)
  } else {
    lp_hat <- log(x / (n - x))
    se <- sqrt(1 / x + 1 / (n - x))
    ci <- plogis(lp_hat + c(-1, 1) * qnorm((1 + gamma)/2) * se)
  }
  return(ci)
}

## LR CI
ci_lr <- function(x, n, gamma = 0.95) {
  p_hat <- x / n
  rll_tr <- function(p) {
    dbinom(x, n, p, log = TRUE) - dbinom(x, n, p_hat, log = TRUE) +
      0.5 * qchisq(gamma, 1)
  }
  if (x == 0)
    l <- 0
  else
    l <- uniroot(rll_tr, c(0, p_hat))$root
  if (x == n)
    u <- 1
  else
    u <- uniroot(rll_tr, c(p_hat, 1-.Machine$double.eps))$root
  return(c(l, u))
}

## Wilson CI
ci_wilson <- function(x, n, gamma = 0.95) {
  q <- qnorm((1 + gamma)/2)
  p_hat <- x / n
  (x + q^2/2) / (n + q^2) + c(-1, 1) * q*sqrt(n) / (n + q^2) * 
    sqrt(p_hat * (1 - p_hat) + q^2 / (4*n))
}

## Coverage plot
coverage_plot <- function(p, n, ci, name = NULL) {
  probs <- outer(0:n, p, FUN = function(x, y) dbinom(x, n, y))
  cis <- sapply(0:n, ci, n = n)
  contains <- outer(cis[1, ], p, "<") &  outer(cis[2, ], p, ">")
  coverage <- colSums(contains * probs)
  plot(p, coverage, type = "l", col = "red", xlab = expression(pi),
       ylim = c(0.8, 1), font.main = 1, main = name)
  sm <- lowess(coverage, f = 0.095)$y
  lines(p[p > 0.05 & p < 0.95], 
        sm[which(p > 0.05 & p < 0.95)], 
        lty = 1, lwd = 1.5)
  abline(h = 0.95)
}


par(mfrow = c(2, 2))
coverage_plot(p, n, ci_wald, "Wald")
coverage_plot(p, n, ci_wald_logit, expression(paste("Wald for logit(", pi, ")")))
coverage_plot(p, n, ci_lr, "Likelihood ratio")
coverage_plot(p, n, ci_wilson, "Wilson")