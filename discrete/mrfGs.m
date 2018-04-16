function Z = mrfGs(A, nodePot, edgePot, epoch, T)
% Gibbs sampling for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
%   epoch: number of step for burn-in 
%   T: number of samples to be generated
% Output:
%   Z: T x n node label
% Written by Mo Chen (sth4nth@gmail.com)
[~,z] = max(nodePot,[],1);   % initialization
for t = 1:epoch
    z = nextSample(z, A, nodePot, edgePot);
end

Z = zeros(T,numel(z));
for t = 1:T
    z = nextSample(z, A, nodePot, edgePot);
    Z(t,:) = z;
end

function z = nextSample(z, A, nodePot, edgePot)
n = size(nodePot,2);
E = (1:size(nodePot,1))' == z;    % init nodeBel   
E = double(E);
for i = 1:n
    [~,j,e] = find(A(i,:));             % neighbors
    p = softmax(nodePot(:,i)+reshape(edgePot(:,:,e),2,[])*reshape(E(:,j),[],1));
    E(:,i) = mnrnd(1,p);
end
[~,z] = max(E,[],1);