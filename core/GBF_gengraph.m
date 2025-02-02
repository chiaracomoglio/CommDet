% The original version of this function was imported from "GBFlearn: a toolbox for graph signal interpolation
% and classification with graph basis functions (GBFs)" (C) W. Erb 01.03.2020
% This version has been updated by C. Comoglio.

function [nodes,edges,A] = GBF_gengraph(type)

    % File:    GBF_gengraph.m
    %
    % Goal:    Function that generates the graph from different datasets
    %
    % Input:    
    %          type         : 'bunny'           : Stanford Bunny
    %                       : 'minnesota'       : Minnesota Road Graph
    %                       : 'sensor1'         : Small sensors network
    %                       : 'sensor2'         : Medium sensors network
    %  
    % Output:    
    %          nodes        : nodes of the graph G
    %          edges        : edges of the graph
    %          A            : adjacency matrix of the graph G

    switch type

    case 'bunny'
    
      load data_bunny.mat
      nodes = [bunny(:,1),bunny(:,2)];
      thresh = 0.0025;
      N = size(nodes,1);

      % Reduce the number of points to avoid excessive density, according to a defined threshold
      stp = 0;
      for i = 1 : N
        for j = i+1 : N
          if norm( nodes(i,:) - nodes(j,:), 2 ) <= thresh
            stp = stp + 1;
            idx(stp) = j;
          end
        end
      end

      nodes(idx,:)=[];
      r = 0.01;
      [edges,A] = GBF_sim_rballs(nodes,r);
  
    case 'minnesota'
    
      load data_minnesota.mat
      nodes = xy;
      A(349,355)=1;
      A(355,349)=1;
      [row,col] = find(A~=0);
      idxx = find(row < col);
      edges = [row(idxx),col(idxx)];
  
    case 'sensor1'
    
      load data_sensor1.mat
      r = 1/6;
      [edges,A] = GBF_sim_rballs(nodes,r);

    case 'sensor2'
    
      load data_sensor2.mat
      r = 1/6;
      [edges,A] = GBF_sim_rballs(nodes,r);
 
    end

return
