function [B, nodePot, edgePot] = im2fg(im, sigma, J)
% Contruct Ising factor graphical model from an image
% Input:
%   im: row x col image
%   sigma: variance of Gaussian node potential
%   J: parameter of Ising edge
% Output:
%   B: m x n adjacent matrix of bipartite graph
%   nodePot: 2 x n node potential
%   edgePot: 2 x 2 x m edge potential
% Written by Mo Chen (sth4nth@gmail.com)
A = lattice(size(im));
B = ug2fg(A);
z = [1;-1];
y = reshape(im,1,[]);
nodePot = num2cell((y-z).^2/(2*sigma^2),1);
edgePot = repmat({-J*(z*z')},1,size(B,1));
