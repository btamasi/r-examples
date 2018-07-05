####################################################################
##
##   Using Chi-square goodness-of-fit test to test if a sample of  
##   data came from a population with a specific discrete 
##   distribution
##
##   date:   5/7/2018
##   author: Balint Tamasi
##
####################################################################

####################################################################
## Uniform case
####################################################################
set.seed(123)
x <- sample(1:10, 200, replace = TRUE, prob = c(rep(2, 3), rep(1, 7)))
barplot(table(x) / length(x))

## H0: discrete uniform distribution (i.e. equal prob for each number)
obs <- table(x)
chisq.test(obs, p = rep(1/length(obs), length(obs)))


####################################################################
## Poisson case
####################################################################
## Simulate Poisson distributed random numbers by counting the number 
## of events in unit time from a Poisson process
set.seed(100)
t <- 0
ct <- 0
lambda <- 2
N <- 50
while (t < N) {
  t <- t + rexp(1, lambda)
  ct <- c(ct , t)
}
x <- cut(ct, 0:N)
x <- as.numeric((table(x)))
(freq <- c(sapply(0:max(x), function(i) sum(i == x)), 0))
barplot(freq, names.arg = c(0:max(x), paste0(max(x), "<")), cex.names = 0.6)
(lambda_hat <- mean(x)) ## MLE 

## H0: Poisson distribution with rate equals to the MLE
ps <- dpois(0:max(x), lambda = lambda_hat)
(ps <- c(ps, 1 - sum(ps))) ## take care of the tail (support is 0-Inf)
chisq.test(freq, p = ps, simulate.p.value = TRUE)
