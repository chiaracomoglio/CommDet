% This function is imported from "GBFPUM: a MATLAB Package for Partition of Unity Based 
% Signal Interpolation and Approximation on Graphs"
% (C) 2022 R. Cavoretto, A. De Rossi, W Erb

function s = GBF_RLSGBFPUM(LL,idxdomain,phi,idxWdomain,ydomain,type,alpha,lambda)
%
% File:    GBF_RLSGBFPUM.m
%
% Goal:    Computes a global approximant of the graph signal based on local regularized least squares 
%          GBF approximants and a partition of unity on the graph domain
%
% Input:
%          LL         : graph Laplacian
%          idxdomain  : J subdomains of the PU
%          phi        : Partition of Unity
%          idxWdomain : indices of sampling nodes on subdomains
%          ydomain    : sampling values on subdomains
%          type       : type of kernel for local RLS
%          alpha      : kernel parameters
%          lambda     : regularization parameter for local RLS
%
% Output:
%          s          : The RLS-GBFPUM solution

N = size(LL,1);
J = length(idxdomain);
s = zeros(N,1);

% Generate the global GBF-PUM interpolant
for k = 1:J
    % Calculate local interpolant
    L = LL(idxdomain{k},idxdomain{k});
    % For the Stanford Bunny utilize the eigendecomposition of the Laplacian
    bf = GBF_genGBF(L,idxWdomain{k},type,alpha);
    % For the Minnesota Road Graph utilize successive multiplications
    % bf = GBF_genGBF2(L,idxWdomain{k},type,alpha);
    sdomain = GBF_RLSGBF(bf, idxWdomain{k}, ydomain{k},lambda);
    
    sdomainext = zeros(N,1); 
    sdomainext(idxdomain{k}) = sdomain;
    s = s + sdomainext.*phi(:,k);
end

return
    
