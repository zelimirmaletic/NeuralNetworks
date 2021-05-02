% PRVI IZVOD AKTIVACIONE FUNKCIJE SKRIVENOG SLOJA NEURONA

function y = activ_f_prim(x)

y = exp(-x) / ((1 + exp(-x)) ^ 2);  % Prvi izvod sigmoidalne funkcije
%y = - (sinh(x))^2;
%y = - (csc(x)^2);