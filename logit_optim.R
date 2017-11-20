###############################################################
## Calculates the MLE of the parameters of a logistic 
## regression model by maximizing the log-likelihood. 
## The likelihood function takes data and formula of the model 
## as input.
## WARNING: The results are less accurate than using the glm()
## function.
###############################################################

loglik <- function(beta, formula, data) {
  X <- model.matrix(formula, data)
  y <- model.response(model.frame(formula, data))
  p <- exp(X %*% beta) / (1 + exp(X %*% beta))
  sum(dbinom(y[,1], size = rowSums(y), prob = p, log = TRUE))
}

data("orings", package = "faraway")
mle <- optim(par = c(0, 0), fn = loglik, 
             formula = cbind(damage, 6-damage) ~ temp, 
             data = orings,
             method = "BFGS", control = list(fnscale = -1))
mle$par

fit <- glm(cbind(damage, 6-damage) ~ temp, data = orings, 
           family = binomial(link = "logit"))
all.equal(coef(fit), mle$par, 
          check.attributes = FALSE)
