function [nodeBel, edgeBel, lnZ] = mrfAprox(Samples, A, nodePot, edgePot)
% Approximate MRF inference by Samples
% Assuming egdePot is symmetric
% Input: 
%   Z: T x n node label
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
%   lnZ: free energy
% Written by Mo Chen (sth4nth@gmail.com)
T = size(Samples,1);
N = size(nodePot,2);
M = size(edgePot,3);
[src,des,edge] = find(triu(A));
nodeBel = zeros(size(nodePot));
edgeBel = zeros(size(edgePot));
pot = zeros(T,1);
for t = 1:T
    for n = 1:N
        nodeBel(Samples(t,n),n) = nodeBel(Samples(t,n),n)+1;
    end
    
    for m = 1:M
        edgeBel(Samples(t,src(m)),Samples(t,des(m)),edge(m)) = edgeBel(Samples(t,src(m)),Samples(t,des(m)),edge(m))+1;
    end
    
    pot(t) = mrfPot(Samples(t,:),A,nodePot,edgePot);
end
nodeBel = nodeBel/T;
edgeBel = edgeBel/T;
lnZ = logsumexp(pot);
