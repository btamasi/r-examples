### ======================================================
### Comparison of assignment operators = and <-
### Author: Balint Tamasi
### Date: 29-08-2019
### ======================================================

## References:
## https://developer.r-project.org/equalAssign.html
## https://blog.revolutionanalytics.com/2008/12/use-equals-or-arrow-for-assignment.html
## https://stackoverflow.com/questions/1741820/what-are-the-differences-between-and-in-r
## https://csgillespie.wordpress.com/2010/11/16/assignment-operators-in-r-vs/
## R Inferno 8.2.26

## = is used for setting function arguments, while <- is only used for assignments
quote(y = 10) # error
quote(y <- 10) # no error
median(y <- 1:10) # assignment and calling a function on it
median(y = 1:10) # error because y is not a valid argument

## `=` and `<-` can be called as
`=`(y, 10) # same as y = 10
`<-`(y, 10) # same as y <- 10

## = and <- are not the same operator
class(quote(`=`(y, 10)))
class(quote(`<-`(y, 10)))

## <- is of higher precedence level (and evaluated from right to left!)
## see: https://stat.ethz.ch/R-manual/R-patched/library/base/html/Syntax.html
x <- y <- 5 # valid and identical to `<-`(x, `<-`(y, 5))
x <- y = 5 # throws an error because it is interpreted as `=`(`<-`(x, y), 5)
