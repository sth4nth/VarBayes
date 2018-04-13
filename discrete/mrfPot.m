function pot = mrfPot(z, A, nodePot, edgePot)
pot = 0;
for i = 1:size(nodePot,2)
   pot = pot+nodePot(z(i),i);
end
[s,t,e] = find(triu(A));
for l = 1:numel(e)
   pot = pot+edgePot(z(s(l)),z(t(l)),e(l));
end
