function experiment = Create_Z(mask, experiment)
if get_is_registered(mask)
    reg_data = enc_mask_registrations(mask);
end
participants = get_participants(experiment);
for i = 1:size(participants, 1)
    experiment_dir = get_path_to_segs(experiment);
    run_dirs = get_run_dir(participants(i));
    Z = cell(get_num_runs(participants(i)), 1);
    disp(['Processing subject: ' getID(participants(i))]);
    for j = 1: get_num_runs(participants(i))
        run_dir = [experiment_dir filesep run_dirs(j,:)];
        scans = dir([run_dir filesep get_list_spec(experiment)]);
        set_num_scans(participants(i), size(scans, 1)); %num_scans is the number of files that match the list_spec
        set_num_columns(participants(i),get_x(mask)); %num_columns is the number of indices of the given mask
        Z_Run = zeros(get_num_scans(participants(i)), get_num_columns(participants(i)));
        
        disp(['Processing run: ' int2str(j)]);
        for k = 1:get_num_scans(participants(i))
            img = cpca_read_vol([run_dir filesep scans(k).name]);
            Z_Run(k, :) = img.image(get_ind(mask))';
        end
        Z{j} = Z_Run;
    end
    
    if ~exist([pwd filesep 'Z'], 'dir')
        mkdir('Z');
        mkdir('Z/ZRaw');
    elseif ~exist([pwd filesep 'Z/ZRaw'], 'dir')
        mkdir('Z/ZRaw');
    end
    save([pwd filesep 'Z' filesep 'ZRaw' filesep 'Z' getID(participants(i))], 'Z');
    set_path_to_Z_raw(participants(i), ...
        [pwd filesep 'Z' filesep 'ZRaw' filesep 'Z' getID(participants(i)) '.mat']);
    
end

end