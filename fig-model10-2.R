library(ggplot2)

softmax <- function(par){
  n.par <- length(par)
  par1 <- sort(par, decreasing=TRUE)
  Lk <- par1[1]
  for (k in 1:(n.par-1)) {
    Lk <- max(par1[k+1], Lk) + log1p(exp(-abs(par1[k+1] - Lk))) 
  }
  val <- exp(par - Lk)
  return(val)
}

d <- read.csv(file='data-category.txt')
head(d, n=5)

load('result-model10-2.RData')
ms <- rstan::extract(fit)

d_qua <- data.frame(t(apply(
  X=softmax(ms$mu), 
  MARGIN=2, 
  FUN=quantile, 
  prob=c(0.1, 0.5, 0.9)
)))

colnames(d_qua) <- c('p10', 'p50', 'p90')
d_qua$Sex <- as.factor(d$Sex)
d_qua$Y <- as.factor(d$Y)

p <- ggplot(data=d_qua, aes(x=Y, y=p50)) + 
  theme_bw(base_size=18) + 
  coord_flip() + 
  geom_violin(trim=FALSE, size=1.5, color='grey80') + 
  geom_point(aes(color=Sex), position=position_jitter(w=0.4, h=0), size=1) + 
  scale_color_manual(values=c('grey5', 'grey50')) + 
  labs(x='Y', y='q')

p

ggsave(file='fig-model102.png', plot=p, dpi=300, w=4.5, h=3)
