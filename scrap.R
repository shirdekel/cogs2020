library(data.table)
library(ggplot2)
library(ez)

rm(list=ls())

my_name <- "Georgia McFarland"
my_student_id <- "45344361"

##             y treatment dose
##  1: 16.314771         A    1
##  2:  8.368833         A    1
##  3: 16.648996         A    1
##  4: 16.362147         A    1
##  5: 32.073207         A    2
##  6: 22.300250         A    2
##  7: 25.357165         A    2
##  8: 28.526398         A    2
##  9: 39.971164         B    1
## 10: 52.023267         B    1
## 11: 43.817967         B    1
## 12: 36.004954         B    1
## 13: 14.261715         B    2
## 14: 18.552692         B    2
## 15: 18.503924         B    2
## 16: 17.942446         B    2
## 17: 41.261117         C    1
## 18: 35.540394         C    1
## 19: 42.178416         C    1
## 20: 33.812308         C    1
## 21: 18.878661         C    2
## 22: 21.886978         C    2
## 23: 20.666682         C    2
## 24: 24.020948         C    2
##             y treatment dose

y <- c(16.314771, 8.368833, 16.648996, 16.362147, 32.073207, 22.300250,
       25.357165, 28.526398, 39.971164, 52.023267, 43.817967, 36.004954,14.261715, 
       18.552692, 18.503924,17.942446, 41.261117, 35.540394, 42.178416, 33.812308, 
       18.878661, 21.886978,20.666682, 24.020948)

treatment <- c( "A", "A", "A", "A", "A", "A", "A", "A",
                "B", "B",  "B", "B", "B", "B", "B", "B",
                "C", "C", "C", "C", "C", "C", "C", "C")

dose <- c( 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 2)

d <- data.table(y=y, 
                treatment=as.factor(treatment), 
                dose=as.factor(dose))

dd <- d[, .(mean(y), sd(y)/sqrt(.N)), .(treatment, dose)]
ggplot(dd, aes(treatment, V1, colour=dose)) +
  geom_pointrange(aes(ymin=V1-V2, ymax=V1+V2))

n_treatment <- d[, length(unique(treatment))] # number of treatment levels
n_dose <- d[, length(unique(dose))] # number of dose levels
n <- d[, .N, .(treatment, dose)][, unique(N)] # number of observations at each level

## define Df terms
df_treatment <- n_treatment - 1
df_dose <- n_dose - 1
df_interaction <- df_treatment * df_dose
df_error <- d[, .N] - n_treatment*n_dose

## Define SS terms
ss_treatment <- 0
for(i in d[, unique(treatment)]) {
  ss_treatment <- ss_treatment + (d[treatment==i, mean(y)] - d[, mean(y)])^2
}
ss_treatment <- n_dose * n * ss_treatment

ss_dose <- 0
for(i in d[, unique(dose)]) {
  ss_dose <- ss_dose + (d[dose==i, mean(y)] - d[, mean(y)])^2
}
ss_dose <- n_treatment * n * ss_dose

ss_interaction <- 0
for(i in d[, unique(treatment)]) {
  for(j in d[, unique(dose)]) {
    ss_interaction <- ss_interaction +
      (d[treatment==i & dose==j, mean(y)] -
         (d[treatment==i, mean(y)] + d[dose==j, mean(y)] - d[, mean(y)]))^2
  }
}
ss_interaction <- n * ss_interaction

ss_error <- 0
for(i in d[, unique(treatment)]) {
  for(j in d[, unique(dose)]) {
    for(k in 1:n) {
      ss_error <- ss_error + (d[treatment==i & dose==j][k, y] -
                                d[treatment==i & dose==j, mean(y)])^2
    }
  }
}
ss_error <- ss_error

## Define MS terms
ms_treatment <- ss_treatment / df_treatment
ms_dose <- ss_dose / df_dose
ms_interaction <- ss_interaction / df_interaction
ms_error <- ss_error / df_error

## Define F terms
f_treatment <- ms_treatment / ms_error
f_dose <- ms_dose / ms_error
f_interaction <- ms_interaction / ms_error

## Define Pr(>F)
p_treatment <- pf(f_treatment, df_treatment, df_error, lower.tail=F)
p_dose <- pf(f_dose, df_dose, df_error, lower.tail=F)
p_interaction <- pf(f_interaction, df_interaction, df_error, lower.tail=F)


## Verify results
fm <- lm(y ~ treatment*dose, data=d)
anova(fm)

d[, subject := 1:.N]
ezANOVA(data=d,
        dv=y,
        wid=subject,
        between=.(treatment, dose),
        type=3)
# Please compute the following by hand as demonstrated in the lecture notes

# Values corresponding to the main effect of treatment
prob_1_theta_hat_obs_treatment <- theta_hat_obs_treatment # observed value of test statistic
prob_1_pval_treatment <- p_val_treatment # p-value of observed test statistic
prob_1_theta_hat_crit_treatment <- theta_hat_crit_treatment # critical value of test statistic

# Values corresponding to the main effect of dose 
prob_1_theta_hat_obs_dose <- theta_hat_obs_dose
prob_1_pval_dose <- p_val_dose
prob_1_theta_hat_crit_dose <- theta_hat_crit_dose

# Values corresponding to the interaction of treatment and dose
prob_1_theta_hat_obs_interaction <- theta_hat_obs_interaction
prob_1_pval_interaction <- p_val_interaction
prob_1_theta_hat_crit_interaction <- theta_hat_crit_interaction

# the result of ezANOVA() containing information about both
# main effects and their interaction.
prob_1_r_result <- r_result 