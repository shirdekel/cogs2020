generate_pdf_continuous <- function() {
  density <- round(runif(4, 3, 100))
  width <- round(runif(4, 3, 100))
  x0 <- round(runif(1, 3, 100))

  x <- c(x0,
         x0 + sum(width[1]),
         x0 + sum(width[1:2]),
         x0 + sum(width[1:3])
         )

  xend <- c(x0 + sum(width[1]),
            x0 + sum(width[1:2]),
            x0 + sum(width[1:3]),
            x0 + sum(width[1:4])
            )

  d <- data.table(x, xend, density)
  d[, total_area := sum(density*(xend-x))]
  d[, density := density / total_area]
  d[, density := round(density, 4)]

  x1 <- d[, x][1]
  x2 <- d[, x][2]
  x3 <- d[, x][3]
  x4 <- d[, x][4]
  x5 <- d[, xend][4]

  y1 <- 0
  y2 <- d[, sort(density)][1]
  y3 <- d[, sort(density)][2]
  y4 <- d[, sort(density)][3]
  y5 <- d[, sort(density)][4]

  g <- ggplot(d) +
    geom_segment(aes(x=x, xend=xend, y=density, yend=density)) +
    geom_segment(aes(x=x[1], xend=x[1], y=0, yend=density[1])) +
    geom_segment(aes(x=x[2], xend=x[2], y=density[1], yend=density[2])) +
    geom_segment(aes(x=x[3], xend=x[3], y=density[2], yend=density[3])) +
    geom_segment(aes(x=x[4], xend=x[4], y=density[3], yend=density[4])) +
    geom_segment(aes(x=xend[4], xend=xend[4], y=0, yend=density[4])) +
    geom_vline(aes(xintercept=x[1]), linetype=2, alpha=0.25, size=0.25) +
    geom_vline(aes(xintercept=xend), linetype=2, alpha=0.25, size=0.25) +
    geom_hline(aes(yintercept=density), linetype=2, alpha=0.25, size=0.25) +
    scale_x_continuous(breaks=c(d[, x][1], d[, xend][1:5])) +
    scale_y_continuous(breaks=c(0, d[, sort(density)]),
                       limits=c(0, d[, max(density)])) +
    xlab(TeX('$x$')) +
    ylab(TeX('Probability Density $f(X=x)$')) +
    ggtitle(TeX('Probability Density for the random variable $X$')) +
    theme_classic()

  return(list(g, d))
}


generate_pdf_discrete <- function() {
  mass <- round(runif(4, 3, 100))
  x <- round(sort(runif(4, 3, 100)))

  d <- data.table(x, mass)
  d[, total_mass := sum(mass)]
  d[, mass := mass / total_mass]
  d[, mass := round(mass, 4)]

  x1 <- d[, x][1]
  x2 <- d[, x][2]
  x3 <- d[, x][3]
  x4 <- d[, x][4]

  y1 <- d[, sort(mass)][1]
  y2 <- d[, sort(mass)][2]
  y3 <- d[, sort(mass)][3]
  y4 <- d[, sort(mass)][4]

  g <- ggplot(d) +
    geom_segment(aes(x=x, xend=x, y=0, yend=mass)) +
    geom_hline(aes(yintercept=mass), linetype=2, alpha=0.25, size=0.25) +
    geom_hline(aes(yintercept=0), linetype=2, alpha=0.25, size=0.25) +
    scale_x_continuous(breaks=c(d[, sort(x)])) +
    scale_y_continuous(breaks=c(0, d[, sort(mass)]),
                       limits=c(0, d[, max(mass)])) +
    xlab(TeX('x')) +
    ylab(TeX('Probability $P(X=x)$')) +
    ggtitle(TeX('Probability mass for the random variable $X$')) +
    theme_classic()

  return(list(g, d))
}


generate_cdf_discrete <- function() {
  probability <- sort(round(runif(4, 3, 100)))
  width <- round(runif(4, 3, 100))
  x0 <- round(runif(1, 3, 100))

  x <- c(x0,
         x0 + sum(width[1]),
         x0 + sum(width[1:2]),
         x0 + sum(width[1:3])
         )

  xend <- c(x0 + sum(width[1]),
            x0 + sum(width[1:2]),
            x0 + sum(width[1:3]),
            x0 + sum(width[1:4])
            )

  d <- data.table(x, xend, probability)

  d[, total_probability := sum(probability)]
  d[, probability := probability / total_probability]
  d[, probability := round(probability, 4)]
  
  d[, probability := cumsum(probability)]

  x1 <- d[, x][1]
  x2 <- d[, x][2]
  x3 <- d[, x][3]
  x4 <- d[, x][4]
  x5 <- d[, xend][4]

  y1 <- 0
  y2 <- d[, sort(probability)][1]
  y3 <- d[, sort(probability)][2]
  y4 <- d[, sort(probability)][3]
  y5 <- d[, sort(probability)][4]

  g <- ggplot(d) +
    geom_point(aes(x=x, y=probability)) +
    geom_segment(aes(x=x, xend=xend, y=probability, yend=probability)) +
    ## geom_segment(aes(x=x[1], xend=x[1], y=0, yend=probability[1])) +
    ## geom_segment(aes(x=x[2], xend=x[2], y=probability[1], yend=probability[2])) +
    ## geom_segment(aes(x=x[3], xend=x[3], y=probability[2], yend=probability[3])) +
    ## geom_segment(aes(x=x[4], xend=x[4], y=probability[3], yend=probability[4])) +
    ## geom_segment(aes(x=xend[4], xend=xend[4], y=0, yend=probability[4])) +
    geom_vline(aes(xintercept=x[1]), linetype=2, alpha=0.25, size=0.25) +
    geom_vline(aes(xintercept=xend), linetype=2, alpha=0.25, size=0.25) +
    geom_hline(aes(yintercept=probability), linetype=2, alpha=0.25, size=0.25) +
    scale_x_continuous(breaks=c(d[, x][1], d[, xend][1:3])) +
    scale_y_continuous(breaks=c(0, d[, sort(probability)]),
                       limits=c(0, d[, max(probability)])) +
    xlab(TeX('$x$')) +
    ylab(TeX('$P(X < x)$')) +
    ggtitle(TeX('Cumulative Probability for the random variable $X$')) +
    theme_classic()

  return(list(g, d))
}
