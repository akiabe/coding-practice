data {
  int N;
  vector[N] X;
  vector[N] Y;
  int N_pred;
  vector[N_pred] X_pred;
}

parameters {
  real a;
  real b;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  vector[N_pred] mu_pred;
  mu = a + b*X;
  mu_pred = a + b*X_pred;
}

model {
  Y ~ normal(mu, sigma);
}

generated quantities {
  vector[N_pred] Y_pred;
  for (i in 1:N_pred) {
    Y_pred[i] = normal_rng(mu_pred[i], sigma);
  }
}

