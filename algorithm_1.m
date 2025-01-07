function [communities,colors] = algorithm_1(A)

    % File:    algorithm_1.m
    %
    % Goal:    Function for graph partitioning into two communities using the leading eigenvector method 
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

    % Modularity matrix
    B = A - (k * k') / (2 * m);

    % Leading eigenvector of B
    [u_1, ~] = eigs(B, 1);

    % Assign each node to one of the two communities based on the sign of u_1
    communities = ones(n, 1);
    communities(u_1 < 0) = -1; 

    % Color map based on the values of u_1
    colors = zeros(n, 3);
    % Assign the color blue to the nodes corresponding to non-negative values of u_1
    colors(u_1 >= 0, :) = repmat([0, 0, 1], sum(u_1 >= 0), 1);
    % Assign the color red to the nodes corresponding to negative values of u_1
    colors(u_1 < 0, :) = repmat([1, 0, 0], sum(u_1 < 0), 1);

end
