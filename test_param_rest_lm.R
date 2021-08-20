################################################################################ 
##    Testing linear restrictions of parameters in normal linear 
##    regression models
## 
##    Author: Balint Tamasi
##    Date:   10/03/2018
################################################################################

data("Carseats", package = "ISLR")

fit <- lm(Sales ~ ShelveLoc + Advertising, data = Carseats)
summary(fit)

## Goal: using this specification, test if categories 'Good' and 'Medium' are
## the same, i.e. testing the H0: coef(fit)[2] = coef(fit)[3]

## Method 1: Creating a new dummy variable and using a partial F-test
Carseats$ShL_GorM <- with(Carseats, ShelveLoc != "Bad")
fit2 <- lm(Sales ~ ShL_GorM + Advertising, data = Carseats)
anova(fit, fit2) ## Reject H0

## Method 2: Calculating the test statistic of the exact F-test based on 
## the estimates in fit
b_hat <- coef(fit)
V_hat <- vcov(fit)
C <- rbind(h0 = c(0, 1, -1, 0)) ## Contrast corresponding the H0
(F_stat <- (C %*% b_hat)^2 / (C %*% V_hat %*% t(C)))
(p_val <- pf(F_stat, df1 = nrow(C), df2 = nrow(Carseats) - ncol(C), 
             lower.tail = FALSE))

## In the more general case, of H0: C %*% b_hat - d = 0, where C has more than 
## one rows, see Farmheir pp 135.
## r <- nrow(C) ## number of restrictions
## (F_stat <- 1/r * t(C %*% b_hat - d) %*% solve(C %*% V_hat %*% t(C)) %*% 
##   (C %*% b_hat - d))
## (p_val <- pf(F_stat, df1 = r, df2 = nrow(Carseats) - ncol(C), 
##              lower.tail = FALSE))

## Method 3: Using the package multcomp