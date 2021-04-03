library(data.table)
library(ggplot2)

rm(list=ls())

d <- fread('https://crossley.github.io/cogs2020/data/nhp_cat_learn/ii_gabor.csv')
setnames(d, c('cat', 'x', 'y', 'resp', 'rt', 'phase'))

d[, trial := 1:.N]

block_size <- 100
n_trial <- d[, .N]
n_block <- n_trial / block_size
block <- c(rep(1:n_block, each=block_size), rep(82, 96))
d[, block := block]
d[, acc := as.numeric(cat == resp)]

dd <- d[, .(mean_acc=mean(acc), sem=sd(acc)/sqrt(.N)), .(block, phase)]

ggplot(dd, aes(block, mean_acc, colour=factor(phase))) +
  geom_line()

# is mean accuracy in block 1:16 greater than chance (50%)

# 1
# H0: mu = .5
# H1: mu > .5

# 2
typeIerr = 0.05

# 3
# mu_hat = xbar ~ Normal(mu_xbar, sig_xbar)
# mu_xbar = mu_x
# sig_xbar = sig_x

# t_obs ~ t(n-1)
# t_obs = (xbar_obs - .5) / sig_xbar_hat
# t_obs = (xbar_obs - .5) / (sig_x_hat / sqrt(n))

# 4
x <- dd[block %in% 1:16, mean_acc]
n <- length(x)
xbar_obs <- mean(x)
sig_x_hat <- sd(x)
t_obs = (xbar_obs - 0.5)/ (sig_x_hat/sqrt(n))

p_val = pt(t_obs, n-1, lower.tail=FALSE)

t <- seq(-4, 4, 0.01)
ft <- dt(t, n-1)
dt <- data.table(t, ft)
ggplot(dt, aes(t, ft)) +
  geom_line()

t.test(x, mu=0.5, alternative='greater')




