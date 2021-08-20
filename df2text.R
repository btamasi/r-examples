## Write out the contents of a data frame to a character vector with values
## "var1 = x, var2 = y, var3 = z"

df <- data.frame(a = 1:5, b = letters[1:5], c = runif(5))
apply(df, 1, function(x) {
  paste(mapply(FUN = function(n, v) paste(n, "=", v), n = names(df), v = x), collapse = ", ")
  })
