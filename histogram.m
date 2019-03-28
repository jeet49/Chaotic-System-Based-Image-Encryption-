function [histogram_image] = histogram(T)
[A,B] = size(T);
hist = zeros(1, 256);
for i=1:A
    for j= 1:B
        if(T(i,j)>255)|| (T(i,j)<0)
            continue;
        end
        hist(T(i,j)+1) =  hist(T(i,j)+1)+1;
    end
end
end