library(ggplot2)

d <- read.csv(file='data-salary.txt')
head(d, n=5)


p <- ggplot(data=d, aes(x=X, y=Y)) + 
  theme_bw(base_size=18) + 
  geom_point(shape=1, size=3)

p

ggsave(file='fig4-2.png', plot=p, dpi=300, w=4, h=3)
