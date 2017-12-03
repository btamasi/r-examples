###############################################################
## Poisson regression with offset:
## - Maximizes the likelihood, and calculates the standard 
##   errors of the parameters.
## - Extracts model matrix, response, offset using formula
## - Calculates MLE and SEs
## 
##    Author: Balint Tamasi
##    Date:   29/11/2017
###############################################################


###############################################################
## Log-likelihood
###############################################################
## Log-likelihood: Poisson w/ offset
## offset(n), instead of offset(log(n))
loglik <- function(formula, data, beta) {
  X <- model.matrix(formula, data)
  y <- model.response(model.frame(formula, data))
  n <- model.offset(model.frame(formula, data))
  lambda <- n * exp(X %*% beta) 
  sum(dpois(y, lambda = lambda, log = TRUE))
}


###############################################################
## Model fitting
###############################################################
## Data
data("epilepsy", package = "HSAUR2")
epilepsy$period <- as.numeric(epilepsy$period) ## set period length as numeric

## ML
mle <- optim(par = c(0, 0, 0, 0), fn = loglik, 
             formula = seizure.rate ~ base + age + treatment + offset(period),
             data = epilepsy,
             method = "BFGS", 
             control = list(fnscale = -1),
             hessian = TRUE)
mle$par
se <- sqrt(diag(solve(-mle$hessian)))


###############################################################
## Model fitting using glm()
###############################################################
## These results are numerically more accurate
fit.glm <- glm(seizure.rate ~ base + age + treatment + offset(log(period)), 
               data = epilepsy,
               family = poisson(link = "log"))
summary(fit.glm)

all.equal(coef(fit.glm), mle$par, check.attributes = FALSE)
all.equal(sqrt(diag(vcov(fit.glm))), se, check.attributes = FALSE)
