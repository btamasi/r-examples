## Plotting points with error bars using base R

dat <- data.frame(est = c(2, 4, 6),
                  SE  = c(0.6, 0.4, 0.2))

par(cex = 0.8)
x <- seq_along(dat$est)
plot(x, dat$est, pch = 19,
     main = "Scatterplot with error bars",
     ylim = range(c(dat$est - 2*dat$SE, dat$est + 2*dat$SE)),
     ylab = bquote(hat(beta)~"± 2SE"),
     xaxt = "n")
axis(1, at = x, labels = c("First", "Second", "Third"))
arrows(x, dat$est - 2*dat$SE, x, dat$est + 2*dat$SE, 
       length = 0.05, angle = 90, code = 3)