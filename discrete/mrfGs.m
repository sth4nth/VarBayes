function z = mrfGs(A, nodePot, edgePot, epoch, t)
% Gibbs sampling for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
%   epoch: burn-in steps
%   t: number of samples to be generated
% Output:
%   z: t x n node label
% Written by Mo Chen (sth4nth@gmail.com)
[k,n] = size(nodePot);
[~,label] = max(nodePot,[],1);
z = (1:k)' == label;    % init nodeBel    
for iter = 1:epoch
    for i = 1:n
        [~,j,e] = find(A(i,:));             % neighbors
        p = softmax(nodePot(:,i)+reshape(edgePot(:,:,e),2,[])*reshape(z(:,j),[],1));
        z(:,i) = mnrnd(1,p);
    end
end
