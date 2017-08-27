## Add grid (matched with x axis) behind a histogram. Also add rug plot and some
## other formatting.

pretty_hist <- function(x, ...) {
  hist(x, col = grey(0.6, alpha = 0), lty = 0, ...)
  grid(col = "black")
  hist(x, col = grey(0.6, alpha = 0.75), lty = 0, add = TRUE, ...)
  rug(x, col = grey(0.6, alpha = 0.2))
}

set.seed(1)
pretty_hist(rbeta(10000, 3, 40), breaks = 40)
