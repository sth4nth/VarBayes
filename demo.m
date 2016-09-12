% demos for HMM in ch13
d = 3;
k = 2;
n = 200;
[x, s, A, E] = rndHmm(d, k, n);
[gamma, llh] = nabHmm(x, s, A, E);
[gamma1, llh1] = abHmm(x, s, A, E);
maxdiff(gamma,gamma1)
[gamma2, llh2] = fbHmm(x, s, A, E);
maxdiff(gamma,gamma2)
[gamma3, llh3] = bpHmm(x, s, A, E);
maxdiff(gamma,gamma3)

