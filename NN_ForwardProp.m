function [net, y] = NN_ForwardProp(dim, w, in)

il = dim(1);
ml = dim(2);
ol = dim(3);

net = zeros(3, ml, ml);
y = zeros(3, ml, ml);

for i = 1 : il
    net(1, i) = in(i);
end

for i = 1 : il
    y(1, i) = net(1, i);
end

for i = 1 : ml
    for j = 1 : il
        net(2, i) = net(2, i) + w(1, i, j) * y(1, j);
    end
end

for i = 1 : ml
    y(2, i) = activ_f(net(2, i)); % Aktivaciona funkcija skrivenog sloja
end

for i = 1 : ol
    for j = 1 : ml
        net(3, i) = net(3, i) + w(2, i, j) * y(2, j);
    end
end

for i = 1 : ol
    y(3, i) = activ_f_iz(net(3, i)); % Aktivaciona funkcija izlaznog sloja 
end