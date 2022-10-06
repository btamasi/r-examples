files <- list.files(pattern = "*.(R|Rnw|Rmd)$")
pkgs <- unlist(lapply(files, function(f) grep("library\\(.*\\)", readLines(f), value = TRUE)))
pkgs <- unique(sub("\").*$", "", sub("library\\(\"", "", pkgs)))
install.packages(pkgs)
