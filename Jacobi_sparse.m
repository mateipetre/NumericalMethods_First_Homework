function [x] = Jacobi_sparse (G_values, G_colind, G_rowptr, c, tol)
  % numarul de elemente care contin indicii 
  % primelor elemente de pe fiecare rand 
  % ale lui G_J 
  n = length (G_rowptr) - 1; 
  prev_x = zeros (n,1); % initializez cu vectorul nul solutia sistemului
  steps = 0; % numarul de pasi pana la solutie
  % iterez pana cand ma aflu sub toleranta
  while 1
    x = csr_multiplication (G_values, G_colind, G_rowptr, prev_x) + c;
    err = norm (x - prev_x);
    % returnez vectorul solutie cand
    % iteratiile se gasesc sub toleranta
    if ((steps == 700) || (err < tol)) % setez si un nr. maxim de iteratii
      return;
    endif
    prev_x = x; 
    steps = steps + 1;
  endwhile
endfunction
