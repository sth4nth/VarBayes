function lnZ = verify(A, nodePot, edgePot, nodeBel, edgeBel )
[s,t,e] = find(tril(A));
lnZ_l = 0;
for l = 1:numel(e)
    i = s(l);
    j = t(l);
    k = e(l);
    
    lnZ_l = lnZ_l + nodeBel(:,i)'*edgePot(:,:,k)*nodeBel(:,j);
end

[s,t,e] = find(A);
lnZ_f = 0;
for l = 1:numel(e)
    i = s(l);
    j = t(l);
    k = e(l);
    
    lnZ_f = lnZ_f + nodeBel(:,i)'*edgePot(:,:,k)*nodeBel(:,j);
end
lnZ_f = 0.5*lnZ_f;

lnZ0 = 0;
for i = 1:size(nodePot,2)
    [~,j,k] = find(A(i,:));
    lnZ0 = lnZ0 + nodeBel(:,i)'*(reshape(edgePot(:,:,k),2,[])*reshape(nodeBel(:,j),[],1));
end
lnZ0 = 0.5*lnZ0;
% maxdiff(lnZ0,lnZ_f)

lnZ1 = dot(edgeBel(:), edgePot(:));

edgePot = reshape(edgePot,[],size(edgePot,3));
edgeBel = reshape(edgeBel,[],size(edgeBel,3));
Ex = dot(nodeBel,nodePot,1);
Exy = dot(edgeBel,edgePot,1);
Hx = dot(nodeBel,log(nodeBel),1);
% lnZ = -(sum(Ex)+sum(Exy)+sum(Hx));
maxdiff(lnZ0,lnZ1)

lnZ = lnZ0;
