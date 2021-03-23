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

# Y ~ binomial(n=8, p=0.8)

# P(Y <= 2)
pbinom(2, 8, 0.8, lower.tail=TRUE)

# P(Y < 2) = P(Y <= 1)
pbinom(2, 8, 0.8, lower.tail=TRUE)
