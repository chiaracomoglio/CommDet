% The original version of this function was imported from "GBFPUM: a MATLAB Package for Partition of Unity Based 
% Signal Interpolation and Approximation on Graphs" (C) 2022 R. Cavoretto, A. De Rossi, W Erb. 
% This version has been updated by C. Comoglio.

function [idxdomain] = GBF_domainaugment(edges, idxdomain, R)

% File:     GBF_domainaugment.m
% 
% Goal:     Augments the graph communities
%
% Input:
%           edges     : edges of the graph
%           idxdomain : cell array with the J disjoint graph communities
%           R         : augmentation radius
%
% Output: 
%           idxdomain : cell array with the enlarged subdomains fo the PUM

    J = length(idxdomain);
    for r = 1:R
        for j = 1:J
            idxsub1 = edges(ismember(edges(:,1), idxdomain{j}), 2);
            idxsub2 = edges(ismember(edges(:,2), idxdomain{j}), 1);
            idxsub1 = idxsub1(:);
            idxsub2 = idxsub2(:);
            idxdomain{j} = unique([idxdomain{j}; idxsub1; idxsub2]);
        end
    end
end
