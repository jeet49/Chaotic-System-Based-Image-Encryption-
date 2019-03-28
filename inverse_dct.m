function [ invdctimage ] = inversedct( DCT )
T = dctmtx(8);
inversedct = @(structure_block) T' * structure_block.data * T;
invdctimage = blockproc(DCT,[8 8],inversedct);
end

