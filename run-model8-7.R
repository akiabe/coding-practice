library(rstan)

d <- read.csv('data-conc-2.txt')
head(d, n=5)

N <- nrow(d)
Time <- c(1, 2, 4, 8, 12, 24)
T_new <- 60
Time_new <- seq(from=0, to=24, length=T_new)
data <- list(N=N, T=length(Time), Time=Time, Y=d[,-1],
             T_new=T_new, Time_new=Time_new)
fit <- stan(file='model/model8-7.stan', data=data, seed=1234)

save.image('output/result-model8-7.RData')
