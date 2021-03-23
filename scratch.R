library(data.table)
library(ggplot2)

rm(list=ls())

# X ~ N(mu=7, sig=2)
x <- seq(7 - 6, 7 + 6, 0.01)
fx <- dnorm(x, 7, 2)
d <- data.table(x, fx)
ggplot(d, aes(x, fx)) +
  geom_line()

# P(X > 4)
pnorm(4, 7, 2, lower.tail=F)

# P( >= 4)
pnorm(4, 7, 2, lower.tail=F)

