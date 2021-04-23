library(data.table)
library(ggplot2)

rm(list=ls())

# HW 4 prob 6

# 1
# X -> mean accuracy per block
# X ~ N(mu_x, sig_x)
# H0: mu_x = 0.5
# H1: mu_x != 0.5

# 2
# alpha = 0.05

# 3
# mu_hat = x_bar
# x_bar ~ N(mu_x_bar, sig_x_bar)
# mu_x_bar = mu_x
# sig_x_bar = sig_x / sqrt(n)
# t_obs = (x_bar_obs - mu_x_bar) / sig_x_bar
# t_obs ~ t(n-1)

# 4
# data is in d2 and dd2
# d2 carries information about trials
# dd2 carries anout blocks, so we use dd2
x_obs = dd2[(phase==1) & (block %in% 1:16), acc_mean]
n <- length(x_obs)
x_bar_obs <- mean(x_obs)
sig_x_bar_hat <- sd(x_obs)
t_obs <- (x_bar_obs - 0.5) / (sig_x_bar_hat / sqrt(n))

# 5
t_obs_upper <- abs(t_obs)
t_obs_lower <- -abs(t_obs)
p_val_upper <- pt(t_obs_upper, n-1, lower.tail=FALSE)
p_val_lower <- pt(t_obs_lower, n-1, lower.tail=TRUE)
p_val <- p_val_upper + p_val_lower

t_crit_upper <- qt(0.025, n-1, lower.tail=FALSE)
t_crit_lower <- qt(0.025, n-1, lower.tail=TRUE)

ci_width <- (t_crit_upper - t_crit_lower) * sig_x_bar_hat
ci_upper <- x_bar_obs + ci_width / 2
ci_lower <- x_bar_obs - ci_width / 2

t.test(x_obs, mu=0.5, alternative='two.sided')

