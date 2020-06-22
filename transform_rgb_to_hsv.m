function [H S V] = transform_rgb_to_hsv (path_to_image)
  image = imread (path_to_image); % citesc imaginea
  R = image(:,:,1); % componenta R
  G = image(:,:,2); % componenta G
  B = image(:,:,3); % componenta B
  [m n] = size (R); % dimensiunea componentelor
  % aplic algoritmul de transformare
  % din rgb catre hsv din cerinta
  for i = 1:m
    for j = 1:n
      % scalez fiecare valoare a componentei
      % la o valoare in [0,1]
      R_p(i,j) = (double)(R(i,j)) / 255;
      G_p(i,j) = (double)(G(i,j)) / 255;
      B_p(i,j) = (double)(B(i,j)) / 255;
      % calculez maximul si minimul
      % dintre valorile pe fiecare linie
      % a componentelor R, G si B
      C_max = max ([R_p(i,j) G_p(i,j) B_p(i,j)]);
      C_min = min ([R_p(i,j) G_p(i,j) B_p(i,j)]);
      % retin diferenta dintre maxim si minim
      delta = C_max - C_min;
      if (delta == 0) % daca diferenta e 0
        H(i,j) = 0;
      else
        if (C_max == R_p(i,j)) % daca maximul e valoarea pe R
          H(i,j) = 60 * mod (((G_p(i,j) - B_p(i,j)) / delta), 6);
        endif
        if (C_max == G_p(i,j)) % daca maximul e valoarea pe G
          H(i,j) = 60 * (((B_p(i,j) - R_p(i,j)) / delta) + 2);
        endif
       if (C_max == B_p(i,j)) % daca maximul e valoarea pe B
         H(i,j) = 60 * (((R_p(i,j) - G_p(i,j)) / delta) + 4);
       endif
      endif
      % scalez valorile pentru H la [0,1]
      H(i,j) = H(i,j) / 360;
      if (C_max == 0) % maximul e 0
        S(i,j) = 0;
      else
        S(i,j) = delta / C_max;
      endif
      V(i,j) = C_max;
    endfor
  endfor
endfunction
