function [nodeBel, edgeBel, L] = mrf_bp(nodePot, edgePot, B)
% Belief propagation for MRF
B = logical(B);
tol = 1e-4;
epoch = 50;
L = -inf(1,epoch+1);
% 
for t = 1:epoch
    for i = 1:size(B,2)
        
    end
    if abs(L(t+1)-L(t)) < tol; break; end
end