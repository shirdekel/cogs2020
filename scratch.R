library(data.table)
library(ggplot2)

rm(list=ls())

# X ~ N(mu=7, sig=2)
x <- seq(7 - 6, 7 + 6, 0.01)
fx <- dnorm(x, 7, 2)
d <- data.table(x, fx)
ggplot(d, aes(x, fx)) +
  geom_line()

# P(X > 4)
pnorm(4, 7, 2, lower.tail=F)

# P( >= 4)
pnorm(4, 7, 2, lower.tail=F)

# Y ~ binomial(n=8, p=0.8)

# P(Y <= 2)
pbinom(2, 8, 0.8, lower.tail=TRUE)

# P(Y < 2) = P(Y <= 1)
pbinom(2, 8, 0.8, lower.tail=TRUE)

d1 <- 5
d2 <- 100

# Define the number of experiments to run
n_exp <- 6

# Define the number of samples to draw per experiment
n <- 1000

# Create an empty list. We will later use this list to store
# the results of each experiment
storage_list <- list()

# Run through a for loop and in each iteration of the for
# loop, draw n samples from the random variable X, and store
# the result in the storage list defined just above.
for(i in 1:n_exp) {
  
  # We will use the function `rf()` to draw random samples
  # from X. However, I need you all to work with the same
  # random samples as me (for grading purposes), so we use
  # the `set.seed()` function to ensure that we all get the
  # same "random" numbers.
  set.seed(i)
  
  # Generate a random sample using the `rf()` function
  random_sample <- rf(n, d1, d2)
  
  # we will want things in data.table format later, so might
  # as well get started on it now.
  result <- data.table(exp=i, x=random_sample)
  
  # Store the result in our storage list
  storage_list[[i]] <- result
}

# Storage_list contains a list of data.tables. Each
# data.table in this list has one column named exp (this is
# an indicator column that indicates the experiment from
# which data was obtained) and another named x (this column
# contains the data sampled in each experiment). We next use
# the data.table function `rbindlist()` to combine this list
# of data.tables into a single data.table.
d <- rbindlist(storage_list)

# We now plot histograms to show the results of each
# experiment.
ggplot(d, aes(x)) +
  geom_histogram(bins=50) +
  facet_wrap(~exp)