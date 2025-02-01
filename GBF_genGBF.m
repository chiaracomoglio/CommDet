% This function is imported from "GBFlearn: a toolbox for graph signal interpolation
% and classification with graph basis functions (GBFs)"
% (C) W. Erb 15.01.2023

function [bf,pdf] = GBF_genGBF(L, idxW, type, alpha)

% File:    GBF_genGBF.mat
%
% Goal:    Computes K generalized translates of the GBF for the nodes in idxW
%          Uses the spectral decomposition of the graph Laplacian L
%
% Input: 
%          L     : the sparse graph Laplacian
%          idxW  : the indices of the K interpolation nodes
%          type  : type of graph basis function
%          alpha : additional shape parameter
%
% Output:  bf    : matrix with the K basis function vectors
%          pdf   : the generating positive definite function f

N = size(L,1);
K = length(idxW);

% Calculate the Laplacian spectrum
[U,Lambda] = GBF_spectrum(L,'ascend');

% Initialize variables

bf = zeros(N,K);
base = zeros(N,1);

% Generate matrix for the interpolation

switch type
    
  case 'varspline'      % Variational spline kernel
  if length(alpha)==1
      alpha(2) = 0;
  end    
    
  f = (alpha(2)+Lambda).^(-alpha(1));
  f(abs(f)>=1e12) = 0;
  
  case 'diffusion'      % Diffusion kernel
  
  f = exp(-alpha(1)*Lambda);

end

 A = U*diag(f)*U';
 pdf = U*f;

% Compute the matrix of basis vectors

for i=1:K
    base(idxW(i))=1;
    bf(:,i)=A*base;
    base(idxW(i))=0;
end
  
return