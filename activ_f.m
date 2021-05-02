% AKTIVACIONA FUNKCIJA NEURONA SKRIVENOG SLOJA

function y = activ_f(x)

y = 1 / (1 + exp(-x)); % SIGMOIDALNA FUNKCIJA

%y = 1/tanh(x);
end
