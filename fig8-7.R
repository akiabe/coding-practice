library(ggplot2)

d <- read.csv('data-conc-2.txt')
head(d, n=5)

Time_tbl <- Time <- c(1, 2, 4, 8, 12, 24)
names(Time_tbl) <- paste0('Time', Time)
d <- reshape2::melt(d, id='PersonID', variable.name='Time', value.name='Y')
d$Time <- Time_tbl[d$Time]
head(d, n=5)

p <- ggplot(data=d, aes(x=Time, y=Y)) + 
  theme_bw(base_size=18) + 
  facet_wrap(~PersonID) + 
  geom_line(size=1) + 
  geom_point(size=3) + 
  labs(x='Time (hour)', y='Y') + 
  scale_x_continuous(breaks=Time, limit=c(0,24)) + 
  scale_y_continuous(breaks=seq(0,40,10), limit=c(-3,37))

p

#ggsave(file='fig8-7-left.png', plot=p, dpi=300, w=8, h=7)

d <- read.csv('data-conc-2.txt')
d_last <- d[ncol(d)]
bw <- 3.0

p <- ggplot(data=d_last, aes(x=Time24)) + 
  theme_bw(base_size=18) + 
  geom_histogram(binwidth=bw, color='black', fill='white') + 
  geom_density(eval(bquote(aes(y=..count..*.(bw)))), alpha=0.2, color='black', fill='gray20') + 
  labs(x='Time24', y='count') + 
  xlim(range(density(d_last$Time24)$x))

p

ggsave(file='fig8-7-right.png', plot=p, dpi=300, w=4, h=4)


