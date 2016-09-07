% demos for HMM in ch13
d = 3;
k = 2;
n = 10000;
[x, s, A, E] = rndHmm(d, k, n);
[alpha, beta, gamma, c] = abHmm(x, s, A, E);
