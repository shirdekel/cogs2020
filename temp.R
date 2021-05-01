library(data.table)
library(ggplot2)

rm(list=ls())

ggplot(d, aes(x, y)) +
  geom_line() +
  facet_wrap()