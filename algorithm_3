function [communities, colors, color_map, num_communities, unique_communities] = algorithm_3(A)

    % File:    algorithm_3.m 
    %
    % Goal:    Function for graph partitioning into communities
    %
    % Input:
    %          A: adjacency matrix
    %
    % OUTPUT:
    % communities: vector of node labels (+1 o -1)
    % colors: color map of the nodes
    % num_communities: number of communities
    % unique_communities: vector of community labels 

    % Number of nodes of the graph
    n = size(A, 1);

    % Coloumn vector with the degree of v_i in the i-th row
    k = sum(A, 2);

    % Number of edges of the graph
    m = sum(k) / 2;

    % Modularity matrix
    B = A - (k * k') / (2 * m);

    % Initialization
    communities = ones(n, 1);
    colors = zeros(n, 3); 
    current_communities = 1;
    modularity_increase = true;
    Q_old = calculate_modularity(B, communities);
    tol = 1e-5;

    % While loop as long as there is an increase in modularity
    while modularity_increase
        max_delta_Q = -Inf;
        best_s = [];
        best_idx = -1;
        
        % For loop over the communities within the current communities
        for community = 1:current_communities
            % Vector containing the indices of the nodes that belong to the community
            subgraph_idx = find(communities == community);
            % If the community contains only one node or is empty, move to the next one
            if length(subgraph_idx) <= 1
                continue;
            end
            % Submatrix of A representing the subgraph being considered
            sub_A = A(subgraph_idx, subgraph_idx);
            % sub_A partitioning into two communities
            % [sub_s, ~] = algorithm_1(sub_A);
            [sub_s, ~] = algorithm_2(sub_A);
            
            % Compute the difference between the modularities of the graph before and after the division
            new_communities = communities;
            new_communities(subgraph_idx(sub_s == 1)) = current_communities + 1;
            new_communities(subgraph_idx(sub_s == -1)) = current_communities + 2;
            Q_new = calculate_modularity(B, new_communities);
            delta_Q = Q_new - Q_old;
            
            % if the modularity increase is greater than the best increase observed so far,
            % update the best increase and the best partition
            if delta_Q > max_delta_Q
                max_delta_Q = delta_Q;
                best_s = sub_s;
                best_idx = subgraph_idx;
            end
        end % of the for loop
        
        % If the best modularity increase is greater than a certain tolerance, apply the best partition
        % found and update the number of communities and modularity
        if max_delta_Q > tol
            communities(best_idx(best_s == 1)) = current_communities + 1; 
            communities(best_idx(best_s == -1)) = current_communities + 2;
            current_communities = current_communities + 2;
            Q_old = Q_old + max_delta_Q;
        else
            modularity_increase = false; 
        end
    end % of the while loop
    
    [~, ~, communities] = unique(communities);
    unique_communities = unique(communities);
    num_communities = length(unique_communities);
    
    % Community color assignment
    color_map = hsv(num_communities);
    community_colors = containers.Map('KeyType', 'double', 'ValueType', 'any');
    for i = 1:num_communities
        community_colors(unique_communities(i)) = color_map(i, :);
    end

    % Color map of the nodes
    for i = 1:length(communities)
        colors(i, :) = community_colors(communities(i));
    end
    
end
