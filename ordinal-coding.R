## Codings/contrasts for ordinal variables

## Create indicator variables corresponding split-coding
## (or any other coding types) by hand. Can be useful when
## a model does not handle contrast and we have to set it up
## on our own.

(f <- factor(sample(c("low", "medium", "high", "very high"), 40, replace = TRUE),
            levels = c("low", "medium", "high", "very high"), ordered = TRUE))
## Indicator matrix
indi <- model.matrix(~ 0 + f)
## Contrast matrix of split-coding
## (it is really the coding matrix, R uses it wrongly)
cont <- matrix(1, nrow = 4, ncol = 4)
cont[upper.tri(cont)] <- 0
cont[, -1]
## Design matrix
(X <- indi %*% cont[, -1])

## Alternatively, we can set the contrasts of f
contrasts(f) <- cont[, -1]
head(model.matrix(~ f))

## the contrast matrix is the inverse of the coding matrix
(ic <- solve(cont))
## contrast weights sum to 0 (except for the first one)
rowSums(ic)

## Not orthogonal
ic %*% t(ic)

## === Default is polynomial
## conding
cont <- contr.poly(nlevels(f), contrasts = FALSE) ## add the intercept, too

## contrasts
(ic <- solve(cont))
rowSums(ic)

## This is orthonormal
ic %*% t(ic)
