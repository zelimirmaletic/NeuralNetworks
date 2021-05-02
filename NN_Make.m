clc;
close all;

g     = 0.5;              % koeficijent obucavanja
hlc   =  8;              % broj neurona u skrivenom sloju
Emax  =    0.0001;       % maksimalna dozvoljena greska
ICmax =  5000;           % maksimalan broj iteracija

% obucavajuci parovi slozeni u vektore ulaza i izlaza

t_in = 2 .* rand(15, 1);      % vektor ulaza - 10 slucajnih brojeva
%t_in = [0.25 0.487 0.548 0.875 1.125 1.398 1.687 1.75 1.8 1.95];
%t_in = (-1 : 0.1 : 1)'; % vektor ulaza (nisu slucajne vrijednosti)

t_out = FuncToAprox(t_in);  % vekktor izlaza - vrijednost posmatrane funkcije u tackama ulaza

disp('Obucavanje mreze...');
pause(0.1);

dim = [1, hlc, 1];
[c, E] = NN_Teach(dim, t_in, t_out, g, Emax, ICmax, 0);

fprintf('Zavrseno za %d iteracija\n', c);
fprintf('Greska: %.8f\n', E);

w = NN_Load('net.txt', hlc);

t_in = rand(10, 1);   % Testiranje mreze za 10 slucajno odabranih ulaza 

for i = 1 : size(t_in, 1)
    [~, y] = NN_ForwardProp(dim, w, t_in(i, :));
    fprintf('(%.4f) => (%.6f)/(%.6f)\n', t_in(i), y(3, 1), FuncToAprox(t_in(i)));
end