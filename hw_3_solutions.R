library(data.table)
library(ggplot2)

rm(list=ls())

# 1
p1 <- 1 - pnorm(2, 0, 1, lower.tail=F)
p2 <- pnorm(2, 0, 1, lower.tail=T)
ans_1a <- p1==p2
p1 <- 1 - pbinom(1, 15, 0.5, lower.tail=F)
p2 <- pbinom(2, 15, 0.5, lower.tail=T)
ans_1b <- p1==p2

# 2
mu <- 15
sigma <- 2.74
ans_2a <- pnorm(24.23, mu, sigma, lower.tail=F)
ans_2b <- pnorm(13.54, mu, sigma, lower.tail=T)
ans_2c <- pnorm(10.98, mu, sigma, lower.tail=T)
ans_2d <- pnorm(4.12, mu, sigma, lower.tail=F)
ans_2e <- pnorm(24.55, mu, sigma, lower.tail=T) - pnorm(12.22, mu, sigma, lower.tail=T)
ans_2f <- qnorm(0.9, mu, sigma, lower.tail=F)
ans_2g <- qnorm(0.8, mu, sigma, lower.tail=T)


d1 <- 5
d2 <- 100
mu_x <- (d2/(d2-2))
sig_x <- (2*(d2^2)*(d1+d2-2))/(d1*(d2-2)^2*(d2-4))


# - $N(\mu_{\bar{X}}, \sigma_{\bar{X}})$
# - $\mu_{\bar{X}} = \mu_{X}$
# - $\sigma_{\bar{X}} = \frac{\sigma_{X}}{\sqrt{n}}$
d[, mu_x_bar := mu_x]
d[, sig_x_bar := sig_x / sqrt(n), .(n)]
d[, unique(mu_x_bar - mean(x)), .(n)]
d[, unique(sig_x_bar - sd(x)/sqrt(n)), .(n)]