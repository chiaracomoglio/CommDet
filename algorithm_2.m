function [communities,colors] = algorithm_2.m(A)

    % File:    algorithm_2.m 
    %
    % Goal:    Function for graph partitioning into two communities using discrete relaxation method
    %
    % Input:
    %          A: adjacency matrix
    %
    % Output: 
    %          communities: vector of node labels (+1 or -1)
    %          colors: color map of the nodes

    % Number of nodes of the graph
    n = size(A, 1);

    % Vector with the degree of v_i in the i-th row
    k = sum(A, 2);

    % Number of edges of the graph
    m = sum(k) / 2;

    % Degree matrix
    D = diag(k);

    % Normalized Laplacian
    D_inv_sqrt = diag(1 ./ sqrt(k));
    L_N = D_inv_sqrt * A * D_inv_sqrt;

    % Eigenvector corresponding to the second-largest eigenvalue of L_N
    [V, ~] = eigs(L_N, 2, 'largestreal');
    u_2 = V(:, 2);

   % Assign each node to one of the two communities based on the sign of u_2
   communities = ones(n, 1);
   communities(u_2 < 0) = -1;

   % Color map based on the values of u_2
   colors = zeros(n, 3);
   % Assign the color blue to the nodes corresponding to non-negative values of u_2
   colors(u_2 >= 0, :) = repmat([0, 0, 1], sum(u_2 >= 0), 1);
   % Assign the color red to the nodes corresponding to negative values of u_2
   colors(u_2 < 0, :) = repmat([1, 0, 0], sum(u_2 < 0), 1);

end
