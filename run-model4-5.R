library(rstan)

d <- read.csv(file='data-salary.txt')
head(d, n=5)

data <- list(
  N=nrow(d), 
  X=d$X, 
  Y=d$Y
)

data

fit <- stan(
  file='model4-5.stan', 
  data=data, 
  seed=1234
)

fit

save.image(file='result-model4-5.RData')

