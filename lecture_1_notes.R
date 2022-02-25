rm(list=ls())

my_name <- "John Doe"
my_student_id <- "12345678"

x <- 2
y <- 3

z <- x / y
print(z)

# vectors
x_vec <- c(1, 2, 3)

# lists
x_lists <- list(1, 2, 3)


# data.frames
x <- c('I', 'I', 'I', 'II', 'II', 'II', 'III', 'III', 'III', 'IV', 'IV', 'IV')
y <- c('a', 'a', 'b', 'b', 'c', 'c', 'd', 'd', 'e', 'e', 'f', 'f')
z <- rnorm(12)
df <- data.frame(x, y, z)


# hw 5 hints
set.seed(0)
generate_experiment_result <- function(sample_size) {
  result <- rnorm(sample_size)
  return(result)
}

experiment_result <- generate_experiment_result(10)

experiment_result_mean <- mean(experiment_result)

critical_value <- 1.5
if(experiment_result_mean > critical_value) {
  experiment_decision <- TRUE
} else {
  experiment_decision <- FALSE
}
