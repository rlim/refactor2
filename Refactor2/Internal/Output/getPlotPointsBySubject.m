function output = getPlotPointsBySubject(HRF, nbins, nsubjects, nconditions, component)
HRF = HRF(:, component);
p = reshape(HRF, [nbins, nsubjects*nconditions]);
output = zeros(nbins, nsubjects);
count = 1;
for i = 1:nconditions:nsubjects*nconditions
	a = p(:, i:i+nconditions-1);
	b = mean(a, 2);
	output(:, count) = b;
	count = count+1;
end
end