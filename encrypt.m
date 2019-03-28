function [ encryption ] = encrypt( original_dct,key )
[A,B] = size(original_dct);
[C,D,E] = transition_matrix(A,B,key);
noofblock = mat2cell(original_dct,ones(A/8,1)*8,ones(B/8,1)*8);
blocksize = size(noofblock);
scramble = cell(blocksize);
% after generating transformation matrix it will scamble all blocks of image
for i = 1:length(C)
    scramble(i) = noofblock(C(i)); 
end

enc_after_scramble = cell2mat(scramble);


for i  = 1:A
    for j = 1:B
        enc(i,j) = bitxor(abs(enc_after_scramble(i,j)),E(i,j));
        if enc(i,j) == 0 
            enc(i,j)= enc_after_scramble(i,j);
        end
        if(enc_after_scramble(i,j)<0)
            enc(i,j)=-enc(i,j);
        end
    end
end

 encryption = D.*enc;    

end

