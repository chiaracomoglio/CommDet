# CommDet

A MATLAB package for community detection in graphs.

<br>

<img src="bunny_3_2.png" width="800"> 
Fig. 1 Stanford Bunny - graph partitioning into communities

Description of the Code
-----------------------

The package contains some *MATLAB* functions for graph partitioning into two or more than two communities. The algorithms has been implemented based on the spectral methods introduced by Newman (for more details, see \cite{new06, new13}) based on the maximization of the modularity.

- The function **algorithm_1.m** is used to divide the graph into two disjoint communities, based on the leading eigenvector $u_1$ of the modularity matrix

-	The function **algorithm_2.m** is used to divide the graph into two disjoint communities, based on the eigenvector $u_2$ corresponding to the second largest eigenvalue of the normalized Laplacian

- The function **algorithm_3.m** is used to divide the graph into more than two communities by iteratively applying one of the previous algorithms until no further subdivision increases the graph's modularity

-	The function **algorithm_1_magnitudes is used to visualize the magnitudes of the leading eigenvector $u_1$ of the modularity matrix, computing the saturation based on the values of $u_1$

A simple example for the usage of the functions is provided in the script **example.m**. It shows how to apply the community detection method provided by Algorithm 3 and how to visualize the magnitudes of the elements of $u_1$, demonstrating that, with reference to Algorithm 1, the magnitudes indicate the 'strength' with which the corresponding nodes belong to their respective communities

<br>
