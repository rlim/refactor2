function output = getPlotPointsByGroup(HRF, nbins, nsubjects, nconditions, component)
HRF = HRF(:, component);
p = reshape(HRF, [nbins, nsubjects*nconditions]);
output = zeros(nbins, 2);
a = p(:, 1:2:end);
b = p(:, 2:2:end);
c = mean(a,2);
d = mean(b,2);
output(:, 1) = c';
output(:,2) = d';
output = output';
end