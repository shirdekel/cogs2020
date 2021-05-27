library(data.table)
library(ggplot2)
library(EnvStats)

rm(list=ls())

my_name <- "ENTER YOUR NAME HERE AS A STRING"
my_student_id <-"ENTER YOUR STUDENT ID AS A STRING"

# replace 314159 with your student id number AS AN INTEGER 
id_as_integer <- 314159

set.seed(id_as_integer)
offset <- runif(1, min=-100, max=100)
x <- 1:17 + offset * 0
fx <- c(1:9, 8:1)
fx <- fx / sum(fx)
x <- x - 9
d <- data.table(x, fx)
x_obs <- sample(x, 1)
ggplot(d, aes(x, fx)) + 
  geom_point() +
  geom_segment(aes(x=, xend=x, y=0, yend=fx)) +
  geom_vline(xintercept=x_obs, linetype=2, colour='red') +
  scale_x_continuous(breaks=x,
                     minor_breaks=F) +
  scale_y_continuous(breaks=fx,
                     minor_breaks=F,
                     limits=c(0, max(fx))) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))

# p-value is the probabililty of x_obs + more extreme outcomes
# x_obs is -7, therefore:
p_val <- 2 * (0.01234568 + 0.02469136)

# critical value is the value that puts 0.025 in each tail /
# rejection region
# P(-8) + P(-7) exceeds alpha / 2 so we are stuck with -8
crit_lower_1 <- -8
crit_upper_1 <- 8 # because crit values are symmetric around the mean

w <- crit_upper_1 - crit_lower_1

ci_lower <- x_obs - w/2
ci_upper <- x_obs + w/2

