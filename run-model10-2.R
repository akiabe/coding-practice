library(rstan)

d <- read.csv(file='data-category.txt')

d$Age <- d$Age/100
d$Income <- d$Income/1000
X <- cbind(1, d[,-ncol(d)])

data <- list(
  N=nrow(d), 
  D=ncol(X), 
  K=6, 
  X=X, 
  Y=d$Y
)

fit <- stan(
  file='model10-2.stan', 
  data=data, 
  seed=1234
)

fit

save.image('result-model10-2.RData')
