library(rstan)

d <- read.csv('data-salary-3.txt')
N <- nrow(d)
K <- 30
G <- 3
K2G <- unique(d[ , c('KID','GID')])$GID

data6 <- list(
  N=N, 
  G=G, 
  K=K, 
  X=d$X, 
  Y=d$Y, 
  KID=d$KID, 
  GID=d$GID, 
  K2G=K2G
)

fit6 <- stan(
  file='model8-6.stan', 
  data=data6, 
  seed=12345
)

fit6

save.image('result-model8-6.RData')
