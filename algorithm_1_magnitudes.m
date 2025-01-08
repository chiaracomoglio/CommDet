function [communities,colors] = algorithm_1_magnitudes(A)

    % File:    algorithm_1_magnitudes.m
    %
    % Goal:    Function for visualizing the magnitudes of the leading eigenvector u_1 of the modularity matrix
    %
    % Input:
    %          A: adjacency matrix
    %
    % Output:
    %         communities: vector of node labels (+1 or -1)
    %         colors: color map of the nodes

    % Vector with the degree of v_i in the i-th row
    k = sum(A, 2);

   % Number of edges of the graph
    m = sum(k) / 2;

   % Modularity matrix
   B = A - (k * k') / (2 * m);

   % Leading eigenvector u_1 of B
   [u_1, ~] = eigs(B, 1, 'largestreal');

   % Assign each node to one of the two communities based on the sign of u_1
   communities = ones(size(u_1));
   communities(u_1 < 0) = -1;

  % Compute the saturation based on the values of u_1
  saturazione = abs(u_1) / max(abs(u_1));

  % Color map based on saturation
  for i = 1:size(u_1, 1)
      if u_1(i) >= 0
      % Nodes of community 1 (blue), with intensity based on saturation
      colors(i, :) = [0, 0, 1] * saturazione(i);
  else
      % Nodes of community 2 (red), with intensity based on saturation
      colors(i, :) = [1, 0, 0] * saturazione(i);
  end

end
