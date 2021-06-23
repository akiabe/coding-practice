library(ggplot2)
library(rstan)
rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

d <- read.csv('data-salary-2.txt')

data <- list(
  N=nrow(d), 
  X=d$X, 
  Y=d$Y, 
  KID=d$KID
)

fit <- stan(
  file='model8-1.stan', 
  data=data, 
  seed=1234
)

fit

#save.image('result-model8-1.RData')

ms <- rstan::extract(fit)
d_qua <- t(apply(
  X=ms$mu,
  MARGIN=2,
  FUN=quantile,
  prob=c(0.025, 0.5, 0.975)
))
colnames(d_qua) <- c('p2.5', 'p50', 'p97.5')
head(d_qua, n=5)

d_qua <- data.frame(d, d_qua)
head(d_qua, n=5)

ggplot(d_qua, aes(x=X, y=Y)) +
  geom_point(alpha=0.6, size=0.9) +
  geom_line(aes(y=p50), size=0.9) +
  geom_ribbon(aes(ymin=p2.5, ymax=p97.5), alpha=0.3)
