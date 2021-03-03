library(data.table)
library(ggplot2)

rm(list=ls())

x1 <- c(52.38, 55.41, 70.88, 43.30, 50.15, 41.99, 36.82, 34.05, 52.70, 72.25)
x2 <- c(62.36, 53.89, 53.95, 33.81, 61.12, 61.48, 36.89, 49.45, 52.50, 50.95)
x3 <- c(52.04, 48.28, 48.12, 58.89, 51.76, 42.88, 49.04, 60.41, 53.99, 70.06)

d_wide <- data.table(x1, x2, x3)

d_long = melt(d_wide, 
              measure.vars=c('x1', 'x2', 'x3'),
              variable.name = 'experiment_id',
              value.name = 'time')

ggplot(data=d_long, mapping=aes(x=experiment_id, y=time)) +
  geom_point()
  

ggplot(data=d_long, mapping=aes(x=experiment_id, y=time)) +
  geom_boxplot() +
  geom_point()



ggplot(data=d_long, aes(x=time, fill=experiment_id)) +
  geom_histogram(bins = 5) +
  facet_wrap(~experiment_id)


d_mean = d_long[, mean(time), .(experiment_id)]
setnames(d_mean, "V1", "time")

d_mean = d_long[, .(time = mean(time)), .(experiment_id)]

ggplot(data=d_mean, aes(x=experiment_id, y=time)) +
  geom_bar(stat='identity')

ggplot(data=d_mean, aes(x=experiment_id, y=time)) +
  geom_bar(stat='identity')