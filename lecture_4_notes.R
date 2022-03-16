library(data.table)

rm(list=ls())

# X ~ Normal(15, 2.74)
mu <- 15
sig <- 2.74

# Y ~ Binomial(30, 0.5)
n <- 30
p <- 0.5

# P(X > 17)
pnorm(17, mu, sig, lower.tail=F)

# P(Y < 17) = P(Y <= 16)
pbinom(17, n, p, lower.tail=T)