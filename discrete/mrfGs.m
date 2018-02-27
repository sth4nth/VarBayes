function z = mrfGs(A, nodePot, edgePot, epoch)
% Gibbs sampling for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   z: k x n node label
%   lnZ: free energy
% Written by Mo Chen (sth4nth@gmail.com)
[k,n] = size(nodePot);
z = (1:k)' == max(-nodePot, [], 1);    % init nodeBel    
for iter = 1:epoch
    for i = 1:n
        [~,j,e] = find(A(i,:));             % neighbors
        nodeBel = softmax(-nodePot(:,i)-reshape(edgePot(:,:,e),2,[])*reshape(z(:,j),[],1));
        z(:,i) = mnrnd(1,nodeBel,1);
    end
end
