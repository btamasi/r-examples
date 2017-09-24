## Plot the pdf of the Weibull distribution with various parameter values.
## Add legends with expressions to the plots
## Write a title to the outer margin of the plot

png("Weibull.png", width = 400, height = 900) # save the image as png
par(mfrow = c(3, 1),
    oma = c(0, 0, 2, 0)) # Set outer margin size
for (sigma in c(1, 1.5, 2)) {
  curve(dweibull(x, shape = 0.5, scale = sigma), from = 0, to = 5, n = 201,
        col = "black", ylab = "")
  curve(dweibull(x, shape = 1, scale = sigma), from = 0, to = 5, n = 201, 
        add = TRUE, col = "green", ylab = "")
  curve(dweibull(x, shape = 1.5, scale = sigma), from = 0, to = 5, n = 201, 
        add = TRUE, col = "red", ylab = "")
  curve(dweibull(x, shape = 5, scale = sigma), from = 0, to = 5, n = 201, 
        add = TRUE, col = "blue", ylab = "")
  ## Create the expressions for the legends
  leg_expr <- c(bquote(sigma == .(sigma) ~ "," ~ kappa == 0.5), 
                bquote(sigma == .(sigma) ~ "," ~ kappa == 1),
                bquote(sigma == .(sigma) ~ "," ~ kappa == 1.5),
                bquote(sigma == .(sigma) ~ "," ~ kappa == 5))
  legend("topright", sapply(leg_expr, as.expression), 
         col = c("black", "green", "red", "blue"), lty = c(1, 1, 1, 1))
}
title("Pdf of the Weibull distribution with various scale and shape parameters", 
      outer = TRUE) # Write title on the outer margin
dev.off() # switch off graphic device