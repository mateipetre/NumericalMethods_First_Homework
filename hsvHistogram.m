function [sol] = hsvHistogram (path_to_image, count_bins)
  % salvez componentele H,S si V  
  % apeland functia de transformare 
  % din RGB in HSV
  [H S V] = transform_rgb_to_hsv (path_to_image);
  [m n] = size (H); % dimensiunea componentelor
  k = 0;
  % indicii din histograma pt fiecare componenta
  % primii count_bins sunt pt H
  % de la count_bins + 1 pana la 2 * count_bins pt S
  % de la 2 * count_bins + 1 pana la 3 * count_bins pt V
  hue = 1;
  sat = hue + count_bins;
  value = sat + count_bins;
  % histograma e un vector linie 
  % cu 3 * count_bins valori pe coloane
  sol = zeros (1, 3 * count_bins);
  % completam histograma cu 3 * count_bins valori pe coloane
  while (k < count_bins)
    % parcurg matricea pe linii 
    % si verific cate valori se afla in fiecare interval
    % din cele count_bins intervale
    for i = 1:m
      for j = 1:n
        % pt componenta H
        if ((H(i,j) >= (1.01 * k / count_bins)) 
           && (H(i,j) < (1.01 * k / count_bins + 1.01 / count_bins)))
          % fiecare element aflat in interval se aduna 
          % la valoarea corespunzatoare din histograma
          % in acest caz pt. H
          sol(1,hue) ++;
        endif
        % pt componenta S
        if ((S(i,j) >= (1.01 * k / count_bins)) 
           && (S(i,j) < (1.01 * k / count_bins + 1.01 / count_bins)))
          sol(1,sat) ++;
        endif
        % pt componenta V
        if ((V(i,j) >= (1.01 * k / count_bins)) 
           && (V(i,j) < (1.01 * k / count_bins + 1.01 / count_bins)))
          sol(1,value) ++;
        endif
      endfor
    endfor
    k = k + 1;
    % merg mai departe pentru
    % fiecare valoare din fiecare 
    % componenta a histogramei
    hue = hue + 1;
    sat = sat + 1;
    value = value + 1;
  endwhile
endfunction