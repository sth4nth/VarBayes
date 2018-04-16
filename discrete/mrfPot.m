function pot = mrfPot(z, A, nodePot, edgePot)
% Compute MRF potential given a sample
% Input:
%   z: 1 x n a sample
%   A: n x n adjacent matrix
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   pot: overall potential of MRF
% Written by Mo Chen (sth4nth@gmail.com)
pot = 0;
for i = 1:size(nodePot,2)
   pot = pot+nodePot(z(i),i);
end
[s,t,e] = find(triu(A));
for l = 1:numel(e)
   pot = pot+edgePot(z(s(l)),z(t(l)),e(l));
end
