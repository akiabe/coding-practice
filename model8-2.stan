data {
  int N;
  int K;
  real X[N];
  real Y[N];
  int<lower=1, upper=K> KID[N];
}

parameters {
  real a[K];
  real b[K];
  real<lower=0> s_Y;
}

transformed parameters {
  real mu[N];
  for (n in 1:N) {
    mu[n] = a[KID[n]] + b[KID[n]]*X[n];
  }
}

model {
  for (n in 1:N) {
    Y[n] ~ normal(mu[n], s_Y);
  }
}

