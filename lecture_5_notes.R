library(data.table)

rm(list=ls())

d <- data.table(letters[1:10], seq(1, 20, 2 ))

d[V2 > 9, .N]
