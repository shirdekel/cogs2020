library(data.table)
library(ggplot2)
library(stringr)

rm(list=ls())

d <-fread('https://crossley.github.io/cogs2020/data/eeg/epochs.txt')

# The column names that come from this file have spaces
# This line removes those spaces (depends on the `stringr` package)
names(d) <- str_replace_all(names(d), c(" " = "." , "," = "" ))

# Ugh, data wrangling
# x <- d[...]
# y <- d[...]

# Every t-test works the same:

# First, an observed t value is derived from an observed
# test statistic. If you are testing a hypothesis about the
# difference between two means, then you follow the lecture
# notes and define W = X - Y --> mu_W = mu_X - mu_Y, and the
# rest of your t-test proceeds using W. E.g., your test
# statistic in this case would be w_bar = x_bar - y_bar.
t_obs = (test_stat_observed - test_stat_H0) / s_test_stat

# Second, you need to finish defining your observed t value
# by specifying what the standard deviation of your test
# statistic is. As covered in the lecture notes, this will
# depend on the assumptions of the test. For example:

# If X and Y have equal sample sizes and equal variance
sp <- sqrt((varx + vary)/n)

# If X and Y have unequal variance
sp <- sqrt((varx/nx + vary/ny))

# Third, you need to specify the exact t-distribution that
# your observed t value was sampled from. Since t
# distributions are fully specified by a single parameter
# called the degrees of freedom (df), this comes down to
# simply computing the appropriate df. For the examples
# considered above:

# If X and Y have equal sample sizes and equal variance
df = 2*n - 2

# If X and Y have unequal variance
df <- ( (varx/nx + vary/ny)^2 ) / ( ((varx/nx)^2)/(nx-1) + ((vary/ny)^2)/(ny-1) )


# After this point, you have done everything many times
# before, and the steps / logic applied is identical from
# case to case.
t_crit_lower <- qt(0.025, df, lower.tail=TRUE)
t_crit_upper <- qt(0.025, df, lower.tail=FALSE)
w <- (t_crit_upper - t_crit_lower) * sp
ci_lower <- (xbar - ybar) - w/2
ci_upper <- (xbar - ybar) + w/2

p_val_upper <- pt(abs(tobs), df, lower.tail=FALSE)
p_val_lower <- pt(-abs(tobs), df, lower.tail=TRUE)
p_val <- p_val_upper + p_val_lower

if(p_val < 0.05) {
  decision <- 'reject H0'
} else {
  decision <- 'fail to reject H0'
}

r_result <- t.test(x,
                   y,
                   alternative='two.sided',
                   mu=0,
                   paired=FALSE,
                   var.equal=FALSE,
                   conf.level=1 - alph)

# Finally, getting everything into the variables that I have
# requested (e.g., check HW4 general instructions) can be
# annoying, but if you use consistent nomenclature can be
# solved one time and used over and over. In any case, the
# key is in understanding that "theta" corresponds to the
# parameter in step 1, which in this case is mu_W. This means
# that theta_hat corresponds to w_bar. Basically, everything is 
# just in terms of W.

# Create some convenience variables
theta_hat_x <- seq(-4, 4, 0.01) # notice that this is the same for every t-test!
theta_hat_p <- dt(theta_hat_x, n-1) # also note that you can go with t or w here (either earns full points)
theta_hat_obs <- xbar-ybar 
p_val_lower <- p_val_lower
p_val_upper <- p_val_upper
theta_hat_crit_lower <- t_crit_lower * sp
theta_hat_crit_upper <- t_crit_upper * sp
theta_hat_ci_lower <- ci_lower
theta_hat_ci_upper <- ci_upper

# save variables into needed names
prob_4_theta_hat_x <- theta_hat_x
prob_4_theta_hat_p <- theta_hat_p
prob_4_theta_hat_obs <- theta_hat_obs
prob_4_pval_lower <- p_val_lower
prob_4_pval_upper <- p_val_upper
prob_4_theta_hat_crit_lower <- theta_hat_crit_lower
prob_4_theta_hat_crit_upper <- theta_hat_crit_upper
prob_4_ci_lower <- theta_hat_ci_lower
prob_4_ci_upper <- theta_hat_ci_upper
prob_4_decision <- decision
prob_4_r_result <- r_result