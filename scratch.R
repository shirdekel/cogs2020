library(data.table)
library(ggplot2)

rm(list=ls())

d <- fread('https://crossley.github.io/cogs2020/data/mis/mis_data.csv')

d[, unique(subject), .(phase)]

d[, unique(subject), .(group)]
