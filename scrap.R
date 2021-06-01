library(data.table)

d <- data.table(x=rnorm(4), y=rnorm(4), z=c(1, 1, 2, 2))

dd <- d[, mean(x), .(z)]

d[, mean_x := mean(x), .(z)]
dd <- d[, unique(mean_x), .(z)]
