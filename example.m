%% script: example.m 

% Load Dolphin Social Network
load('data/data_dolphin.mat')

% Graph
G = graph(A);

%% Algorithm 1

[communities_1, colors_1] = algorithm_1(A);

% Visualization of the graph partitioning
figure;
h_1 = plot(G, 'NodeCData', communities_1, 'MarkerSize', 4, 'NodeColor', colors_1);
title('Dolphin Social Network - Algorithm 1');

% Color map
color_map = [
    0 0 1;
    1 0 0;
];

% Legend
legend_entries_1 = {'Community 1', 'Community 2'};
hold on;
scatter_handles_1 = gobjects(2, 1);
for i = 1:2
    scatter_handles_1(i) = scatter(NaN, NaN, 100, 'MarkerFaceColor', color_map(i, :), 'DisplayName', legend_entries_1{i});
end
hold off;
legend(scatter_handles_1, 'Location', 'best');
h_1.NodeLabel = {};

%% Algorithm 2

[communities_2, colors_2] = algorithm_2(A);

% Visualization of the graph partitioning
figure;
h_2 = plot(G, 'NodeCData', communities_2, 'MarkerSize', 4, 'NodeColor', colors_2);
title('Dolphin Social Network - Algorithm 2');
h_2.NodeLabel = {};

% Legend
legend_entries_2 = {'Community 1', 'Community 2'};
hold on;
scatter_handles_2 = gobjects(2, 1);
for i = 1:2
    scatter_handles_2(i) = scatter(NaN, NaN, 100, 'MarkerFaceColor', color_map(i, :), 'DisplayName', legend_entries_2{i});
end
hold off;
legend(scatter_handles_2, 'Location', 'best');

%% Algorithm 3

[communities_3, colors_3, color_map, num_communities, unique_communities] = algorithm_3(A);

% Visualization of the graph partitioning
figure;
h_3 = plot(G, 'NodeCData', communities_3, 'MarkerSize', 4, 'NodeColor', colors_3);
title('Dolphin Social Network - Algorithm 3');
h_3.NodeLabel = {};

% Node color assignment
 for i = 1:num_communities
     highlight(h_3, find(communities_3 == unique_communities(i)), 'NodeColor', color_map(i, :));
 end

% Colorbar of community colors
colormap(color_map);
c = colorbar;
c.Ticks = linspace(0, 1, num_communities);
c.TickLabels = {};
c.Label.String = 'Comunità';

%% Visualization of the magnitudes of the elements of u_1

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
