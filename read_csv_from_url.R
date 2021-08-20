## Read data from an online source using RCurl package

library("RCurl")
file <- getURL('url.of.the.data/data.csv',
               ssl.verifyhost = FALSE, ssl.verifypeer = FALSE)
hospital <- read.csv(textConnection(file))