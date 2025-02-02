% The original version of this script was imported from "GBFlearn: a toolbox for graph signal interpolation
% and classification with graph basis functions (GBFs)" (C) W. Erb 15.01.2023
% This version has been updated by C. Comoglio and integrated with a new approach of community detection.

% Example script to see how a community detection method can be combined
% with a GBF-PUM signal approximation scheme

% Test scenario:
% Number of interpolation nodes: N = 100
% Kernel: variational spline (s=2, epsilon=0.01)
% Augmentation radius: R = 2 

clear all; close all; format short e; 

% Paths
addpath(genpath('./data/'))
addpath(genpath('./core/'))

% Choose the graph (Stanford Bunny)
G.type = 'bunny';
load data_bunny.mat % loads nodeselect

% Generate the graph
[G.nodes,G.edges,G.A] = GBF_gengraph(G.type);

% Calculate the normalized graph Laplacian
G.N = length(G.nodes(:,1));
G.deg = sum(G.A,1);
isD = diag(1./sqrt(G.deg));
G.L = eye(G.N) - isD*G.A*isD;

% Calculate Spectrum of Laplacian
[G.U,G.Lambda] = GBF_spectrum(G.L,'ascend');

% Choose plotting parameter
plotpar.MM = 1;                % size of dots
plotpar.ub = 0.02;             % upper boundary
plotpar.lb = 0.02;             % left boundary
plotpar.uaxis = 1.15;          % upper colorbar boundary 
plotpar.laxis = -0.15;         % lower colorbar boundary
plotpar.fontsize = 14;         % fontsize
plotpar.colorbar = 'n';        % set 'y' if you want a colorbar
plotpar.edge = 0;              % set 1 if you want to plot edges    

% Test function: bandlimited function u4
f = G.U(:,4);

% Choose number of interpolation nodes and sampling data
N = 100;                      
idxW = nodeselect(1:N)'; 
y = f(idxW);

% Augmentation radius for PUM subdomain enlargement
R = 2;               

% Kernel parameters for interpolation (variational splines)
type = 'varspline';
alpha = [2,0.01];

% Generate Partition of Unity

% Division of the graph in J disjoint communities
[community_label, ~, ~, J, ~] = algorithm_3(G.A);

% Transformation in a cell array
communities = cell(J, 1);
for i = 1:J
    communities{i} = find(community_label == i);
end

% Augment the communities to subdomains for the PUM
[idxdomain]=GBF_domainaugment(G.edges,communities,R);

% Generate the partition of unity
[phi,idxWdomain,ydomain]=GBF_genPUM(G.edges,communities,idxdomain,idxW,y);

% Calculate the global GBF-PUM interpolant
s = GBF_RLSGBFPUM(G.L,idxdomain,phi,idxWdomain,ydomain,type,alpha,0);

% Compute errors
rmaerr = norm(s(:)-f,inf)/norm(f,inf);            % relative max absolute error
rrmserr = norm((s(:)-f))/norm(f)/sqrt(length(f));  % relative rms error

% Print errors
fprintf('no. points\t rmaerr \t rrmserr \n')
fprintf('\t%4d\t %.3e\t %.3e\n ',N,rmaerr,rrmserr);

%% Plot PUM subdomains
for k = 1:J
  figure('Units', 'pixels', 'Position', [0 50 600 600]);
  GBF_drawsignal(G.nodes,G.edges,phi(:,k),plotpar);
  title([num2str(k),'. Subdomain'])
  hold on
  % Nodes not in the current subdomain (obtained as difference between all the nodes and the nodes in the current subdomain) in lighter tone
  inddiff = setdiff((1:G.N)',idxdomain{k}); 
  plot( G.nodes(inddiff,1),G.nodes(inddiff,2),'.','color',[208,209,230]/255,'LineWidth',1,'MarkerSize',10)
  hold on
  % Interpolation nodes in the current subdomain circled in black
  plot( G.nodes(idxdomain{k}(idxWdomain{k}),1),G.nodes(idxdomain{k}(idxWdomain{k}),2),'o','color',[0, 0, 0]/255,'LineWidth',1,'MarkerSize',5)
  hold on
  set(gca,'XTick',[], 'YTick', [])
  hold off
end

%% Global GBF-PUM interpolant

plotpar.colorbar = 'y'; % to have a colorbar
plotpar.uaxis = max(s); % upper colorbar boundary
plotpar.laxis = min(s); % lower colorbar boundary

figure('Units', 'pixels', 'Position', [0 50 600 600]);
GBF_drawsignal(G.nodes,G.edges,s,plotpar);
title('Global GBF-PUM Interpolation')
hold on
plot( G.nodes(idxW,1),G.nodes(idxW,2),'o','color',[0, 0, 0]/255,'LineWidth',1,'MarkerSize',5)
hold on
set(gca,'XTick',[], 'YTick', [])
hold off

%% Absolute interpolation error

plotpar.uaxis = max(abs(f-s(:)));
plotpar.laxis = 0;

figure('Units', 'pixels', 'Position', [0 50 600 600]);
GBF_drawsignal(G.nodes,G.edges,abs(f-s(:)),plotpar);
title('Absolute interpolation error');
hold on;
plot(G.nodes(idxW, 1), G.nodes(idxW, 2), 'o', 'color', [0, 0, 0] / 255, 'LineWidth', 1, 'MarkerSize', 5)
set(gca,'XTick',[], 'YTick', [])
hold off;
