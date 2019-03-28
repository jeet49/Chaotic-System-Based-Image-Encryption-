
function [ B ] = dct_bitmasking( J, type)
T = dctmtx(8);
cosinetransformation = @(structure_block) T * structure_block.data * T';
B = blockproc(J,[8 8],cosinetransformation);


mask = [1   1   1   1   1   1   0   0  
        1   1   1   1   1   0   0   0  
        1   1   1   1   0   0   0   0  
        1   1   1   0   0   0   0   0  
        1   1   0   0   0   0   0   1
        1   1   0   1   0   0   1   0  
        0   0   0   0   1   0   0   0  
        0   1   0   0   0   0   0   0 ];
 B2 = blockproc(B,[8 8],@(structure_block) mask .* structure_block.data);


end

