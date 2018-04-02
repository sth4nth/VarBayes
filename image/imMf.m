function nodeBel = imMf(nodePot, edgePot, epoch)
% Image mean field
%   nodePot: k x m x n node potential
%   edgePot: k x k edge potential
% Written by Mo Chen (sth4nth@gmail.com)
[~,m,n] = size(nodePot);
stride = [-1,1,-m,m];
nodeBel = softmax(nodePot,1);
for t = 1:epoch
    for j = 1:n
        for i = 1:m
            pos = i + m*(j-1);
            ne = pos + stride;
            ne([i,i,j,j] == [1,m,1,n]) = [];
            nodeBel(:,pos) = softmax(nodePot(:,pos)+edgePot*sum(nodeBel(:,ne),2));
        end
    end
end 


