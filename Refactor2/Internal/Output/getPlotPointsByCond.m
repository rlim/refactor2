function output = getPlotPointsByCond(HRF, nbins, nsubjects, nconditions, component)
    HRF = HRF(:, component);
    p = reshape(HRF, [nbins, nsubjects*nconditions]);
    output = zeros(nbins, nconditions);
    for i = 1:nconditions
        a = p(:, i:i+nconditions:end);
        b = mean(a,2);
        output(:, i) =b; 
        
    end
end