library(data.table)
library(ggplot2)

rm(list=ls())

# is the mean height of mq students < 6 ft?

# 1
# H0: mu_x = 6
# H1: mu_x < 6

# 2
# alpha = 0.05

# 3
# mu_hat = x_bar
# x_bar ~ N(mu_xbar, sig_xbar)
# mu_xbar = mu_x
# sig_xbar =  sig_x / sqrt(n)
# sig_x_hat = sd(data)
# t_obs = (x_bar - mu_x) / sig_x_bar
# t_obs ~ t(df)
# df = n - 1

# 4
# X -> x1, x2, ...., xn
# x_bar_obs = mean(c(x1, x2, ..., xn))
# x_bar_sig = some value using equations above
# t_obs = some value using equation above

# 5
# if P(t < t_obs) < alpha:
# then reject H0

pval <- pt(t_obs, n-1, lower.tail=lower.tail=TRUE)

