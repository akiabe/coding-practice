library(ggplot2)

d <- read.csv(file='data-mix2.txt')
head(d, n=5)

dens <- density(d$Y)
dens

p <- ggplot(data=d, aes(x=Y)) + 
  theme_bw(base_size=18) + 
  geom_histogram(colour='black', fill='white') + 
  geom_density(aes(y=..count..), alpha=0.35, colour='black', fill='gray20') + 
  labs(x='Y') + 
  xlim(range(dens$x))

p

ggsave(file='fig11-3.png', plot=p, dpi=300, w=4, h=3)
