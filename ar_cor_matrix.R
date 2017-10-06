## Create AR(1) correlation matrix for a vector of interdependent observations
## size: 6x6

rho <- 0.8
S <- rho ^ abs(outer(0:5, 0:5, "-"))
print(S)