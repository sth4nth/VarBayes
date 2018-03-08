function [z, lnZ] = mrfBf(A, nodePot, edgePot)
% Brute force method for exact MRF inference
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
% Written by Mo Chen (sth4nth@gmail.com)
[k,n] = size(nodePot);
lnZ = -inf;
for i = 1:k^n
    z0 = num2code(i,k,n)+1;
    lnZ0 = potential(z0,A,nodePot,edgePot);
    if lnZ0 > lnZ
        lnZ = lnZ0;
        z = z0;
    end
end

% TBD
function code = num2code(x, k, n)
code = zeros(1,n);
p = 1;
while x
    code(p) = mod(x,k);
    x = x-k;
    p = p+1;
end

function pot = potential(z, A, nodePot,edgePot)
pot = 0;
for i = 1:size(nodePot,2)
   pot = pot+nodePot(i,z(i));
end
[s,t,e] = find(tril(A));
for l = 1:numel(e)
   pot = pot+edgePot(z(s(l)),z(t(l)),e(l));
end