function [ decryption_after_scramble ] = decrypt( decrypt_dct,key )

[A,B] = size(decrypt_dct);
[C,D,E] = transition_matrix(A,B,key);

decrypt_dct = round(decrypt_dct./D);
afterxor=bitxor(E,abs(decrypt_dct));
for i  = 1:A
    for j = 1:B
        afterxor(i,j) = bitxor(abs(decrypt_dct(i,j)),E(i,j));
      
        if(decrypt_dct(i,j)<0)
            afterxor(i,j)=-afterxor(i,j);
        end
    end
end

noofblock_decrypt = mat2cell(afterxor,ones(A/8,1)*8,ones(B/8,1)*8);
blocksize = size(noofblock_decrypt);
decrypt_scramble = cell(blocksize);
% inverse scambling
for i = 1:length(C)
    decrypt_scramble(C(i)) = noofblock_decrypt(i);
end
decryption_after_scramble = cell2mat(decrypt_scramble);

end

