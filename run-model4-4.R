library(rstan)
library(ggplot2)

d <- read.csv(file='data-salary.txt')
head(d, n=5)

X_new <- 23:60

data <- list(
  N=nrow(d), 
  X=d$X, 
  Y=d$Y, 
  N_new=length(X_new), 
  X_new=X_new
)

fit <- stan(
  file='model4-4.stan', 
  data=data, 
  seed=1234
)

fit

ms <- rstan::extract(fit)

d_qua <- data.frame(t(apply(
  X=ms$y_base_new,
  MARGIN=2,
  FUN=quantile,
  probs=c(0.025, 0.5, 0.975)
)))
d_qua

colnames(d_qua) <- c('p2.5', 'p50', 'p97.5')
d_qua$X <- X_new
d_qua

p <- ggplot(data=d_qua, aes(x=X, y=p50)) +
  theme_bw(base_size=18) + 
  geom_line(size=1) +
  geom_ribbon(aes(ymin=p2.5, ymax=p97.5), fill='black', alpha=1/6) +
  geom_point(data=d, aes(x=X, y=Y), shape=1, size=3)

p

ggsave(file='fig4-8-left-2.png', plot=p, dpi=300, w=4, h=3)

d_qua <- data.frame(t(apply(
  X=ms$y_new,
  MARGIN=2,
  FUN=quantile,
  probs=c(0.025, 0.5, 0.975)
)))
d_qua

colnames(d_qua) <- c('p2.5', 'p50', 'p97.5')
d_qua$X <- X_new
d_qua

p <- ggplot(data=d_qua, aes(x=X, y=p50)) +
  theme_bw(base_size=18) + 
  geom_line(size=1) +
  geom_ribbon(aes(ymin=p2.5, ymax=p97.5), fill='black', alpha=1/6) +
  geom_point(data=d, aes(x=X, y=Y), shape=1, size=3)

p

ggsave(file='fig4-8-right-2.png', plot=p, dpi=300, w=4, h=3)
