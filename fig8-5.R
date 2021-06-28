library(ggplot2)

d <- read.csv('data-salary-3.txt')
head(d, n=5)

d$GID <- as.factor(d$GID)

res_lm <- lm(Y ~ X, data=d)
res_lm

coef <- as.numeric(res_lm$coefficients)
coef

ggplot(d, aes(X, Y, shape=GID)) + 
  theme_bw(base_size=18) + 
  geom_abline(intercept=coef[1], slope=coef[2], size=2, alpha=0.3) + 
  geom_point(size=2) + 
  scale_shape_manual(values=c(16, 2, 4, 9)) + 
  labs(x='X', y='Y')

#ggsave(p, file='fig8-5-left.png', dpi=300, w=4, h=3)

ggplot(d, aes(X, Y, shape=GID)) + 
  theme_bw(base_size=20) + 
  geom_abline(intercept=coef[1], slope=coef[2], size=2, alpha=0.3) + 
  facet_wrap(~GID, ncol=2) + 
  geom_line(stat='smooth', method='lm', se=FALSE, size=1, color='black', linetype='31', alpha=0.8) + 
  geom_point(size=3, alpha=0.8) + 
  scale_shape_manual(values=c(16, 2, 4)) + 
  labs(x='X', y='Y')

#ggsave(p, file='output/fig8-5-right.png', dpi=300, w=6, h=5)

KIDGID <- unique(d[,3:4])
KIDGID

N <- nrow(d)
K <- 30
G <- 3
coefs <- as.data.frame(t(sapply(1:K, function(k) {
  d_sub <- subset(d, KID==k)
  as.numeric(lm(Y ~ X, data=d_sub)$coefficients)
})))
colnames(coefs) <- c('a', 'b')

d_plot <- data.frame(coefs, KIDGID)
d_plot

bw <- diff(range(d_plot$a))/20
bw

ggplot(data=d_plot, aes(x=a)) + 
  theme_bw(base_size=18) + 
  facet_wrap(~GID, nrow=3) + 
  geom_histogram(binwidth=bw, color='black', fill='white') + 
  geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.2, color='black', fill='gray20') + 
  labs(x='a', y='count')

#ggsave(file='fig8-6-left.png', plot=p, dpi=300, w=4, h=6)

bw <- diff(range(d_plot$b))/20

ggplot(data=d_plot, aes(x=b)) + 
  theme_bw(base_size=18) + 
  facet_wrap(~GID, nrow=3) + 
  geom_histogram(binwidth=bw, color='black', fill='white') + 
  geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.2, color='black', fill='gray20') + 
  labs(x='b', y='count')

#ggsave(file='fig8-6-right.png', plot=p, dpi=300, w=4, h=6)
