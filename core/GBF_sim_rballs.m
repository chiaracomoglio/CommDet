% This function is imported from "GBFlearn: a toolbox for graph signal interpolation
% and classification with graph basis functions (GBFs)"
% (C) W. Erb 15.01.2023

function [edges,A] = GBF_sim_rballs(nodes,r,type)

% File:    GBF_sim_rballs
% 
% Goal:    Function that calculates edges and adjacency matrix for point clouds in order to
%          generate a r-ball graph or a NN graph. 
%
% Input:  
%          nodes        : Nodes of point cloud
%          r            : Number of nearest neighbors (NN) or radius for r-ball strategy 
%          type         : NN (nearest neighbors) or ball (all nodes inside r-ball)
%
% Output:    
%          edges        : edges of the graph G
%          A            : adjacency matrix of the graph G

if (nargin < 3)
    type = 'ball';
end

N = size(nodes,1);
iter = 0;

% Determine the neighbors of each node
if strcmp(type,'NN')     % for NN strategy
    edges = zeros(5*r,2);  
    idx = knnsearch(nodes,nodes,'k',r+1);
    for i = 1 : N
         for j = 1:r
            if (idx(i,1) < idx(i,j+1))
                iter = iter + 1;
                edges(iter,:) = [i idx(i,j+1)];
            end
        end
    end
    % Remove zeros in the indices
    edges = edges(1:iter,:);
    
    % Construct the adjacency matrix (sparse)
    A = sparse([edges(:,1);edges(:,2)],[edges(:,2);edges(:,1)],1);
   
elseif strcmp(type,'ball')  % for r-ball strategy
    M = N*(N-1)/2;
    edges = zeros(M,2);
    
    for i = 1 : N
        for j = i+1 : N
            if norm( nodes(i,:) - nodes(j,:), 2 ) <= r
                iter = iter + 1;
                edges(iter,:) = [i j];
            end
        end
    end
    % Remove zeros in the indices
    edges = edges(1:iter,:);

    % Construct the adjacency matrix
    A = zeros(N,N);
    A(sub2ind([N N],edges(:,1),edges(:,2))) = 1;
    A(sub2ind([N N],edges(:,2),edges(:,1))) = 1;
end

return
