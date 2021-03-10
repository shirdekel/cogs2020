library(data.table)
library(ggplot2)

rm(list=ls())

x <- c("A", "A", "A", "B", "B", "B" )
y <- c("I", "I", "II", "II", "III", "III")
z <- rnorm(6)
d <- data.table(x, y, z)

ans_1e <- ggplot(data=d, aes(x=x, y=z)) +
  geom_point()
ans_1e

d[x=="A", mean(z)]
d[x=="B", mean(z)]

dd <- d[, mean(z), .(x, y)]
setnames(dd, "V1", "z")

# shallow copy
d2 <- d

# deep copy
d2 <- data.table(d)

