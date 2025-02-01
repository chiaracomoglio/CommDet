% This function is imported from "GBFPUM: a MATLAB Package for Partition of Unity Based 
% Signal Interpolation and Approximation on Graphs"
% (C) 2022 R. Cavoretto, A. De Rossi, W Erb

function [phi,idxWsub,ysub] = GBF_genPUM(edges,cluster,domain,idxW,y)

% File:    GBF_genPUM.m
%
% Goal:    Computes PU based on given graph communities and subdomains
%
% Use:     [phi,idxWsub,ysub] = GBF_genPUM(edges,cluster,domain,idxW,y)
%
% Input:
%           edges       : edges of the graph
%           cluster     : J communities of the graph 
%           domain      : J augmented subdomains of the graph
%           idxW        : indices of the interpolation nodes
%           y           : interpolation values
%
% Output:
%           phi         : PU for subdomains
%           idxWsub     : indices of interpolation nodes in subdomains
%           ysub        : interpolation values in the subdomains

N = max(max(edges));
J = length(cluster);
phi = zeros(N,J);

for k = 1:J
    phi(cluster{k},k) = 1;
    idxWsub{k} = []; ysub{k} = [];  
    for i = 1:length(idxW)
        idx = find(domain{k} == idxW(i));
        if ~isempty(idx)
            idxWsub{k} = [idxWsub{k};idx];
            ysub{k} = [ysub{k};y(i)];
        end
    end
end

return
    