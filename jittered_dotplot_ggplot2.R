## Create a jittered dotplot in ggplot2 to visulaize the distribution of grouped
## data. Add the median values to the plot.

library("ggplot2")

set.seed(123)

df <- data.frame(g = sample(letters[1:3], 1000, replace = TRUE, prob = c(0.3, 0.2, 0.5)))
df$x <- with(df, ifelse(g == "a", rnorm(1000, 8, 2), 
                        ifelse(g == "b", runif(1000, 1, 5), rnorm(1000, 5, 6))))

p <- ggplot(df, aes(x = g, y = x)) +
  geom_jitter(position = position_jitter(0.25), alpha = 0.4) +
  stat_summary(fun.y=median, fun.ymin = median, fun.ymax = median,
               geom = "crossbar", width = 0.5, col = "red")
print(p)
