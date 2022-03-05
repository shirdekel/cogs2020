library(data.table)

# Create vectors to later store in a data frame
x <- c('I', 'I', 'I', 'II', 'II', 'II', 'III', 'III', 'III', 'IV', 'IV', 'IV')
y <- c('a', 'a', 'b', 'b', 'c', 'c', 'd', 'd', 'e', 'e', 'f', 'f')
z <- rnorm(12)

# create a data table
dt <- data.table(x, y, z)
dt

# data.table syntax [i (selecting rows), 
#                    j (select and operating columns), 
#                    by (how do you want things grouped)]
dt[]

# select rows
dt
dt[1:4]
dt[4:7]
dt[c(2, 5, 11)]
dt[x=='II']
dt[x!='II']
dt[(x=='II') & (y=='c')]
dt[(x=='II') & (y=='c') & (z > 0)]
dt[x=='II'][y=='c'][z > 0]

# select columns
dt[1:4, z]
dt[1:4, list(z)]
dt[1:4, .(z)]

# select and operate on columns
dt[1:4, mean(z)]
dt[1:4, sd(z)]
dt[1:4, list(mean(z), sd(z))]
dt[1:4, list(z_mean = mean(z), z_sd = sd(z))]


# group column operations
dt

# inefficient and tiring way to group by x
dt[x=="I", mean(z)]
dt[x=="II", mean(z)]
dt[x=="III", mean(z)]
dt[x=="IV", mean(z)]

# efficient and beautiful way to group by x
dt
dt[, mean(z), .(x)]
dt[, mean(z), .(x, y)]

# convenient .N keyword
dt[, .N]
dt[, .N, .(x)]

# add / remove columns using the := symbol
dt
# dt <- dt[, newcol] # don't do this
dt[, betsy := 'mouse']
dt[, betsy := c('mouse', 'rat')] # notice the error
new_col_betsy <- rep(c('mouse', 'rat'), 6)
dt[, betsy := new_col_betsy] # add betsy
dt

dt[, betsy := NULL] # remove betsy
dt

# copying data.tables
dt_copy <- dt # shallow copy

dt
dt_copy

dt_copy[, betsy := NULL]
dt_copy
dt

dt_copy = data.table(dt) # deep copy
dt
dt_copy

dt_copy[, z := NULL]
dt
dt_copy

dt_copy = copy(dt) # deep copy
