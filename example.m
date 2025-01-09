%% script: example.m 

clear all; close all; format short e; 

%% Algorithm 3

% Graph: Stanford Bunny
G.type = 'bunny';
load data_bunny.mat
[G.nodes,G.edges,G.A] = GBF_gengraph(G.type);

% Adjacency matrix
G_plot = graph(G.A);

[communities, colors, color_map, num_communities, unique_communities] = algorithm_3(G.A);

% Visualization of the graph partitioning into communities
figure;
h = plot(G_plot, 'NodeCData', communities, 'MarkerSize', 3, 'NodeColor', colors, 'XData', G.nodes(:,1), 'YData', G.nodes(:,2));
title('Stanford Bunny - Algorithm 3');
h.NodeLabel = {};
axis equal;

% Node color assignment
 for i = 1:num_communities
     highlight(h, find(communities == unique_communities(i)), 'NodeColor', color_map(i, :));
 end

% Colorbar with community colors
colormap(color_map);
c = colorbar;
c.Ticks = linspace(0, 1, num_communities);
c.TickLabels = {};
c.Label.String = 'Communities';

%% Visualization of the magnitudes of the elements of the leading eigenvector u_1 of B

[communities_mag, colors_mag] = algorithm_1_magnitudes(G.A);

% Visualization of the graph with the magnitudes of the elements of u_1
figure;
h_mag = plot(G_plot, 'NodeCData', communities_mag, 'MarkerSize', 3, 'NodeColor', colors_mag, 'XData', G.nodes(:,1), 'YData', G.nodes(:,2));
title('Stanford Bunny - Magnitudes Algorithm 1');
h_mag.NodeLabel = {};
axis equal;

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
