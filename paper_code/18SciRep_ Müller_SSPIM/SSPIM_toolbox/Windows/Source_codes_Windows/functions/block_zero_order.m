function [out] = block_zero_order(ini)
[r c] = size(ini);
ini(r/2-20:r/2+20,c/2-20:c/2+20) = 0;
out = ini;