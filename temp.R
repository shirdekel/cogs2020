library(data.table)
library(ggplot2)
library(ez)
library(EnvStats)

rm(list=ls())

# Replace Jane Doe with your name as a STRING
my_name <- "Jane Doe"

# Replace 314159 with your student id number as a STRING
my_student_id <-"314159"

part_1_ans_1a <- 'F observed 2 corresponds to panel A, and F observed 1 corresponds panel B'
part_1_ans_1b <- 'F observed 2 corresponds to panel A, and F observed 1 corresponds panel B'

obs <- c(1, 8, 11, 3, 6, 7, 7, 8, 16, 10, 15, 18)
subject <- c(2, 1, 3, 3, 1, 2, 5, 4, 6, 5, 6, 4)
x <- c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2)
y <- c(1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2)

d <- data.table(obs, subject, x, y)
d[, subject := factor(subject)]
d[, x := factor(x)]
d[, y := factor(y)]

ezANOVA(data=d,
        dv=obs,
        wid=subject,
        within=y,
        between=x,
        type=3)


pop_var <- 120.2546606
x_bar_obs <- 13.62551 
part_1_ans_3a <- x_bar_obs

mu_x_bar <- 0
sig_x_bar <- pop_var / sqrt(30)
part_1_ans_3b <- 2 * pnorm(x_bar_obs, mu_x_bar, sig_x_bar, lower.tail=F)



part_1_p_type_I <- 0.05
part_1_confidence <- 1 - part_1_p_type_I
# part_1_p_type_II <- w1*h1 + w2*h2
# part_1_power <- 1 - part_1_p_type_II


d <- fread('https://crossley.github.io/cogs2020/data/switch_cat_learn/switch_data.csv') 

part_2_ans_1 <- "between-subject"
part_2_ans_2 <- "within-subject"

d[, acc := cat==resp]
dd <- d[, mean(acc), .(subject, condition, phase, block, cue)]
ddd <- dd[, .(mean(V1), sd(V1)/sqrt(.N)), .(condition, phase, block, cue)]
ggplot(ddd, aes(block, V1, colour=factor(cue), linetype=factor(condition))) +
  geom_line() +
  geom_pointrange(aes(x=block, ymin=V1-V2, ymax=V1+V2)) +
  facet_wrap(~phase, nrow=1)

dd <- d[phase==1, mean(acc), .(subject, condition, block)]
dd[, condition := factor(condition)]
dd[, block := factor(block)]
dd[, subject := factor(subject)]
part_2_ans_4 <- ezANOVA(data=dd, 
                        dv=V1,
                        wid=subject,
                        within=block,
                        between=condition,
                        type=3)

part_2_ans_5 <- "data is unbalanced"
part_2_ans_6 <- "It does matter"


dd <- d[phase==3, mean(acc), .(subject, cue)]
x <- dd[cue==1, V1]
y <- dd[cue==2, V1]
part_2_ans_7 <- t.test(x, y, paired=T)

