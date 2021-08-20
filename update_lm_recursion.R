## Updating lm objects to remove the predictors with the highest p-values
## one-by-one using recursion. 
## Warning: generates biased results

updater <- function(fit, p_th = 0.05) {
  vn <- names(coef(fit))
  if (is.null(vn) || (length(vn) == 1 && vn == "(Intercept)")) {
    print("No significant variables found")
    return(fit)
  }
  pv <- summary(fit)$coef[vn != "(Intercept)", 4]
  vn <- vn[vn != "(Intercept)"]
  if (all(pv <= p_th)) {
    return(fit)
  } else {
    vnr <- vn[which.max(pv)]
    ufit <- update(fit, as.formula(paste0(". ~ . -", vnr)))
    updater(ufit)
  }
}

data(Boston, package = "MASS")
fit1 <- lm(medv ~ ., data = Boston)
summary(fit1)

## updates the initial fit, by eliminating the predictors with the
## highest p-values one-by-one
fit2 <- updater(fit1)
summary(fit2)
