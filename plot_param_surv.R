library("survival")
par(cex = 0.8)

## Loading the data
data("lung", package = "survival")

## Kaplan-Meier
KM_fit <- survfit(Surv(time, status) ~ as.factor(sex), data = lung)
plot(KM_fit, mark.time = TRUE, col = 1:2, ylim = c(0, 1), 
     xlab = "t", ylab = "S(t)")

## Parametric
sex <- c("Male", "Female")
pct <- seq(0.01, 0.99, by = 0.01)
pred <- matrix(ncol = length(sex), nrow = length(pct))
for (i in seq_along(sex)) {
  param_fit <- survreg(Surv(time, status) ~ 1, data = lung,
                       dist = "weibull", subset = (sex == i))
  pred[, i] <- predict(param_fit, newdata = data.frame(sex = i),
                       type = "quantile", p = pct)
}
matplot(x = pred, y = 1-pct, type = "l", col = 1:2, 
        lty = 2, add = TRUE)
legend("topright", 
       paste(sex, 
             rep(c("Kaplan-Meier", "Weibull"), each = 2),
             sep = " - "),
       col = rep(1:2, 2),
       lty = rep(1:2, each = 2),
       bty = "n")