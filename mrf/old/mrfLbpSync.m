function [nodeBel, edgeBel, L] = mrfLbpSync(B, nodePot,edgePot)
[nNodes,nStates] = size(nodePot);
nEdges = size(edgePot,3);

B = logical(B);
tol = 1e-4;
maxIter = 100;
msg = ones(nStates,nEdges*2)/nStates;

for i = 1:maxIter
    msg0 = msg;
    for n = 1:nNodes
        % Find Neighbors
        edges = find(B(:,n));
        edges = edges(:)';
        % Send a message to each neighbor
        for e = edges
            nodes = find(B(e,:));
%             n1 = nodes(1);
            n2 = nodes(2);
%             j = setdiff(nodes,n);
            ep = edgePot(:,:,e);

%             rest = setdiff(edges,e);
            
            % Compute mu = product of all incoming msgs except j
            mu = nodePot(:,n);
            for e2 = edges
                if e == e2
                    continue;
                end
                
                nodes2 = find(B(e2,:));
                if n == nodes2(2) 
                    mu = mu .* msg(:,e2);
                else
                    mu = mu .* msg(:,e2+nEdges);
                end
            end

            newm = ep * mu;

            if n == n2 
                msg(:,e+nEdges) = newm./sum(newm);
            else
                msg(:,e) = newm./sum(newm);
            end
        end
    end

    if sum(abs(msg(:)-msg0(:))) < tol; break; end
end

% Compute node belief
nodeBel = nodePot;
for n = 1:nNodes
    edges = find(B(:,n));
    for e = edges(:)'
        nodes = find(B(e,:));
        if n == nodes(2)
%         if n == edgeEnds(e,2)
            nodeBel(:,n) = nodeBel(:,n) .* msg(:,e);
        else
            nodeBel(:,n) = nodeBel(:,n) .* msg(:,e+nEdges);
        end
    end
end
nodeBel = normalize(nodeBel,1);

% Compute edge beliefs
edgeBel = zeros(nStates,nStates,nEdges);
for e = 1:nEdges
    nodes = find(B(e,:));
    n1 = nodes(1);
    n2 = nodes(2);
    nb1 = nodeBel(:,n1)./msg(:,e+nEdges);
    nb2 = nodeBel(:,n2)./msg(:,e);
    eb = (nb1*nb2').*edgePot(:,:,e);
    edgeBel(:,:,e) = eb./sum(eb(:));
end

