function output_predictor_weights_cpca(HRF, nbins, nsubjects, conditions, condition_names, components)
%takes in: 
%			The series of HRF shapes, usually PR for our purposes
%			number of bins
%			number of subjects
%			conditions struct
%			conditiion names
%			the components that you want to create tables for, eg [1,2] or [2,3]
nconditions =  conditions.allEncoded;
a = cell(nbins,1);
b = cell(nsubjects, 1);
c = cell(nconditions, 1);
for i = 1:nbins
	a{i} = ['Bin:' num2str(i)];
end
for i = 1:nsubjects
	b = ['Subject_' num2str(i)];
	for j = 1:size(conditions.encoded(i).condition, 2)
		if(conditions.encoded(i).condition(j))
			c{(i-1)*nsubjects+j} = [b '_Condition_' strrep(condition_names{j}, ' ', '_') ];
		end
	end
end

for i =1:size(components, 2)
	array = getPlotPointsBySubjectandCondition_cpca(HRF, nbins, components(i));
	subject =1;
	condition =1;
	variable_names = cell(1, size(components,2)+1);
	
% 	for j = 1:size(array,2)
% 		variable_names{1, j} = c{condition};
% 		condition = condition+1;
% 		if(mod(j,nconditions)== 0) 
% 			condition =1;
% 			subject = subject +1;
% 		end
% 	end
	c = c(~cellfun(@isempty, c));
	table = array2table(array, 'RowNames', a, 'VariableNames', c');
	writetable(table, ['Component_' num2str(components(i)) '.csv'], 'Delimiter', ',', 'WriteRowNames', 1);
end

end