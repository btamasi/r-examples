####################################################################
##
##   Conway's Game of Life
##
##   date:   5/5/2018
##   author: Balint Tamasi
##
####################################################################

####################################################################
##  Functions
####################################################################

gol_step <- function(grid, wrapped = FALSE) {
  ## One step in the Game of Life
  stopifnot(is.matrix(grid))
  nr <- nrow(grid)
  nc <- ncol(grid)
  if (wrapped) { ## The grid is wrapped
    wrap <- cbind(grid[, nc], grid, grid[, 1])
    wrap <- rbind(wrap[nr, ], wrap, wrap[1, ])  
  } else {
    wrap <- cbind(0, grid, 0)
    wrap <- rbind(0, wrap, 0) 
  }
  ## neighbors
  n <- rbind(0, wrap[-(nr+1), ])
  s <- rbind(wrap[-1, ], 0)
  e <- cbind(wrap[, -1], 0)
  w <- cbind(0, wrap[, -(nc+1)])
  ne <- cbind(rbind(0, wrap[-(nr+1), -1]), 0)
  nw <- cbind(0, rbind(0, wrap[-(nr+1), -(nc+1)]))
  se <- cbind(rbind(wrap[-1, -1], 0), 0)
  sw <- cbind(0, rbind(wrap[-1, -(nc+1)], 0))
  sumn <- n + s + e + w + ne + nw + se + sw 
  sumn <- sumn[2:(nr+1), 2:(nc+1)]
  out <- grid
  out[(grid == 1) & (sumn < 2)] <- 0
  out[(grid == 1) & (sumn == 2 | sumn == 3)] <- 1
  out[(grid == 1) & (sumn > 3)] <- 0
  out[(grid == 0) & (sumn == 3)] <- 1
  return(out)
}

gol_plot <- function(grid) {
  ## Plot the grid in Game of Life
  stopifnot(is.matrix(grid))
  par(mar = c(1, 1, 1, 1))
  image(grid, useRaster = TRUE, axes = FALSE,
        col = c(0, 1))
}

####################################################################
##  Animation
####################################################################

library("animation")
ani.options(interval = 0.1, nmax = 200)
quartz(width = 3, height = 3)
world <- matrix(sample(c(0, 1), 150 * 150, replace = TRUE, 
                       prob = c(0.7, 0.3)), nrow = 150)
for (i in 1:ani.options('nmax')) {
  gol_plot(world)
  ani.pause()
  world <- gol_step(world, wrapped = TRUE)
}