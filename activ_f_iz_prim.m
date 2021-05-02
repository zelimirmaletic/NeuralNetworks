%  PRVI IZVOD AKTIVACIONE FUNKCIJE IZLAZNOG SLOJA NEURONA

function y = activ_f_iz_prim(x)

%y = exp(-x) / ((1 + exp(-x)) ^ 2); % Prvi izvod sigmoidalne funkcije

%y = 1; % prvi izvod linearne funkcije
 
y = 1 - (tanh(x))^2;
