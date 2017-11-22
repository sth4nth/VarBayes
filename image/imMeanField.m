function nodeBel = imMeanField(M, N, nodePot, edgePot, epoch)

stride = [-1,1,-M,M];
nodeBel = softmax(-nodePot,1);
for t = 1:epoch
    for j = 1:N
        for i = 1:M
            pos = i + M*(j-1);
            ne = pos + stride;
            ne([i,i,j,j] == [1,M,1,N]) = [];
            nodeBel(:,pos) = softmax(-edgePot*sum(nodeBel(:,ne),2)-nodePot(:,pos));
        end
    end
end 


