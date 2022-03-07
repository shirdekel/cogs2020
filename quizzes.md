## quiz 1

What are descriptive statistics?
a. Visualising the data and computing summary statistics like means and standard deviations.
b. Using Null Hypothesis Significance Testing (NHST) to make a decision on the basis of observed data.
c. The processes that generate random outcomes of an experiment.
d. A single outcome or set of outcomes from an experiment.

What are inferential statistics?
a. Visualising the data and computing summary statistics like means and standard deviations.
b. Using Null Hypothesis Significance Testing (NHST) to make a decision on the basis of observed data.
c. The processes that generate random outcomes of an experiment.
d. A single outcome or set of outcomes from an experiment.

What are random variables?
a. Visualising the data and computing summary statistics like means and standard deviations.
b. Using Null Hypothesis Significance Testing (NHST) to make a decision on the basis of observed data.
c. The processes that generate random outcomes of an experiment.
d. A single outcome or set of outcomes from an experiment.

What is a sample?
a. Visualising the data and computing summary statistics like means and standard deviations.
b. Using Null Hypothesis Significance Testing (NHST) to make a decision on the basis of observed data.
c. The processes that generate random outcomes of an experiment.
d. A single outcome or set of outcomes from an experiment.

Which of the following creates a "numeric" variable in R?
x <- 11
x <- as.integer(11)
x <- "q"
x <- TRUE

Which of the following creates a "integer" variable in R?
x <- 11
x <- as.integer(11)
x <- "q"
x <- TRUE

Which of the following creates a "character" variable in R?
x <- 11
x <- as.integer(11)
x <- "q"
x <- TRUE

Which of the following creates a "logical" variable in R?
x <- 11
x <- as.integer(11)
x <- "q"
x <- TRUE

If `x` is a vector, which of the following lines of code returns its 3rd element?
x(3)
x[3]
tmp <- x[[3]


## quiz 2
Understand the relationship between a sample and a
population.

Understand the relationship between a population and a
random variable.

Understand what a random sample is and what is means for a
sample to be biased.

Understand the relationship between descriptive and
inferential statistics.

Understand the difference between continuous and discrete
observations.

- Is the sample x=(1, 2, 2, 5, 9, 4) composed of continuous
  or discrete observations?

- Is the sample x=(1.43, 2.98, 2.48, 5.89, 9.08, 4.78)
  composed of continuous or discrete observations?


Understand what it means for an experiment design to be
between-subjects or within-subjects.

Understand what it means for an experiment design to be
repeated measures.

- Consider the following data.table representing the
  outcomes of an experiment. The `subject` column indicates
  the participant from which a row of data (i.e., a single
  observation) was obtained. The `condition` column
  indicates the experiment conditions under which that row
  of data was acquired.
  
  Is this experiment a within-subjects or between-subjects design?

  Is this experiment a repeated-measures design?

    subject condition observation
  1:       1         1           7
  2:       1         2           3
  3:       1         3           3
  4:       2         1           9
  5:       2         2           6
  6:       2         3           7

    subject condition observation
  1:       1         1           7
  2:       2         2           3
  3:       3         3           3
  4:       4         1           9
  5:       5         2           6
  6:       6         3           7


Understand conceptually and be able to compute by hand and
using R the following descriptive statistics:

sample mean
sample median
sample mode
sample variance
sample standard deviation
sample range

Understand and be able to read common plots used to
communicate descriptive statistics including scatter plots,
bar plots, box plots, histograms, and violin plots.

Understand how to install and load libraries in R.

- To install the `data.table` library, it is necessary to
  include a line of code in your problem set scripts that
  reads `install.packages(data.table)`.
  
  True / False

Understand the basics of working with the data.table package
in R.

- Consider the following `data.table` named `d`:

    ID a  b  c
  1:  b 1  7 13
  2:  b 2  8 14
  3:  b 3  9 15
  4:  a 4 10 16
  5:  a 5 11 17
  6:  c 6 12 18

  Which of the following lines of code produces the
  following output?

    ID b_mean c_mean
  1:  b      8     14
  2:  a     10     16

  `d[a < 5, .(b_mean=mean(b), c_mean=mean(c)), .(ID)]`
  `d[ID == 'b', .(b_mean=mean(b), c_mean=mean(c)), .(ID)]`
  `d[ID != 'c', .(b_mean=mean(b), c_mean=mean(c)), .(ID)]`
  
  
  <code> d[a &lt; 5, .(b_mean=mean(b), c_mean=mean(c)), .(ID)] </code>
  <code> d[ID == 'b', .(b_mean=mean(b), c_mean=mean(c)), .(ID)] </code>
  <code> d[ID != 'c', .(b_mean=mean(b), c_mean=mean(c)), .(ID)] </code>
