function [G_J, c_J] = Jacobi_factorization (A, b)
  D = diag (diag (A)); % matrice diagonala dupa A
  % matrice cu opusul elementelor lui A
  % si zerouri pe diagonala principala
  P = D - A; 
  inv_D = inv (D); % inversa lui N 
  G_J = inv_D * P; % matricea de iteratie 
  c_J = inv_D * b; % vectorul de iteratie
endfunction
