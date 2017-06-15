function p = ising(x, b)
% Ising style Bernoulli distribution
p = exp(b*x)/(2*cosh(b));