library(rstan)

d <- read.csv('data-salary-2.txt')
head(d, n=5)

N <- nrow(d)
K <- 4

data <- list(
  N=N, 
  K=K, 
  X=d$X, 
  Y=d$Y, 
  KID=d$KID
)

fit4 <- stan(
  file='model8-4.stan', 
  data=data, 
  seed=1234
)

fit4

save.image('result-model8-4.RData')
