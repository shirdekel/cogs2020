library(data.table)
library(ggplot2)
rm(list=ls())

x <- 0:100
fx <- dbinom(x, 100, 0.5)
d <- data.table(x, fx)
ggplot(d, aes(x, fx)) +
  geom_point() + 
  geom_vline(xintercept=82)

pbinom(82-1, 100, 0.5, lower.tail=F)
d[x >= 82, sum(fx)]
