function [A, nodePot, edgePot] = im2mrf(im, sigma, J)
% Convert a image to Ising MRF with distribution p(x)=exp(-sum(nodePot)-sum(edgePot)-lnZ)
% Input:
%   im: row x col image
%   sigma: variance of Gaussian node potential
%   J: parameter of Ising edge
% Output:
%   nodePot: 2 x n node potential
%   edgePot: 2 x 2 x m edge potential
% Written by Mo Chen (sth4nth@gmail.com)
A = lattice(size(im));
[s,t,e] = find(tril(A));
m = numel(e);
e(:) = 1:m;
A = sparse([s;t],[t;s],[e;e]);

z = [1;-1];
y = reshape(im,1,[]);
nodePot = (y-z).^2/(2*sigma^2);
edgePot = repmat(-J*(z*z'),[1, 1, m]);