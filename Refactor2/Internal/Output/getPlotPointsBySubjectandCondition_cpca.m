function p = getPlotPointsBySubjectandCondition_cpca(HRF, nbins, component)
HRF = HRF(:, component);
p = reshape(HRF, [nbins, size(HRF, 1)/nbins]);
end