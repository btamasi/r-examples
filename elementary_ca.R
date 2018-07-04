####################################################################
##
##   Wolframs's elementary cellular automata
##
##   date:   4/7/2018
##   author: Balint Tamasi
##
####################################################################

## Returns a function corresponding to the rule based on the number
num2rule <- function(num) {
  stopifnot(num >= 0, num < 256)
  resp <- rev(as.numeric(rev(intToBits(num)[1:8])))
  out <- function(inp) {
    state <- Reduce(function(i, j) 2*i + j, inp) + 1 ## binary vector to decimal
    return(resp[state])
  }
  return(out)
}

## Calculates the next row based on an input row and a rule
step_state <- function(s, rule, wrap = TRUE) {
  ls <- length(s)
  if (wrap) {
    prev <- c(s[ls], s, s[1]) ## the grid is wrapped
  } else {
    prev <- c(0, s, 0) ## the grid is padded with 0s
  }
  out <- vector(mode = "numeric", length = ls)
  for (i in 1:ls) {
    out[i] <- rule(prev[i:(i+2)])
  }
  return(out)
}

## Plots the results starting from a row with one pixel on in the middle
plot_ca <- function(nr, nc, rule, wrap = TRUE) {
  ## =============================================
  ## nr: number of rows in the resulting image
  ## nc: number of columns in the resulting image
  ## rule: rule as a function
  ## wrap: how to handle the edges
  ## =============================================
  res <- matrix(0, nrow = nr, ncol = nc)
  res[1, ] <- rep(0, nc)
  res[1, round(nc/2)] <- 1
  v <- step_state(res[1, ], rule, wrap)
  for (i in 2:nr) {
    res[i, ] <- v
    v <- step_state(v, rule, wrap)
  }
  par(mar = c(1, 1, 1, 1))
  image(t(apply(res, 2, rev)), useRaster = TRUE, axes = FALSE,
        col = c(0, 1))
}

plot_ca(250, 500, num2rule(30))
plot_ca(250, 500, num2rule(150))