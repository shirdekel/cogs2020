library(data.table)
library(ggplot2)
library(ggpubr)

p <- seq(0,0.99,0.01)
qf <- qpois(p, 4, lower.tail=TRUE)
d <- data.table(p, qf)
g1 <- ggplot(d, aes(x=p, y=qf)) +
  geom_point() +
  scale_y_continuous(breaks=qf) +
  xlab('P(X <= x)') +
  ylab('x') +
  geom_vline(xintercept=0.5, linetype=2)

x <- seq(0,10,1)
pf <- ppois(x, 4, lower.tail=TRUE)
d <- data.table(x, pf)
g2 <- ggplot(d, aes(x=x, y=pf)) +
  geom_point() +
  scale_y_continuous(breaks=qf) +
  ylab('P(X <= x)') +
  xlab('x')

ggarrange(g1, g2)