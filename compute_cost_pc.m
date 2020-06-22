function cost = compute_cost_pc (points, centroids)
	  % initializez costul total cu 0
    cost = 0; 
    % retin numarul de puncte si numarul de centroizi
    no_points = size (points, 1);
    NC = size (centroids, 1);
    % parcurg punctele
    for i = 1:no_points
      % parcurg centroizii si calculez distanta minima
      % ceea ce reprezinta distanta de la punct la centroidul aferent
      min_dist = norm (centroids(1,:) - points(i,:));
      for j = 2:NC  
        dist = norm (centroids(j,:) - points(i,:));
        if (min_dist > dist)
          min_dist = dist;
        endif  
      endfor
      %adaug la costul total distanta minima
      cost = cost + min_dist;
    endfor
endfunction

