% GBFPUM: a MATLAB Package for Partition of Unity Based 
% Signal Interpolation and Approximation on Graphs
% (C) 2022 R. Cavoretto, A. De Rossi, W Erb

function bf = GBF_genGBF2(L,idxW,type,alpha)

% File:    GBF_genGBF2.m
%
% Goal:    Computes K generalized translates of the GBF for the nodes in idxW 
%          Uses repeated multiplications
%          (reduced implementation: contains only variational splines)
%
% Use:     bf = GBF_genGBF(L,idxW,type,alpha)
%          (reduced implementation: contains only variational splines)
%
% Input:
%          L     : NxN matrix - the sparse graph Laplacian
%          idxW  : K vector - the indices of the K interpolation nodes
%          type  : type of graph basis function
%          alpha : additional shape parameter
%
% Output:
%          bf    : NxK matrix with the K basis function vectors

N = size(L,1);

% Initialize variables
bf = speye(N);
bf = bf(:,idxW);

% Generate matrix for the interpolation
switch type
    
  case 'varspline'         % Variational spline kernel
  if length(alpha)==1
      alpha(2) = 0;
  end
  
  if (sign(alpha(1))==-1) && (mod(alpha(1),1) == 0) 
      LS = (alpha(2)*speye(N)+L); 
      for i = 1:abs(alpha(1))
          bf = LS\bf;
      end
  elseif (sign(alpha(1))==1) && (mod(alpha(1),1) == 0)
      LS = (alpha(2)*speye(N)+L);  
      for i = 1:alpha(1)
          bf = LS*bf;
      end
  end

  case 'trivial'
      
end

return
