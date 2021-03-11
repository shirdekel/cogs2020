library(data.table)
library(ggplot2)

rm(list=ls())

x <- c(2, 3, 4, 5)
fx <- c(0.2, 0.2, 0.1, 0.5)
d <- data.table(x, fx)
ggplot(data=d, aes(x=x, y=fx)) +
  geom_point() +
  geom_segment(aes(x=x, xend=x, y=0, yend=fx))


# P(X = 3)
d[x==3, sum(fx)]

# P(X >= 3)
d[x >= 3, sum(fx)]

# P( 2 < X <= 4)
d[(x > 2) & (x <= 4), sum(fx)]

# E(X) 
mux <- (2 * 0.2 + 3 * 0.2 + 4 * 0.1 + 5 * 0.5)
mux <- d[, sum(x*fx)]

varx <- (2^2 * 0.2 + 3^2 * 0.2 + 4^2 * 0.1 + 5^2 * 0.5) - mux^2
varx <- d[, sum(fx * x^2) - mux^2]

sdx <- sqrt(varx)
