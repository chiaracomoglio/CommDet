% This function is imported from "GBFlearn: a toolbox for graph signal interpolation
% and classification with graph basis functions (GBFs)"
% (C) W. Erb 01.03.2020

function [U,Lambda] = GBF_spectrum(L,stype)

% File:    GBF_spectrum.m
%
% Goal:    Calculates the eigendecomposition of the graph Laplacian L
%
% Input:    
%          L        : A symmetric positive definite matrix
%          stype    : 'ascend' or 'descend' ordering of eigenvalues
%
% Output:    
%          U        : The eigenvectors of L
%          lambda   : The (ordered) eigenvalues of L

[U,Lambda,~]=svd(full(L));
    
[Lambda,inds] = sort(diag(Lambda),stype);
U = U(:,inds);
    
signs=sign(U(1,:));
signs(signs==0)=1;
U = U*diag(signs);
return
