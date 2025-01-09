function Q = calculate_modularity(B, communities)

    % File:    calculate_modularity.m
    %
    % Goal:    Function for the modularity computation of a given graph partition
    %
    % Input:
    %          B: modularity matrix
    %          communities: vector with node labels
    %
    % Output:
    %          Q: modularity

    n = size(B, 1);
    S = zeros(n, max(communities));
    for i = 1:n
        % S_{ij} = 1 if v_i belong to the j-th community
        S(i, communities(i)) = 1;
    end
    % Modularity computation
    Q = trace(S' * B * S);

end
