function [centroids i] = clustering_pc (points, NC)
  % dimensiunea matricei points
  % n puncte cu dims dimensiuni
  [n dims] = size (points);
  index_cluster = 1; % primul cluster 
  % prima parte - initializarea centroizilor
  % creez NC clustere
  % si NC centroizi corespunzatori
  while (index_cluster <= NC)
    %initializez clusterul
    cluster = zeros (n / NC, dims);
    k = 0;
    % un cluster va contine n / NC puncte
    % populez fiecare cluster
    % dupa regula din cerinta
    for i = 1:(n / NC) 
      if ((index_cluster + k * NC) <= n)
        for j = 1:dims % dimensiunile punctelor
          cluster(i,j) = points(index_cluster + k * NC,j);
        endfor
        k = k + 1;
      endif
    endfor
    % populez vectorul de centroizi
    % fiecare centroid e centrul de masa
    % al fiecarui cluster
    for i = 1:dims
      % fac media aritmetica a punctelor din cluster
      centroids(index_cluster,i) = sum (cluster(:,i)) / size (cluster, 1);
    endfor
    index_cluster = index_cluster + 1;
  endwhile
  % a doua parte - stabilizarea centroizilor
  stabil = 0; % nu e stabil
  % creez un nou vector de centroizi
  % pana cand cel nou creat este acelasi cu cel anterior
  while (stabil == 0) 
    % salvez distantele de la puncte la centroizi
    % si formez niste grupuri noi (clustere) de puncte
    for i = 1:n
      dist(i,1) = norm (points(i,:) - centroids(1,:));
      grup(1,i) = 1;
      % parcurg cei NC centroizi
      for j = 2:NC
        % fac distanta pentru acelasi punct 
        % in raport cu toti centroizii 
        dist(i,j) = norm (points(i,:) - centroids(j,:));
        % compar distanta fata de centroidul anterior
        % cu distanta fata de centroidul actual
        % si retin in grup pozitia punctului din vector
        % daca e mai mica
        if (dist(i,j) < dist(i,j-1))
          grup(1,i) = j;
        else
          % altfel caut cel mai apropiat centroid de punct 
          % in continuare prin retinerea distantei
          dist(i,j) = dist(i,j-1);
        endif
      endfor
    endfor
    % creez un nou vector de centroizi
    new_centroids = zeros (NC,dims);
    % vectorul cu numarul de elemente al fiecarui cluster
    % asociat unui centroid din noul vector
    no_elements = zeros (1,NC);
    % parcurg punctele si aplic algoritmul din nou
    % pentru a crea noul vector de centroizi 
    % posibil stabilizat
    for i = 1:n
      for j = 1:dims
        new_centroids(grup(1,i),j) = new_centroids(grup(1,i),j) + points(i,j);
      endfor
      no_elements(1,grup(1,i)) = no_elements(1,grup(1,i)) + 1;
    endfor
    % creez din nou centrul de masa pentru fiecare nou cluster in parte
    % si va rezulta vectorul nou de centroizi
    for i = 1:NC
      if (no_elements(1,i) != 0)
        for j = 1:dims
          % media aritmetica
          new_centroids(i,j) = new_centroids(i,j) / no_elements(1,i); 
        endfor
      endif
    endfor
    % daca noul centroid calculat este egal cu cel vechi
    % inseamna ca s-au stabilizat
    if (centroids == new_centroids)
      stabil = 1; % si ne oprim
    else
      centroids = new_centroids; % altfel continuam 
    endif
  endwhile
endfunction
