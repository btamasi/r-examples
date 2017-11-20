##############################################################
## Simulates data, and creates a paired plot for baseline 
## and follow-up measurements in two treatment groups.
##############################################################
set.seed(100)
dat <- data.frame(treatment = rep(c("A", "B"), each = 20),
                  before = rnorm(40, mean = 30, sd = 2),
                  followup = c(rnorm(20, mean = 35, sd = 3),
                               rnorm(20, mean = 38, sd = 2)))

par(mfrow = c(1, 2))
matplot(t(dat[dat$treatment == "A", c("before", "followup")]),
        type = "b", col = 1, pch = 16, lty = 1, xaxt = "n",
        ylab = "yield", main = "Treatment A",
        ylim = c(min(dat[, -1]), max(dat[, -1])),
        xlim = c(0.9, 2.1))
axis(1, at = c(1, 2), label = c("baseline", "follow-up"))
abline(v = c(1, 2), lty = 3, col = 1)
matplot(t(dat[dat$treatment == "B", c("before", "followup")]),
        type = "b", col = 1, pch = 16, lty = 1, xaxt = "n",
        ylab = "yield", main = "Treatment B",
        ylim = c(min(dat[, -1]), max(dat[, -1])),
        xlim = c(0.9, 2.1))
axis(1, at = c(1, 2), label = c("baseline", "follow-up"))
abline(v = c(1, 2), lty = 3, col = 1)
