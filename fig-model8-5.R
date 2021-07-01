library(ggplot2)

d <- read.csv('data-salary-3.txt')
head(d, n=5)

load('result-model8-5.RData')
ms <- rstan::extract(fit5)
ms

d_qua <- data.frame(t(apply(
  X=ms$mu,
  MARGIN=2,
  FUN=quantile,
  prob=c(0.025, 0.5, 0.975)
)))
d_qua

colnames(d_qua) <- c('p2.5', 'p50', 'p97.5')
d_qua$X <- d$X
d_qua$Y <- d$Y
d_qua$KID <- d$KID
d_qua$GID <- d$GID
head(d_qua, n=5)

p <- ggplot(data=d_qua, aes(x=X, y=Y, shape=as.factor(GID))) +
  theme_bw(base_size=20) + 
  theme(legend.key.width=grid::unit(2.5,'line')) +
  facet_wrap(~KID, ncol=5) +
  geom_point(alpha=0.3, size=3) +
  geom_line(aes(y=p50)) +
  geom_ribbon(aes(ymin=p2.5, ymax=p97.5), alpha=0.3) +
  labs(x='X', y='Y', shape='GID')

ggsave(p, file='fig-model8-5.png', dpi=300, w=8, h=8)
