library(rstan)

d <- read.csv(file='data-attendance-2.txt')
head(d, n=5)

data <- list(
  N=nrow(d), 
  A=d$A, 
  Score=d$Score/200, 
  M=d$M
)

fit <- stan(
  file='model5-6.stan', 
  data=data, 
  seed=1234
)

fit

save.image('result-model5-6.RData')
