library(data.table)
library(ggplot2)

rm(list=ls())

# 1
# X ~ N(mu_x, sig_x = 0.15)
# H0: mu_x = 0.6
# H1: mu_x > 0.6

# 2
# alpha = 0.05

# 3
# mu_x_hat = x_bar
# x_bar ~ N(mu_x_bar, sig_x_bar)
# mu_x_bar = mu_x
# sig_x_bar = sig_x / sqrt(n)

# 4
x <- c(0.56,0.56,0.54,0.64,0.47,0.67,0.41,0.57,0.66,0.62)
n <- length(x)
sig_x <- 0.15

x_bar_obs = mean(x)
mu_x_bar <- 0.6 # assuming H0 is true
sig_x_bar = sig_x / sqrt(n)

xx <- seq(mu_x_bar - 4*sig_x_bar, mu_x_bar + 4*sig_x_bar, 0.001)
fx <- dnorm(xx, mu_x_bar, sig_x_bar)
d <- data.table(xx, fx)
ggplot(d, aes(xx, fx)) +
  geom_line()

# 5
pval <- pnorm(x_bar_obs, mu_x_bar, sig_x_bar, lower.tail=FALSE)
x_bar_crit <- qnorm(0.05, mu_x_bar, sig_x_bar, lower.tail=FALSE)

if(pval < 0.05) {
  decision <- "reject H0"
} else {
  decision <- "fail to reject H0"
}

# extra stuff
# Report point and interval estimates
# point estimate is x_bar_obs
# confidence interval estimate (a lot like critical value approach)
x_bar_crit_lower <- qnorm(0.025, mu_x_bar, sig_x_bar, lower.tail=TRUE)
x_bar_crit_upper <- qnorm(0.975, mu_x_bar, sig_x_bar, lower.tail=TRUE)
ci_width <- x_bar_crit_upper - x_bar_crit_lower
ci_lower <- x_bar_obs - ci_width / 2
ci_upper <- x_bar_obs + ci_width / 2

# Compute power against the alternative H1 that μx is .62
# H0: mu_x = 0.6
# H1: mu_x = 0.62

xx <- seq(mu_x_bar - 4*sig_x_bar, mu_x_bar + 4*sig_x_bar, 0.001)
fx_H0 <- dnorm(xx, 0.6, sig_x_bar)
fx_H1 <- dnorm(xx, 0.62, sig_x_bar)
d <- data.table(xx, fx_H0, fx_H1)
ggplot(d, aes(x=xx)) +
  geom_line(aes(y=fx_H0), colour='red') +
  geom_line(aes(y=fx_H1), colour='blue') +
  geom_vline(xintercept=x_bar_crit)

type_I_error <- pnorm(x_bar_crit, 0.6, sig_x_bar, lower.tail=FALSE)
power <- pnorm(x_bar_crit, 0.62, sig_x_bar, lower.tail=FALSE)
type_II_error <- pnorm(x_bar_crit, 0.62, sig_x_bar, lower.tail=TRUE)
confidence <- pnorm(x_bar_crit, 0.6, sig_x_bar, lower.tail=TRUE)


# Practice 3

# 1
# X ~ N(mu_x, sig_x)
# H0: mu_x = 0
# H1: mu_x != 0

# 2
# alpha = 0.05

# 3
# mu_x_hat = x_bar
# x_bar ~ N(mu_x_bar, sig_x_bar)
# mu_x_bar = mu_x
# sig_x_bar = sig_x / sqrt(n)
# t_obs = (x_bar_obs - mu_x_bar_H0) / sig_x_bar_hat
# t_obs = (x_bar_obs - mu_x_bar_H0) / (sd(x_obs) / sqrt(n)) 
# t_obs ~ t(n-1)

# 4
x_obs <- c(12.06, -0.86, 7.55, 16.29, -10.36, -19.27, 0.7, -3.54, -8.14, -6.5, -9.74, 10.9, 17.28, 14.88, -6.44)
n <- length(x_obs)
x_bar_obs <- mean(x_obs)
sig_x_bar_hat <- sd(x_obs) / sqrt(n)
t_obs <- (x_bar_obs - 0) / sig_x_bar_hat

t <- seq(-4, 4, 0.01)
ft <- dt(t, n-1)
d <- data.table(t, ft)
ggplot(d, aes(t, ft)) +
  geom_line()

# 5
t_obs_upper <- abs(t_obs)
t_obs_lower <- -abs(t_obs)
pval_upper <- pt(t_obs_upper, n-1, lower.tail=FALSE)
pval_lower <- pt(t_obs_lower, n-1, lower.tail=TRUE)
pval <- pval_lower + pval_upper

if(pval < 0.05) {
  decision <- "reject H0"
} else {
  decision <- "fail to reject H0"
}

t.test(x_obs, mu=0, alternative='two.sided')

# 95% confidence interval
t_crit_upper <- qt(0.025, n-1, lower.tail=FALSE) 
t_crit_lower <- qt(0.025, n-1, lower.tail=TRUE) 
ci_width <- t_crit_upper - t_crit_lower

ci_upper <- t_obs + ci_width/2
ci_lower <- t_obs - ci_width/2

ci_upper <- ci_upper * sig_x_bar_hat
ci_lower <- ci_lower * sig_x_bar_hat


# compute power
t_crit <- qt(0.05, n-1, lower.tail=FALSE) 
t <- seq(-4, 6, 0.01)
ft_H0 <- dt(t, n-1) # mu_x = 0
ft_H1 <- dt(t-2, n-1) # mu_x = 2
d <- data.table(t, ft_H0, ft_H1)
ggplot(d, aes(x=t)) +
  geom_line(aes(y=ft_H0), colour='red') +
  geom_line(aes(y=ft_H1), colour='blue') +
  geom_vline(xintercept=t_crit)

type_I_error <- pt(t_crit, n-1, lower.tail=FALSE)
confidence <- pt(t_crit, n-1, lower.tail=TRUE)
power <- pt(t_crit-2, n-1, lower.tail=FALSE)
type_II_error <- pt(t_crit-2, n-1, lower.tail=TRUE)

# If relative to a two tailed test
t_crit <- qt(0.05, n-1, lower.tail=FALSE) 
t <- seq(-4, 6, 0.01)
ft_H0 <- dt(t, n-1) # mu_x = 0
ft_H1 <- dt(t-2, n-1) # mu_x = 2
d <- data.table(t, ft_H0, ft_H1)
ggplot(d, aes(x=t)) +
  geom_line(aes(y=ft_H0), colour='red') +
  geom_line(aes(y=ft_H1), colour='blue') +
  geom_vline(xintercept=t_crit_lower) +
  geom_vline(xintercept=t_crit_upper)


type_I_error <- pt(t_crit, n-1, lower.tail=FALSE)
confidence <- pt(t_crit, n-1, lower.tail=TRUE)
power <- pt(t_crit-2, n-1, lower.tail=FALSE)
type_II_error <- pt(t_crit-2, n-1, lower.tail=TRUE)

