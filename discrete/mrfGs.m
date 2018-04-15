function Z = mrfGs(A, nodePot, edgePot, T)
% Gibbs sampling for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
%   epoch: burn-in steps
%   T: number of samples to be generated
% Output:
%   Z: T x n node label
% Written by Mo Chen (sth4nth@gmail.com)
[k,n] = size(nodePot);
Z = zeros(T,n);
[~,label] = max(nodePot,[],1);
E = (1:k)' == label;    % init nodeBel    
for t = 1:T
    for i = 1:n
        [~,j,e] = find(A(i,:));             % neighbors
        p = softmax(nodePot(:,i)+reshape(edgePot(:,:,e),2,[])*reshape(E(:,j),[],1));
        E(:,i) = mnrnd(1,p);
    end
    [~,Z(t,:)] = max(E,[],1);
end

function z = nextSample(z, A, nodePot, edgePot)
n = size(nodePot,2);
E = (1:k)' == z;    % init nodeBel    
for i = 1:n
    [~,j,e] = find(A(i,:));             % neighbors
    p = softmax(nodePot(:,i)+reshape(edgePot(:,:,e),2,[])*reshape(E(:,j),[],1));
    E(:,i) = mnrnd(1,p);
end
[~,z] = max(E,[],1);