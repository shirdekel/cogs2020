# Basic setup code that you will need for this problem
library(data.table)
library(ggplot2)
library(stringr)

rm(list=ls())

# basic id info
my_name <- "John Doe"
my_student_id <- "12345678"

# Please include the following line of code as well
set.seed(0)

d <- fread('https://crossley.github.io/cogs2020/data/eeg/epochs.txt')

# The column names that come from this file have spaces
# This line removes those spaces (depends on the `stringr` package)
names(d) <- str_replace_all(names(d), c(" " = "." , "," = "" ))

# Example: 
# Assuming equal variance, is the mean MEG signal greater
# for t<0 than it is for t>0 in channel 65?

x <- d[time < 0, MEG.065]
y <- d[time > 0, MEG.065]

nx <- length(x)
ny <- length(y)

xbar <- mean(x)
ybar <- mean(y)

varx <- var(x)
vary <- var(y)

# independent or paired?
# - independent
# equal n or unequal n?
# - unequal n
# equal var or unequal var
# - what did the instructions say?

s <- sqrt( (((nx-1)*varx + (ny-1)*vary) / (nx + ny - 2)) * (1/nx + 1/ny) )
tobs <- (xbar - ybar) / s
df <- nx + ny - 2
pval <- pt(tobs, df, lower.tail=F)

t.test(x, 
       y,
       alternative='greater',
       mu=0,
       paired=FALSE,
       var.equal=TRUE,
       conf.leve=0.95)


