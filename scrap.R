library(data.table)

x <- rnorm(10)
n <- length(x)
df <- n-1

xobs <- mean(x)

crit_val <- qt(0.025, df, lower.tail=T)
crit_val <- qt(0.025, df, lower.tail=F)

