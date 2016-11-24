function experiment = Create_Subjects(scan_information, experiment)
gl = scan_information.GroupList;
if~isempty(gl) gl = rmfield(gl, {'subjectdepth', 'tsum', 'tsum_removed'});end;
set_group_list(experiment, gl);

set_path_to_segs(experiment, scan_information.BaseDir);
set_list_spec(experiment, scan_information.ListSpec);
set_scandir_format(experiment, scan_information.scandir_format);
for i = 1: scan_information.NumSubjects
	new_par = Participant(scan_information.SubjectDirs{i}, experiment, i);
	
	for j=1:size(scan_information.SubjDir(i, :), 2)
		set_run_dirs(new_par, scan_information.SubjDir{i, j});
	end
	set_conditions_list(new_par, get_cond_names(experiment));
	set_num_runs(new_par);
end
end