function Z = Center_and_STD(Z)
Z_mean = mean(Z);
Z_SD = std(Z);
Z = bsxfun(@minus,Z,Z_mean);
Z = bsxfun(@rdivide, Z, Z_SD);
end