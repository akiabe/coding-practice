library(rstan)

d <- read.csv(file='data-attendance-3.txt')
head(d, n=5)

conv <- c(0, 0.2, 1)
names(conv) <- c('A', 'B', 'C')

data <- list(
  I=nrow(d), 
  A=d$A, 
  Score=d$Score/200, 
  W=conv[d$Weather], 
  Y=d$Y
)

fit <- stan(
  file='model5-5.stan', 
  data=data, 
  seed=1234
)

# fit <- stan(file='model/model5-5b.stan', data=data, seed=1234)

save.image('result-model5-5.RData')
