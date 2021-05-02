function y = FuncToAprox(x)

 y = (exp(x+2) - exp(-x+2))./(exp(x+4)+exp(-x+4));
 % y = x .^ 2;
 % y = 1 - (x - 1) .^ 2;
 % y = (x + 2) / 4;
 %y = 3 - 2 * x;
 %y= x .^3;
 
end