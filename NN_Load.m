function w = NN_Load(fn, ml)

fid = fopen(fn, 'r');

w = zeros(2, ml, ml);

for i = 1 : 2
    for j = 1 : ml
        for k = 1 : ml
            w(i, j, k) = fscanf(fid, '%f', 1);
        end
    end   
end

fclose(fid);