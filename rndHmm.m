function [x, s, A, E] = rndHmm(d, k, n)
% Generate a data sequence from a hidden Markov model.
% Input:
%   d: dimension of data
%   k: dimension of latent variable
%   n: number of data
% Output:
%   X: d x n data matrix
%   model: model structure
% Written by Mo Chen (sth4nth@gmail.com).
    A = nml(rand(k,k),2);
    E = nml(rand(k,d),2);
    s = nml(rand(k,1),1);

    x = zeros(1,n);
    z = rndp(s);
    x(1) = rndp(E(z,:));
    for i = 2:n
        z = rndp(A(z,:));
        x(i) = rndp(E(z,:));
    end
end