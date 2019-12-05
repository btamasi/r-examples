## Create indicator variables corresponding split-coding
## (or any other coding types) by hand. Can be useful when
## a model does not handle contrast and we have to set it up
## on our own.

(f <- factor(sample(c("low", "medium", "high", "very high"), 40, replace = TRUE),
            levels = c("low", "medium", "high", "very high"), ordered = TRUE))
## Indicator matrix
indi <- model.matrix(~ 0 + f)
## Contrast matrix of split-coding
cont <- matrix(1, nrow = 4, ncol = 4)
cont[upper.tri(cont)] <- 0
cont[, -1]
## Design matrix
(X <- indi %*% cont[, -1])
