library(data.table)
library(ggplot2)

rm(list=ls())

# X ~ Normal
mu <- 0
sig <- 1
x <- seq(-5, 5, 0.01)
fxd <-dnorm(x, mu, sig)
fxp <- pnorm(x, mu, sig, lower.tail=FALSE)
dx <- data.table(x, fxd, fxp)

# P(X <= 3)
pnorm(3, mu, sig, lower.tail=TRUE)
ggplot(dx, aes(x, fxd)) +
  geom_line()

ggplot(dx, aes(x, fxp)) +
  geom_line() +
  ylab("P(X > x)")

# P(X < 3)
pnorm(3, mu, sig, lower.tail=TRUE)

# P(X > 3)
pnorm(3, mu, sig, lower.tail=FALSE)

# P(X >= 3)
pnorm(3, mu, sig, lower.tail=FALSE)


# Y ~ Binomial
n <- 15
p <- 0.3

# P(Y <= 3)
pbinom(3, n, p)

# P(Y < 3) = P(Y <= 2)
pbinom(2, n, p, lower.tail=TRUE)

# P(Y > 3)
pbinom(3, n, p, lower.tail=FALSE)

# P(Y >= 3) = P(Y > 2)
pbinom(2, n, p, lower.tail=FALSE)

