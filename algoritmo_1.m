
function [communities,colors] = algoritmo_1(A)

    % Funzione per la suddivisione del grafo in due comunità 
    % tramite l'ottimizzazione spettrale della modularità
    %
    % INPUT:
    % A: matrice di adiacenza del grafo
    %
    % OUTPUT:
    % communities: vettore contenente le label dei vertici
    % colors: mappa dei colori dei vertici

    % Numero di vertici del grafo
    n = size(A, 1);

    % Vettore con il grado del vertice v_i nella riga i-esima 
    k = sum(A, 2);

    % Numero di lati nel grafo
    m = sum(k) / 2;

    % Matrice di modularità
    B = A - (k * k') / (2 * m);

    % Autovettore principale di B
    [u_1, ~] = eigs(B, 1);

    % Si assegna ciascun vertice a una delle due comunità in base al segno di u_1

    % Inizializzazione del vettore con le label dei vertici
    % con tutti i vertici nella stessa comunità
    communities = ones(n, 1);
    % Si assegna -1 ai vertici corrispondenti a valori negativi di u_1
    communities(u_1 < 0) = -1; 

    % Mappa dei colori basata sui valori di u_1
    colors = zeros(n, 3);
    % Si assegna il colore blu ai vertici corrispondenti a valori positivi o nulli di u_1
    colors(u_1 >= 0, :) = repmat([0, 0, 1], sum(u_1 >= 0), 1);
    % Si assegna il colore rosso ai vertici corrispondenti a valori negativi di u_1
    colors(u_1 < 0, :) = repmat([1, 0, 0], sum(u_1 < 0), 1);

end