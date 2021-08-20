####################################################################
##
##    Weibull relative log-likelihood & profile likelihood
##    ====================================================
##
##    Author: Balint Tamasi
##  
####################################################################


####################################################################
## Data
####################################################################
x <- c(225, 175, 198, 189, 189, 130, 162, 135, 119, 162)

####################################################################
## MLE
####################################################################
## Log-likelihood
loglik <- function(par, x) {
  sum(dweibull(x, shape = par[1], scale = par[2], log = TRUE))
}

mle <- optim(par = c(5, 5), fn = loglik, x = x, method = "L-BFGS-B", 
             lower = c(0, 0), control = list(fnscale = -1), 
             hessian = TRUE)


####################################################################
## Plot the relative joint log-likelihood
####################################################################
par(mfrow = c(1, 2), font.main = 1)
## Grid
alpha <- seq(0.1, 15, length.out = 500) 
mu <- seq(110, 300, length.out = 500)
pars <- as.matrix(expand.grid(alpha = alpha, mu = mu))
rll <- matrix(apply(pars, MARGIN = 1, loglik, x = x), ncol = 500) - mle$value

plot(alpha, seq_along(alpha), type = "n",
     xlim = c(0.1, 15), ylim = c(110, 300),
     xlab = expression(alpha), ylab = expression(mu), 
     main = "Relative log-likelihood")
contour(x = alpha, y = mu, z = rll, levels = c(seq(-10, -2, by = 2), -1, 0),
        add = TRUE)
points(mle$par[1], mle$par[2], pch = 4, lwd = 2)


####################################################################
## 95% Confidence region based on LR
####################################################################
contour(x = alpha, y = mu, z = rll, levels = log(.05), add = TRUE, 
        col = "red", drawlabels = FALSE)


####################################################################
## Profile log-likelihood
####################################################################
## profile log-likelihood
prof_ll_alpha <- function(alpha, x) {
  fun <- function(mu) {
    loglik(c(alpha, mu), x)
  }
  pmle <- optim(100, fn = fun, lower = 0, method = "L-BFGS-B", 
                control = list(fnscale = -1))
  return(c(pmle$par, pmle$val))
}

## conditional MLE for mu given alpha to the joint relative 
## log-likelihood
mu_prof <- sapply(alpha, prof_ll_alpha, x = x)
lines(alpha, mu_prof[1, ], lty = 2, lwd = 1.5)

## Legend
legend(x = 6, y = 308, 
       c("MLE", expression(hat(mu)[ML](alpha)), "95% LR confidence region"),
       lty = c(NA, 2, 1), pch = c(4, NA, NA), lwd = c(2, 1.5, 1),
       col = c(1, 1, 2), cex = 0.8, bty = "n", 
       seg.len = 0.35, x.intersp = 0.2, y.intersp = c(0.6, 0.6, 0.6))


####################################################################
## 95% Wald CIs
####################################################################
I_obs <- -mle$hessian
var_par <- solve(I_obs)
se <- sqrt(diag(var_par))
alpha_ci <- mle$par[1] + c(-1, 1) * se[1] * qnorm(0.975)
mu_ci <- mle$par[2] + c(-1, 1) * se[2] * qnorm(0.975)


####################################################################
## Plotting the relative profile log-likelihood with its quadratic
## approximation and Wald CIs for alpha
####################################################################
idx <- which(alpha > 2 & alpha < 12)
plot(alpha[idx], mu_prof[2, idx] - mle$value, type = "l",
     ylim = c(-6, 0.5),
     xlab = expression(alpha),
     ylab = expression(tilde(l)[p](alpha)),
     main = "Relative profile log-likelihood")
abline(v = mle$par[1], lty = 4)
qapprox <- -0.5 / var_par[1, 1] * (alpha[idx] - mle$par[1])^2
lines(alpha[idx], qapprox, lty = 2)
abline(v = alpha_ci, lty = 3)
abline(h = -0.5 * qchisq(0.95, 1), lty = 3)

## Legend
legend(x = 6.5, y = 0.75,
       c("Relative profile ll", "Quadratic approx", 
         expression(hat(alpha)[ML]), "95% Wald CI"),
       seg.len = 0.35, x.intersp = 0.2, y.intersp = 0.6,
       lty = c(1, 2, 4, 3), bty = "n", 
       cex = 0.8)
