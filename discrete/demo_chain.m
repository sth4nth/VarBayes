clear; close all;

epoch = 10;
nSamples = 100;
nNodes = 4;
nStates = 2;
%% Test 1: Independent Nodes
nodePot = [1, 9, 1, 9;
           3, 1, 3, 1];
P = normalize(nodePot,1);

X = zeros(nSamples,nNodes);
for i = 1:nNodes
   X(:,i) = randp(P(:,i),nSamples); 
end
figure;
imagesc(X);
ylabel('Question');
xlabel('Student');
title('Independent Test');
%% Test 2: Dependent nodes
nEdges = 3;
edgePot = repmat([2,1;1,2],[1,1,nEdges]); 

% Make adjacency matrix
A = zeros(nNodes,nNodes);
A(1,2) = 1;
A(2,3) = 2;
A(3,4) = 3;
A = A+A';
nodePot = log(nodePot);
edgePot = log(edgePot);

[nodeBel,edgeBel,lnZ] = mrfExact(A,nodePot,edgePot);
%% Bethe energy for chain is free energy 
lnZ0 = mrfBethe(A,nodePot,edgePot,nodeBel,edgeBel);
lnZ-lnZ0     
%% BP chain is exact
[nodeBel1,edgeBel1,L1] = mrfBp(A,nodePot,edgePot,epoch);
lnZ-L1(end)
%% Mean Field
[nodeBel2,edgeBel2,L2] = mrfMf(A,nodePot,edgePot,epoch);
lnZ2 = mrfGibbs(A,nodePot,edgePot,nodeBel2);
lnZ2-L2(end)