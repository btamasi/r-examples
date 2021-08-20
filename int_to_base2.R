## Converting integers to base 2 vectors

get_base2 <- function(x) {
  out <- sapply(intToBits(x), as.integer)
  out <- format(as.numeric(paste(rev(out), collapse = "")), 
                 scientific = FALSE)
  out <- as.numeric(strsplit(as.character(out), "")[[1]])
  return(out)
}

get_base2(16)
get_base2(12345)