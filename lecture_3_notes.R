library(data.table)
rm(list=ls())

# basic id info
my_name <- "John Doe"
my_student_id <- "12345678"

# Please include the following line of code as well
set.seed(0)

# create vectors from which to build d
V1 <- rep(month.abb[1:8], each=2)
V2 <- rep(letters[1:8], 2)
V3 <- rnorm(length(V1))

# create a data.table named d
d <- data.table(month=V1, event=V2, obs=V3)

ans_3a <- d[, .(obs_mean = mean(obs), 
                obs_sd = sd(obs)), .(event)]

# setnames(ans_3a, 'V1', 'obs_mean')



ans_1a <- data.table(die1=c(1, 2, 3), die2=c(1, 1, 1))

ans_2a <- data.table(ans_1a)
ans_2a[, x := die1 + x]

ans_2a[, .(y = x+1)]




# define example data
x1 <- runif(5)
x2 <- runif(5)
x3 <- runif(5)

# create a wide format data.table
d_wide <- data.table(x1, x2, x3)

# convert to a long format data.table
d_long <- melt(d_wide, measure.vars=c('x1', 'x2', 'x3'), variable.name='subject', value.name='obs')

# d_wide_2 <- 
dcast(d_long,  obs ~ subject)

d_wide
w_wide_2





x1 <- runif(100)
x2 <- runif(100)
x3 <- runif(100)

# create a wide format data.table
d_wide <- data.table(x1, x2, x3)

# convert to a long format data.table
d_long <- melt(d_wide, measure.vars=c('x1', 'x2', 'x3'))

library(ggplot2)

ggplot(data=d_long, aes(x=variable, y=value)) +
  geom_point()

ggplot(data=d_long) +
  geom_boxplot(aes(x=variable, y=value)) + 
  geom_point(aes(x=variable, y=value))

ggplot(data=d_long, aes(x=variable, y=value)) +
  geom_violin()




d <- fread('https://crossley.github.io/cogs2020/data/criterion_learning/crit_learn.csv')
