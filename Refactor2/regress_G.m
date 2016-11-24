function regress_G(analysis)
participants = get_participants(analysis);
if(~exist([pwd filesep 'GZ'], 'dir'))
	mkdir([pwd filesep 'GZ']);
end
if(get_regress_G(analysis))
	%% calculate GZ
	for i = 1:size(participants,1)
		participant = participants(i);
		load(get_Z(participant));

		G = load(get_G(participant));
		G_type = fieldnames(G);
		gg = get_gg(participant);
		eval(['G = G.' G_type{1} ';']);
		assert(exist('Z', 'var') || isempty(Z), 'Z was not found'); %#ok<USENS>
		assert(exist('G', 'var') || isempty(G), 'G was not found');
		assert(size(Z, 1) == size(G,1), 'G and Z have unequal runs'); 
		GZ = cell(get_num_runs(participant), 1);
		B = cell(get_num_runs(participant), 1);
		for j = 1:get_num_runs(participant)
			 G_run = G{j, 1};
			 Z_run = Z{j, 1};
			 assert(size(G_run, 1) == size(Z_run, 1), 'G and Z have different sizes');
			 GZ{j, 1} = G_run'*Z_run;
			 B{j, 1} = gg*GZ{j,1};
			 GC = G_run*gg*B{j,1};
			 set_GC_stand_dev(participant, trace(GC*GC'));
		end
		save([pwd filesep 'GZ' filesep getID(participant)], 'GZ', 'B');
		set_path_to_GZ(participant, [pwd filesep 'GZ' filesep getID(participant)]);
	end
	
end
end