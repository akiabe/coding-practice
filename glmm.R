library(rstan )
library(bayesplot)
library(brms)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

d <- read.csv("4-1-1-fish-num-2.csv")
head(d, n = 5)

d$id <- as.factor(d$id)

model1 <- brm(
  formula = fish_num ~ weather + temperature,
  family = poisson(),
  data = d,
  seed = 1,
  prior = c(set_prior("", class = "Intercept"))
)

#stancode(model1)

set.seed(1)
pred_model1 <- conditional_effects(
  model1,
  method = "predict",
  effects = "temperature:weather",
  prob = c(0.995)
)
plot(pred_model1, points = TRUE)

formula_pois <- formula(fish_num ~ weather + temperature)
design_mat <- model.matrix(formula_pois, d)
#design_mat
sunny_dummy <- as.numeric(design_mat[, "weathersunny"])

data_list_1 <- list(
  N = nrow(d),
  fish_num = d$fish_num,
  sunny = sunny_dummy,
  temp = d$temperature
)

model2 <- stan(
  file = "glmm-poi.stan",
  data = data_list_1,
  seed = 1
)

mcmc_rhat(rhat(model2))

print(
  model2,
  pars = c("Intercept", "b_sunny", "b_temp", "sigma_r"),
  probs = c(0.025, 0.5, 0.975)
)

model3 <- brm(
  formula = fish_num ~ weather + temperature + (1|id),
  family = poisson(),
  data = data_list_1,
  seed = 1,
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sd")
)

model3
