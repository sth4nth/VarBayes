function [nodeBel, edgeBel, L] = mrf_mf(A, nodePot, edgePot)
% Mean field for MRF
epoch = 100;
tol = 1e-4;
n = size(nodePot,1);
m = size(edgePot,1);

nodeBel = normalize(nodePot,2);
for t = 1:epoch

    for i = 1:n
        idx = fgn(A,i);
        
        
        
        
    end
    
    
end