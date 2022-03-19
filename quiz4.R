library(data.table)
library(ggplot2)
library(ggpubr)

rm(list=ls())

n <- 10
p <- 0.2
x <- seq(0, n, 1)
pfx <- dbinom(x, n, p)
cfx <- pbinom(x, n, p)
qfx <- qbinom(cfx, n, p)
dx <- data.table(x, pfx, cfx, qfx)
dx[, rv := 'Binomial']
g1 <- ggplot(dx, aes(x, pfx)) +
        geom_point() +
        ylab('Probability P(X=x)')

n <- 10
p <- 0.8
x <- seq(0, n, 1)
pfx <- dbinom(x, n, p)
cfx <- pbinom(x, n, p)
qfx <- qbinom(cfx, n, p)
dx <- data.table(x, pfx, cfx, qfx)
dx[, rv := 'Binomial']
g2 <- ggplot(dx, aes(x, pfx)) +
        geom_point() +
        ylab('Probability P(X=x)')

mu <- 10
sig <- 0.1
x <- seq(mu-sig*4, mu+sig*4, 0.001)
pfx <- dnorm(x, mu, sig)
cfx <- pnorm(x, mu, sig)
qfx <- qnorm(cfx, mu, sig)
dx <- data.table(x, pfx, cfx, qfx)
dx[, rv := 'Normal']
g3 <- ggplot(dx, aes(x, pfx)) +
        geom_line() +
        ylab('Probability Density (X=x)') +
        xlim(9.6, 10.4)

mu <- 10
sig <- 0.05
x <- seq(mu-sig*4, mu+sig*4, 0.001)
pfx <- dnorm(x, mu, sig)
cfx <- pnorm(x, mu, sig)
qfx <- qnorm(cfx, mu, sig)
dx <- data.table(x, pfx, cfx, qfx)
dx[, rv := 'Normal']
g4 <- ggplot(dx, aes(x, pfx)) +
        geom_line() +
        ylab('Probability Density (X=x)') +
        xlim(9.6, 10.4)

ggarrange(g1, g2, g3, g4, nrow=2, ncol=2, labels=c('A', 'B', 'C', 'D'))
ggsave('img/quiz4_1.png')


mu <- 10
sig <- 0.05
x <- seq(mu-sig*4, mu+sig*4, 0.001)
p <- seq(0, 1, 0.001)
pfx <- dnorm(x, mu, sig)
cfx <- pnorm(x, mu, sig)
qfx <- qnorm(p, mu, sig)
dx <- data.table(x, p, pfx, cfx, qfx)
dx[, rv := 'Normal']
g5 <- ggplot(dx, aes(x, pfx)) +
  geom_line() +
  ylab('Probability Density (X=x)')

g6 <- ggplot(dx, aes(x, cfx)) +
  geom_line() +
  ylab('P(X<=x)')

g7 <- ggplot(dx, aes(p, qfx)) +
  geom_line() +
  ylab('x') +
  xlab('P(X<=x)')

dxr <- data.table(x=rnorm(500, 10, 0.05))
g8 <- ggplot(dxr, aes(x)) +
  geom_histogram()

ggarrange(g5, g6, g7, g8, nrow=2, ncol=2, labels=c('A', 'B', 'C', 'D'))
ggsave('img/quiz4_2.png')

g5
ggsave('img/quiz4_3.png')

g6
ggsave('img/quiz4_4.png')

g7
ggsave('img/quiz4_5.png')

g8
ggsave('img/quiz4_6.png')




n <- 30
p <- 0.5
x <- seq(0, n, 1)
px <- seq(0, 1, 0.001)
pfx <- dbinom(x, n, p)
cfx <- pbinom(x, n, p)
qfx <- qbinom(px, n, p)
dx <- data.table(x, px, pfx, cfx, qfx)
dx[, rv := 'Binomial']

g9 <- ggplot(dx, aes(x, pfx)) +
  geom_point() +
  ylab('Probability Mass (X=x)')

g10 <- ggplot(dx, aes(x, cfx)) +
  geom_point() +
  ylab('P(X<=x)')

g11 <- ggplot(dx, aes(px, qfx)) +
  geom_point() +
  ylab('x') +
  xlab('P(X<=x)')

g9
ggsave('img/quiz4_9.png')

g10
ggsave('img/quiz4_10.png')

g11
ggsave('img/quiz4_11.png')



