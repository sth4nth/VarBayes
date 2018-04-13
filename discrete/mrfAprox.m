function [nodeBel, edgeBel, lnZ] = mrfAprox(A, nodePot, edgePot, Samples)
% Approximate MRF inference by Samples
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
%   Samples: s x n  samples
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
%   lnZ: free energy
% Written by Mo Chen (sth4nth@gmail.com)
[s,t,e] = find(triu(A));
nodeBel = zeros(size(nodePot));
edgeBel = zeros(size(edgePot));
Z = 0;
for d = 1:nSamples
    for i = 1:nNodes
        nodeBel(Samples(d,i),i) = nodeBel(Samples(d,i),i)+1;
    end
    
    for l = 1:nEdges
        edgeBel(Sample(d,s(l)),Samples(d,t(l)),e(l)) = edgeBel(Sample(d,s(l)),Samples(d,t(l)),e(l))+1;
    end
    
    Z = Z+mrfPot(Samples(s,:),A,nodePot,edgePot);
end
nodeBel = nodeBel/nSamples;
edgeBel = edgeBel/nSamples;
lnZ = log(Z);