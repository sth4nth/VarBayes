% demos for HMM in ch13
d = 3;
k = 2;
n = 500;
[x, s, A, E] = rndHmm(d, k, n);
[m1, c] = abHmm(x, s, A, E);
m2 = bpHmm(x, s, A, E);
