library(ggplot2)

d <- read.csv('data-conc-2.txt')
head(d, n=5)
N <- nrow(d)
N

load('result-model8-7.RData')
ms <- rstan::extract(fit)
ms

d_est <- data.frame()

for (n in 1:nrow(d)) {
  qua <- t(apply(
    X=ms$y_new[,n,], 
    MARGIN=2, 
    FUN=quantile, 
    prob = c(0.025, 0.5, 0.975)
  ))
  
  d_est <- rbind(
    d_est, 
    data.frame(PersonID=n, Time=Time_new, qua)
  )
}
colnames(d_est) <- c('PersonID', 'Time', 'p2.5', 'p50', 'p97.5')
head(d_est, n=5)

Time_tbl <- Time
names(Time_tbl) <- paste0('Time', Time)
d <- reshape2::melt(d, id='PersonID', variable.name='Time', value.name='Y')
d$Time <- Time_tbl[d$Time]

p <- ggplot(data=d_est, aes(x=Time, y=p50)) + 
  theme_bw(base_size=18) + 
  facet_wrap(~PersonID) + 
  geom_ribbon(aes(ymin=p2.5, ymax=p97.5), fill='black', alpha=1/5) + 
  geom_line(size=0.5) + 
  geom_point(data=d, aes(x=Time, y=Y), size=3) + 
  labs(x='Time (hour)', y='Y') + 
  scale_x_continuous(breaks=Time, limit=c(0,24)) + 
  scale_y_continuous(breaks=seq(0,40,10), limit=c(-3,37))

p

ggsave(file='fig8-8.png', plot=p, dpi=300, w=8, h=7)
