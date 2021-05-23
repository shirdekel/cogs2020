library(data.table)
library(ggplot2)

rm(list=ls())

# 1
# a 
d <- fread('https://crossley.github.io/cogs2020/data/nhp_cat_learn/ii_gabor.csv')

# b
col_names <- c('cat', 'x', 'y', 'resp', 'rt', 'phase')
setnames(d, col_names)

# c
d[, trial := 1:.N]

# d
n_trials <- d[, .N]
block_size = 100
n_blocks <- n_trials / block_size + 1
block <- rep(1:n_blocks, each=block_size)
block <- block[1:n_trials]
d[, block := block]

# e
d[, acc := cat == resp]

# f
dd <- d[, .(acc_mean=mean(acc), acc_err=sd(acc) / sqrt(.N)), .(block, phase)]

# g
g <- ggplot(dd, aes(block, acc_mean, colour=factor(phase))) + 
  geom_line() +
  geom_pointrange(aes(x=block, 
                      ymin=acc_mean-acc_err, 
                      ymax=acc_mean+acc_err))




# Problem 5
d2 <- copy(d)
n_trials <- d2[, .N]
block_size = 25
n_blocks <- n_trials / block_size + 1
block2 <- rep(1:n_blocks, each=block_size)
block2 <- block[1:n_trials]
d2[, block := block2]

d2[, acc_mean := mean(acc), .(phase, block)]

dd2 <- d2[, .(acc_mean = mean(acc), acc_err = sd(acc) / sqrt(.N)), .(phase, block)]

