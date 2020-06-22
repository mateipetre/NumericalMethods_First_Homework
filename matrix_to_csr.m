function [values, colind, rowptr] = matrix_to_csr (A)
  [n n] = size (A); % retin dimensiunea matricei A
  nz = 0; % initializez nr. de valori nenule
  k = 0; 
  % parcurg matricea A
  % si populez cei 3 vectori conform cerintei
  for i = 1:n 
    is_first = 1; 
    for j = 1:n
      if (A(i,j) != 0) % elementul nu e nul
        nz = nz + 1; 
        values(nz) = A(i,j); 
        colind(nz) = j; 
        if (is_first == 1) % este primul element de pe linie
          rowptr(++k) = nz; 
        endif
        is_first = 0; 
      endif
    endfor
  endfor
  rowptr(++k) = nz + 1;
endfunction