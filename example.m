%% script: example.m 

% Load Dolphin Social Network
load('data/data_dolphin.mat')

% Graph
G = graph(A);

%% Algorithm 3

[communities, colors, color_map, num_communities, unique_communities] = algorithm_3(A);

% Visualization of the graph partitioning into communities
figure;
h = plot(G, 'NodeCData', communities, 'MarkerSize', 4, 'NodeColor', colors);
title('Dolphin Social Network - Algorithm 3');
h.NodeLabel = {};

% Node color assignment
 for i = 1:num_communities
     highlight(h, find(communities == unique_communities(i)), 'NodeColor', color_map(i, :));
 end

% Colorbar of community colors
colormap(color_map);
c = colorbar;
c.Ticks = linspace(0, 1, num_communities);
c.TickLabels = {};
c.Label.String = 'Comunità';

%% Visualization of the magnitudes of the elements of the leading eigenvector u_1 of B

[communities_mag, colors_mag] = algorithm_1_magnitudes(A);

% Visualization of the graph with the magnitudes of the elements of u_1
figure;
h_mag = plot(G, 'NodeCData', communities_mag, 'MarkerSize', 4, 'NodeColor', colors_mag);
title('Dolphin Social Network - Magnitudes Algorithm 1');
h_mag.NodeLabel = {};

% Color map
color_map = [
    0 0 1;
    1 0 0;
];

% Legend
legend_entries_mag = {'Community 1', 'Community 2'};
hold on;
scatter_handles_mag = gobjects(2, 1);
for i = 1:2
    scatter_handles_mag(i) = scatter(NaN, NaN, 100, 'MarkerFaceColor', color_map(i, :), 'DisplayName', legend_entries_mag{i});
end
hold off;
legend(scatter_handles_mag, 'Location', 'best');
