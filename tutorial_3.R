library(data.table)
library(ggplot2)

rm(list = ls())

# thinking about and creating data.table sample spaces
# HW asks for two four-sided die
# Good tutorial example might be three coins

x1 <- c(1, 1, 1, 1, 0, 0, 0, 0)
x2 <- c(1, 1, 0, 0, 1, 1, 0, 0)
x3 <- c(1, 0, 1, 0, 1, 0, 1, 0)

d <- data.table(x1, x2, x3)

# create deep copy
dd <- data.table(d)

# Create a random variable that is in terms of x1, x2, x3
# E.g., let X = number of Hs in an experiment
dd[, X := 1:.N]
dd[, X := sum(x1, x2, x3), .(X)]

# compute probabilities by conditionally summing rows
# P(X < 2)
dd[, sum(X < 2) / .N]

# what is an elementary event?
dd[, .N == 1, X]



n <- 10
p <- 1/ 3
x <- 1:10
fx <- dbinom(x, n, p)
d <- data.table(x, fx)
ggplot(d, aes(x, fx)) + 
  geom_point()

