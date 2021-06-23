library(ggplot2)

d <- read.csv("data-salary-2.txt")
d$KID <- as.factor(d$KID)
res_lm <- lm(Y ~ X, data=d)
coef <- as.numeric(res_lm$coefficients)

p <- ggplot(d, aes(X, Y, shape=KID)) + 
  theme_bw(base_size=18) + 
  geom_abline(intercept=coef[1], slope=coef[2], size=2, alpha=0.3) + 
  geom_point(size=2) + 
  scale_shape_manual(values=c(16, 2, 4, 9)) + 
  labs(x='X', y='Y')
p
#gsave(p, file='fig8-1-left.png', dpi=300, w=4, h=3)

p <- ggplot(d, aes(X, Y, shape=KID)) + 
  theme_bw(base_size=20) + 
  geom_abline(intercept=coef[1], slope=coef[2], size=2, alpha=0.3) + 
  facet_wrap(~KID) + 
  geom_line(stat='smooth', method='lm', se=FALSE, size=1, color='black', linetype='31', alpha=0.8) + 
  geom_point(size=3) + 
  scale_shape_manual(values=c(16, 2, 4, 9)) + 
  labs(x='X', y='Y')
p
#ggsave(p, file='fig8-1-right.png', dpi=300, w=6, h=5)
