library(ggplot2)

d <- read.csv('data-salary-2.txt')
head(d, n=5)

load('result-model8-4.RData')
ms <- rstan::extract(fit4)
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
d_qua

ggplot(data=d_qua, aes(x=X, y=Y, shape=as.factor(KID))) +
  theme_bw(base_size=20) + 
  theme(legend.key.width=grid::unit(2.5,'line')) +
  facet_wrap(~KID) +
  geom_point(alpha=0.3, size=3) +
  geom_line(aes(y=p50)) +
  geom_ribbon(aes(ymin=p2.5, ymax=p97.5), alpha=0.3) +
  labs(x='X', y='Y', shape='KID')

#ggsave(p, file='fig8-4-right.png', dpi=300, w=6.3, h=5)
