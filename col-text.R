## Printing colored text on terminal
## example from: https://stackoverflow.com/a/57031762
## more details: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences

txt <- "test"
for(col in 29:47){ cat(paste0("\033[0;", col, "m",txt,"\033[0m","\n"))}
