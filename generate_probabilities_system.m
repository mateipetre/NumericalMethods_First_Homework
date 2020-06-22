function [A, b] = generate_probabilities_system (rows)
  no_rows = 0;
  % calculez numarul de linii/coloane ale matricei A
  for i = 1:rows
    no_rows = no_rows + i;
  endfor
  % initializez elementele care nu se mai schimba
  % indiferent de valoarea lui rows
  A = zeros (no_rows,no_rows);
  A(1,1) = 4;
  A(1,2) = A(1,3) = A(2,1) = A(2,3) = A(2,4) = -1;
  A(2,5) = A(3,1) =  A(3,2) = A(3,5) = A(3,6) = -1;
  A(2,2) = A(3,3) = 5;
  k = 1;
  l = m = 2;
  n = 3;
  index_row = 3; % labirintul are minim 3 randuri
  % am impartit matricea in 4
  while  (index_row <= rows) % pana cand a ajuns la ultimul rand
    index_col = m+l;
    if (rows == index_row) % ne aflam pe ultimul rand
      % pana cand parcurgem toate coloanele lui A
      while (index_col <= (1 + l + n)) 
        % nu e ultima coloana
        % initializez elementele din partea dreapta superioara
        % si partea stanga inferioara 
        if ((index_col != (m+l)) && (index_col != (1 + n + l)))
          A(index_col,index_col) = 5; %pe diagonala principala
          A(index_col,index_col+1) = A(index_col,index_col - l - 1) = -1;
          A(index_col,index_col-1) = A(index_col,index_col-l) = -1;
        endif
        if (index_col == (m+l))
          A(m+l,m) = A(m+l,m + l + 1) = -1;
          A(m+l,m+l) = 4;
        endif 
        if (index_col == (1 + n + l))
          A(n + l + 1,n) = A(n + l + 1,n+l) = -1;
          A(n + l + 1,n + l + 1) = 4;
        endif
        index_col = index_col+1; %parcurg mai departe coloanele
      endwhile
    endif
    % nu sunt pe ultimul rand
    if (rows != index_row)
      %initializez "diagonalele secundare" cu -1
      while (index_col <= (1 + l + n))
        if ((index_col != (m+l)) && ((1 + n + l) != index_col))
          A(index_col,index_col+1) = A(index_col,index_col-l) = -1;
          A(index_col,index_col-1) = -1;
          A(index_col,index_col - k + 2 * l) = -1;
          A(index_col,index_col - k + 2 * l + 1) = -1;
          A(index_col,index_col - l - 1) = -1;
          A(index_col,index_col) = 6; % pe diagonala principala central
        endif
        if ((m+l) == index_col)
          A(m+l,m) = A(m+l,m + l + 1) = -1;
          A(m+l,2 * l + m +2) = A(m+l,2 * l + m + 1) = -1;
          A(m+l,m+l) = 5; % pe diagonala principala
        endif
        if ((1 + n + l) == index_col)
          A(n + l + 1,n) = A(n + l + 1,2 * l + n + 2) = -1;
          A(n + l + 1,2 * l + n + 3) = A(n + l + 1,n+l) = -1;
          A(n + l + 1,n + l + 1) = 5;
        endif
        index_col = index_col+1; % parcurg mai departe coloanele
      endwhile
    endif
    m = m+l;
    k = k+1; 
    n = n + l + 1;
    l = l+1;
    index_row = index_row + 1; % parcurg mai departe liniile
  endwhile
  % vectorul coloana are (numar linii A - numar randuri)
  % zerouri la inceput
  b = zeros([(no_rows - rows) 1]); 
  b = [b ; ones([rows 1])]; % iterez 1 dupa zerouri cat numarul de randuri
endfunction