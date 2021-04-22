library(data.table)
library(ggplot2)

rm(list=ls())

# HW 4 prob 2

# 1
# H0: p = 0.5
# H1: p != 0.5

# 2
# alpha = 0.05

# 3
# p_hat = x_obs / n
# x_obs ~ binomial(n, p) --- count of successes
# p_hat ~ binomial(n, p), x -> x / n --- proportion of successes 

# 4
# data will be stored in a data.table
# You've got d and dd from problem 1
# d contains trial by trial information 
# dd contains block by block information
# first 100 trials are in d
# d[i, j, by]
# i -> what rows do you want
# j -> what columns do you want and what to do with them
# by -> how do you want to group what you're doing with the js
x_obs <- d[(phase == 1) & (trial %in% 1:100), acc]
n <- length(x_obs)
p_hat_obs <- sum(x_obs == 1) / n

# 5
# lower.tail=FALSE: P(X > x) = P(X >= x - 1)
p_val_upper <- pbinom(p_hat_obs_upper * n, n, 0.5, lower.tail=FALSE)
p_val_lower <- pbinom(p_hat_obs_lower * n, n, 0.5, lower.tail=TRUE)
p_val <- p_val_lower + p_val_upper

crit_upper <- (qbinom(0.025, n, p, lower.tail=FALSE) - 1) / n 
crit_lower <- (qbinom(0.025, n, p, lower.tail=TRUE)) / n

# binom.test(...)