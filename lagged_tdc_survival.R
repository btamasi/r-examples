## Options in survival package to generate lagged time dependent covariates

library("survival")

## raw data
ev <- data.frame(id = c(1, 2), time = c(45, 25), event = c(1, 0)) ## event
tdc <- data.frame(id = c(1, 1, 2, 2), t = c(0, 30, 0, 5), val = c(0, 1, 0, 1)) ## time dep cov

cd <- tmerge(ev, ev, id = id, death = event(time, event))

## w/o lag
cdt1 <- tmerge(cd, tdc, id = id, cov = tdc(t, val))
cdt1

## 5 lags: v1 
cdt2 <- tmerge(cd, tdc, id = id, cov = tdc(t, val), options = list(delay = 5))
cdt2

## 5 lags: v2 (generates NAs)
cdt3 <- tmerge(cd, tdc, id = id, cov = tdc(t+5, val))
cdt3
