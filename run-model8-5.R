library(rstan)

d <- read.csv('data-salary-3.txt')
head(d, n=5)
tail(d, n=5)

N <- nrow(d)
K <- 30
G <- 3
K2G <- unique(d[ , c('KID','GID')])$GID

data5 <- list(
  N=N, 
  G=G, 
  K=K, 
  X=d$X, 
  Y=d$Y, 
  KID=d$KID, 
  K2G=K2G
)

fit5 <- stan(
  file='model8-5.stan', 
  data=data5, 
  seed=12345
)

fit5

save.image('result-model8-5.RData')
