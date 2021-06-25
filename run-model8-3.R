library(rstan)
rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

d <- read.csv('data-salary-2.txt')
head(d, n=5)

data <- list(
  N=nrow(d),
  K=4,
  X=d$X, 
  Y=d$Y, 
  KID=d$KID
)

fit3 <- stan(
  file='model8-3.stan', 
  data=data, 
  seed=1234
)

fit3

save.image('result-model8-3.RData')
