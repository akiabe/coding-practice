set.seed(123)
N <- 40
K <- 4
N_k <- c(15, 12, 10, 3)
a0 <- 350
b0 <- 12
s_a <- 60
s_b <- 4
s_Y <- 25
X <- sample(x=0:35, size=N, replace=TRUE)
KID <- rep(1:4, times=N_k)
a <- rnorm(K, mean=0, sd=s_a) + a0
b <- rnorm(K, mean=0, sd=s_b) + b0
d <- data.frame(X=X, KID=KID, a=a[KID], b=b[KID])
d <- transform(d, Y_sim=rnorm(N, mean=a + b*X, sd=s_Y))

d$KID <- as.factor(d$KID)
p <- ggplot(d, aes(X, Y_sim, shape=KID))
p <- p + theme_bw(base_size=18)
p <- p + facet_wrap(~KID)
p <- p + geom_line(stat='smooth', method='lm', se=FALSE, size=1, color='black', linetype='31', alpha=0.8)
p <- p + geom_point(size=3)
p <- p + scale_shape_manual(values=c(16, 2, 4, 9))
p <- p + labs(x='X', y='Y')
p

##ggsave(p, file='fig8-2.png', dpi=300, w=6, h=5)
