# CommDet

**A MATLAB package for community detection applied to GBF-PUM signal approximation on graphs.**

<br>

<img src="bunny_3_2.png" width="500"> 
Fig. 1 Stanford Bunny - graph partitioning into disjoint communities

Description of the Code
-----------------------

The package contains several MATLAB functions, some for graph partitioning into two or more disjoint communities, and others for applying a GBF-PUM signal approximation scheme on graphs. The community detection algorithms are an implementation of the spectral methods introduced by M. Newman (for more details, see [1] and [2]) based on the maximization of the modularity. The routines for the kernel-based interpolation scheme based on a Partition of Unity Method, instead, are imported (and, in some cases, updated) from [5] and [6].

- The function **algorithm_1.m** is used to divide the graph into two disjoint communities, based on the leading eigenvector $u_1$ of the modularity matrix, while **algorithm_1_magnitudes.m** is used to visualize the magnitudes of $u_1$

- The function **algorithm_2.m** is used to divide the graph into two disjoint communities, based on the eigenvector $u_2$ corresponding to the second largest eigenvalue of the normalized Laplacian

- The function **algorithm_3.m** is used to divide the graph into more than two communities by iteratively applying one of the previous algorithms until no further subdivision increases the graph's modularity

- The function **calculate_modularity.m** is used to compute the modularity of a given graph partition

- The functions **GBF_gengraph.m** and **GBF_sim_rballs.m** are imported from [6] and used to generate the graph from different datasets.

A simple example for the usage of these functions is provided in the script **example_communities.m**. It shows how to apply the community detection method provided by Algorithm 3 and how to visualize the magnitudes of the elements of $u_1$, demonstrating that, with reference to Algorithm 1, the magnitudes indicate the 'strength' with which the corresponding nodes belong to their respective communities.

- The functions **GBF_domainaugment.m**, **GBF_genPUM.m** are imported (and, in the first case, updated) from [5] and used to generate a partition of unity on the graph, starting from the disjoint communities obtained through Algorithm 3

- The functions **GBF_genGBF.m**, **GBF_genGBF2.m**, **GBF_RLSGBF.m** are imported from [5], [6] and provide a solution of the local interpolation problems and **GBF_RLSGBFPUM.m** calculates the global GBF-PUM signal approximation

- The functions **GBF_spectrum.m** and **GBF_drawsignal.m** are imported from [6] and used to, respectively, calculate the eigendecomposition of the graph Laplacian and draw the signal on the nodes of the graph

<br>

Citation and Credits
--------------------

The theory on the spectral methods for community detection in graphs implemented can be found in:

*   [1] &nbsp; Newman, M. E. <br>
    <i> Finding community structure in networks using the eigenvectors of matrices  </i> <br>
    Phys. Rev. E. 74(3), 036104 (2006)

*   [2] &nbsp; Newman, M. E. <br>
    <i> Spectral methods for community detection and graph partitioning  </i> <br>
    Phys. Rev. E. 88(4), 042822 (2013)

The theory on graph basis functions (GBFs) for kernel-based signal interpolation on graphs is given in:

*   [3] &nbsp; Cavoretto, R., De Rossi, A., Erb, W. <br>
    <i> Partition of Unity Methods for Signal Processing on Graphs </i> <br>
    J. Fourier Anal. Appl. 27 (2021), Art. 66  

*   [4] &nbsp; Erb, W. <br>
    <i> Graph Signal Interpolation with Positive Definite Graph Basis Functions  </i> <br>
    Appl. Comput. Harmon. Anal. 60 (2022), 368-395
    
Some of the routines are imported from the following packages:

*   [5] &nbsp;  Erb, W. <br>
    GitHub: https://github.com/WolfgangErb/GBFPUM

*   [6] &nbsp;  Erb, W. <br>
    GitHub: https://github.com/WolfgangErb/GBFlearn
 
<br>
