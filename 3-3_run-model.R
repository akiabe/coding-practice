library(ggplot2)
library(rstan)
rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

d <- read.csv("3-2-1-beer-sales-2.csv")
head(d, n=5)

ggplot(d, aes(x=temperature, y=sales)) +
  geom_point()

X_pred <- 11:30

data <- list(
  N=nrow(d), 
  X=d$temperature, 
  Y=d$sales,
  N_pred=length(X_pred),
  X_pred=X_pred
)

fit <- stan(
  file='3-3_model.stan',
  data=data,
  seed=1
)

fit

ms <- rstan::extract(fit)
d_qua <- t(apply(
  X=ms$Y_pred,
  MARGIN=2,
  FUN=quantile,
  prob=c(0.025, 0.5, 0.975)
))
colnames(d_qua) <- c('p2.5', 'p50', 'p97.5')
head(d_qua, n=5)

d_qua <- data.frame(X_pred, d_qua)
head(d_qua, n=5)

ggplot(d_qua, aes(x=X_pred, y=p50)) +
  geom_line(aes(y=p50), size=0.9) +
  geom_ribbon(aes(ymin=p2.5, ymax=p97.5), alpha=0.3)
