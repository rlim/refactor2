function experiment = Standardize_Z(experiment, mask)
participants = get_participants(experiment);
for i = 1:size(participants,1);
	if ~isempty(get_path_to_Z_raw(participants(i)))
		
		Z_raw = load(get_path_to_Z_raw(participants(i)));
		Z_raw = Z_raw.Z;
	else
		disp('ERROR: Problem reading Z_raw files');
		return;
	end
	Z = cell(size(Z_raw, 1), 1);%#ok<USENS>
	disp(['Standardizing subject: ' getID(participants(i))]);
	for j = 1:size(Z, 1)
		
		disp(['Standardizing run: ' int2str(j)]);
		Z_run = Z_raw{j};
		rSSE  = zeros(1, 6);
		
		%% regression variables
		ts = get_num_scans(participants(i));
		linear = 1:ts;
		linear = linear-ones(1, ts)*mean(linear);
		quadratic = linear.^2;
		quadratic = quadratic - ones(1,ts)*mean(quadratic);
		Z_run = Center_and_STD(Z_run);
		set_tsum_w_trends(participants(i), trace(Z_run*Z_run'));
		X = linear';
		
		%% remove trends
		remove_linear_trends(Z_run);
		remove_quadratic_trends(Z_run);
		if exist([get_full_path_to_segs(participants(i), j) filesep 'rp_*.txt'], 'file')
			hmr_files = dir([get_full_path_to_segs(participants(i), j) filesep 'rp_*.txt']);
			hmr_file = [get_full_path_to_segs(participants(i), j) filesep 'rp_*.txt' filesep hmr_files(1).name];
			remove_head_movement(Z_run, hmr_file);
		end
		inc_tsum_trends(participants(i), trace(Trends*Trends'));
		Z_run = Z_run-Trends;
		
		%% renormalize
		Z_run = Center_and_STD(Z_run);
		inc_tsum(participants(i), trace(Z_run*Z_run'));
		
		%% mask?
		SSQ = [];
		SSQ.Rsd = zeros(1, 5);
		mask_normalization(mask, Z_run, SSQ);
		SS_E = zeros(size(Z, 1), 6);
		SS_E(j, :) = rSSE;
		Z{j} = Z_run;
	end
	set_SSE(participants(i), SS_E);
	if ~exist([pwd filesep 'Z/ZStd'], 'dir')
		mkdir('Z/ZStd');
	end
	save([pwd filesep 'Z' filesep 'ZStd' filesep 'ZStd_' getID(participants(i))], 'Z');
	set_path_to_Z_std(participants(i), ...
		[pwd filesep 'Z' filesep 'ZStd' filesep 'ZStd_' getID(participants(i))]);
end

	function remove_linear_trends(Z)
		beta1 = pinv(X'*X)* X' * Z;
		Trends = X * beta1;
		Zn = Z - Trends;
		rSSE(1) = trace(Zn*Zn');
		rSSE(5) = trace(Z_run*Z_run');
	end
	function remove_quadratic_trends(Z)
		X = [X,quadratic'];
		beta1 = pinv(X'*X)* X' * Z;
		Trends = X * beta1;
		Zn = Z - Trends;
		rSSE(2) = trace(Zn*Zn');
		rSSE(6) = trace(Z_run*Z_run');
	end
	function remove_head_movement(Z, hmr_file)
		G = load(hmr_file);
		X = [X,G];
		beta1 = pinv(X'*X)* X' * Z;
		Trends = X * beta1;
		Zn = Z - Trends;
		rSSE(3) = trace(Zn*Zn');
		rSSE(7) = trace(Z_run*Z_run');
	end
end
