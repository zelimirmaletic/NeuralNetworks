% AKTIVACIONA FUNKCIJA NEURONA IZLAZNOG SLOJA

function y = activ_f_iz(x)

%y = 1/ (1 + exp(-x)); % sigmoidalna aktivaciona funkcija

%y = x; % linearna aktivaciona funkcija

y= tanh(x);

