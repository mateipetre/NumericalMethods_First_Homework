function [sol] = rgbHistogram (path_to_image, count_bins)
  image = imread (path_to_image); % citesc imaginea
  R = image(:,:,1); % componenta R
  G = image(:,:,2); % componenta G
  B = image(:,:,3); % componenta B
  [m n] = size(R); % dimensiunea componentelor
  k = 0;
  % indicii din histograma pt fiecare componenta
  % primii count_bins sunt pt R
  % de la count_bins + 1 pana la 2 * count_bins pt G
  % de la 2 * count_bins + 1 pana la 3 * count_bins pt B
  red = 1; 
  green = red + count_bins;
  blue = green + count_bins;
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
        % pt componenta R
        if ((R(i,j) >= (256 * k / count_bins)) 
           && (R(i,j) < (256 * k / count_bins + 256 / count_bins)))
          % fiecare element aflat in interval se aduna 
          % la valoarea corespunzatoare din histograma
          % in acest caz pt. R
          sol(1,red)++;    
        endif
        % pt componenta G
        if ((G(i,j) >= (256 *k / count_bins)) 
           && (G(i,j) < (256 * k / count_bins + 256 / count_bins)))
          sol(1,green)++;
        endif
        % pt componenta B
        if ((B(i,j) >= (256 * k / count_bins)) 
           && (B(i,j) < (256 * k / count_bins + 256 / count_bins)))
          sol(1,blue)++;
        endif
      endfor
    endfor
    k = k + 1;
    % merg mai departe pentru
    % fiecare valoare din fiecare 
    % componenta a histogramei
    red = red + 1; 
    green = green + 1;
    blue = blue + 1;
  endwhile
endfunction