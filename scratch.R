library(data.table)
library(ggplot2)
library(ez)

rm(list=ls())

d <- fread('https://crossley.github.io/cogs2020/data/mis/mis_data.csv')

d[condition==0, subject := subject + 100]

d[, error, .(subject)]
d[, mean(error), .(subject)]

dd <- d[, .(mean_error = mean(error)), .(condition, subject)]
dd[, subject := as.factor(subject)]
dd[, condition := as.factor(condition)]

ezANOVA(data=dd,
        dv=mean_error,
        wid=subject,
        between=condition,
        type=3)


x <- dd[condition==0, mean_error]
y <- dd[condition==1, mean_error]
t.test(x, y, mu=0, alternative='two.sided')