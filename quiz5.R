library(data.table)
library(ggplot2)
library(ggpubr)

rm(list=ls())

xobs <- 0.65
xcrit <- qunif(0.05, 0, 1, lower.tail=F)
x <- seq(0, 1, 0.001)
fx <- dunif(x, 0, 1)
zone <- 'NA'
d <- data.table(x, fx, zone)
d[x < xobs, zone := 'Fail to Reject H0']
d[x >= xobs & x < xcrit, zone := 'Reject H0']
d[x >= xcrit, zone := 'alpha']
ggplot(d, aes(x, fx)) + 
  geom_line() +
  geom_segment(aes(x=0, xend=0, y=0, yend=1)) +
  geom_segment(aes(x=1, xend=1, y=0, yend=1)) +
  geom_segment(aes(x=xobs, xend=xobs, y=0, yend=1), linetype=2) +
  geom_segment(aes(x=xcrit, xend=xcrit, y=0, yend=1), linetype=2) +
  geom_ribbon(aes(xmin=x, 
                  ymin=0, 
                  ymax=fx, 
                  fill=zone), 
              alpha=0.5) +
  scale_x_continuous(labels=c()) +
  scale_y_continuous(labels=c()) +
  ylab('Probability Density (X=x)') +
  annotate('text', x=xobs,  y=-0.03, label='x observed') +
  annotate('text', x=xcrit,  y=-0.03, label='x critical value') +
  theme(legend.position = 'None')





