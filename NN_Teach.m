function [c, E] = NN_Teach(dim, train_in, train_out, g, Emax, MaxIterCount, dispStat)

il = dim(1);
ml = dim(2);
ol = dim(3);

train_c = size(train_in);
train_c = train_c(1);

c = 0;
d = zeros(1, ol);
del = zeros(2, ml);
kraj = 0;

w = ones(2, ml, ml) * 0.5;
w(1, 1 : ml, 1 : il) = rand(ml, il);
w(2, 1 : ol, 1 : ml) = rand(ol, ml);
a = g / 20;
w = -a + w .* 2 * a;

while (kraj == 0)
    E = 0;

    if (dispStat == 1)
        fprintf('Iteracija: %d\n', (c + 1));
    end

    for t = 1 : train_c
        if (dispStat == 1)
            fprintf('Ulazni vektor: %.1f %.1f\n', train_in(t, 1), train_in(t, 2));
        end
        
        [net, y] = NN_ForwardProp(dim, w, train_in(t, :));
        
        if (dispStat == 1)
            disp('  Srednji sloj');
            for i = 1 : ml
                fprintf('2 net %d : %.4f\n', i, net(2, i));
                fprintf('2 y %d   : %.4f\n', i, y(2, i));
            end
            
            disp('  Izlazni sloj');
            for i = 1 : ol
                fprintf('3 net %d : %.4f\n', i, net(3, i));
                fprintf('3 y %d   : %.4f\n', i, y(3, i));
            end
        end

        for i = 1 : ol
            d(i) = train_out(t, i);
        end

        for i = 1 : ol
            E = E + 0.5 * (d(i) - y(3, i)) ^ 2;
        end

        if (dispStat == 1)
            fprintf('Greska : %.6f\n', E);
        end

        if (E >= Emax)
            if (dispStat == 1)
                disp('  Delta izlazno');
            end
            for i = 1 : ol
                del(2, i) = (d(i) - y(3, i)) * activ_f_iz_prim(net(3, i));
                if (dispStat == 1)
                    fprintf('3 del %d : %.4f\n', i, del(2, i));
                end
            end

            if (dispStat == 1)
                disp('  Korekcije tezina izlaznog sloja');
            end
            for i = 1 : ol
                for j = 1 : ml
                    dw = g * del(2, i) * y(2, j);
                    w(2, i, j) = w(2, i, j) + dw;
                    if (dispStat == 1)
                        fprintf('3 dw %d %d : %.4f\n', i, j, dw);
                        fprintf('3 w %d %d  : %.4f\n', i, j, w(2, i, j));
                    end
                end
            end

            if (dispStat == 1)
                disp('  Delta srednje');
            end
            for i = 1 : ml
                del(1, i) = 0;
                for j = 1 : ol
                    del(1, i) = del(1, i) + w(2, j, i) * del(2, j);
                end
                del(1, i) = del(1, i) * activ_f_prim(net(2, i));
                if (dispStat == 1)
                    fprintf('2 del %d : %.4f\n', i, del(1, i));
                end
            end

            if (dispStat == 1)
                disp('  Korekcije tezina srednjeg sloja');
            end
            for i = 1 : ml
                for j = 1 : il
                    dw = g * del(1, i) * y(1, j);
                    w(1, i, j) = w(1, i, j) + dw;
                    if (dispStat == 1)
                        fprintf('2 dw %d %d : %.4f\n', i, j, dw);
                        fprintf('2 w %d %d  : %.4f\n', i, j, w(1, i, j));
                    end
                end
            end
        end
    end
    
    c = c + 1;
    
    %fprintf('Iteracija: %6d  Greska: %.10f\n', c, E);
    fprintf('%.10f\n', E);
    
    xdraw = -4 : 0.01 : 4;      % Ovdje se podesava opseg prikazivanja grafickog rezultata
    yreal = FuncToAprox(xdraw);
    
    plot(xdraw, yreal);
    hold on
    plot(train_in, train_out, 'or');
    
    ynetwork = zeros(1, length(xdraw));
    for itemp = 1 : length(xdraw)
        [~, y] = NN_ForwardProp(dim, w, xdraw(itemp));
        ynetwork(itemp) = y(3, 1);
    end
    plot(xdraw, ynetwork, 'g');
    
    hold off
    drawnow;
    
    if ((E < Emax) || (c == MaxIterCount))
        kraj = 1;
    end
end

fid = fopen('net.txt', 'w');

for i = 1 : 2
    for j = 1 : ml
        for k = 1 : ml
            fprintf(fid, '%10.5f', w(i, j, k));
        end
        fprintf(fid, '\n');
    end   
end

fclose(fid);