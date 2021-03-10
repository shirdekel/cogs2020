# install.packages() is like installing software for the first time
# you only need to install a library one time (ever) unless something
# happens to your computer.

# NOTE: Please do not include install.packages() in your
# homework script.

# library() is like opening a program that's already installed
library(data.table)
library(ggplot2)

# ls() is function that lists all things in your current session
# rm() is a function that removes the things that you list
rm(list = ls())

# NOTE: In the HW we used the fread() function to get a
# data.table from a file

# Here, we create a toy data.table that's easy to understand
x <- c("A", "A", "A", "B", "B", "B")
y <- c("I", "I", "II", "II", "III", "III")
# z <- c(1, 2, 3, 4, 5, 6)
z <- 1:6
d <- data.table(x, y, z)


# Select rows (with logical indexing)
d[x=="A" | y=="II"]


# operating on columns with group by
dd <- d[, mean(z), .(x, y)]
setnames(dd, "V1", "z")

# Add, modify, remove columns with the := symbol
d[, zz := 1:6]
d[, zz := zz + 4]
d[, zz := NULL]

# careful when copying data.tables (use data.table() to make a deep copy)
d2 <- d # makes a shallow copy (still just one data.table but now with two names)
d2 <- data.table(d)

# ggplot notes
# If you save ggplot() result to a variable (a good thing)
# it won't display the figure. To display, just type the variable
# name after you've defined it.
ans <- ggplot(data=d, aes(x=x, y=z)) +
  geom_point()
ans


# Use the as.factor() function to convert an existing object
# of any type into a factor type
d[, x := as.factor(x)]


# Convert a wide data.table into a long data.table with the
# melt() function
d_wide <- data.table(indicate = c("A", "A", "B", "B", "C"), x1 = rnorm(5), x2 = rnorm(5), x3 = rnorm(5) )

d_long <- melt(d_wide, id.vars=c("indicate"), measure.vars=c("x1"))



MEG <- fread('https://crossley.github.io/cogs2020/data/eeg/epochs.txt')
ans_4a <- MEG [, V1 := NULL]
ans_4a$condition <- as.factor(ans_4a$condition)
ans_4b <- melt(ans_4a, id.vars=c("time", "epoch", "condition"))
ans_4c <- ans_4b [variable == 'MEG 001', ]
ans_4d <- ans_4c [,. (value = mean (value)), by=. (condition,time)]
setnames(ans_4d,'V1', 'mean value', skip_absent=TRUE)
ans_4e <- ggplot (ans_4d, aes(x = time, y = value, colour = condition))+
  geom_line()
ans_4e
