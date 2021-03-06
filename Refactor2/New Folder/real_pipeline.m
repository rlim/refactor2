a = Create_Experiment;
File_List_Creation;
[fn, path] = uigetfile( {'*.txt;*.mat','scan file list text file'}, ...
     'Select your file list text file');
fullpath = [path fn];
fullpath = [pwd filesep 'files.txt'];%%temp
if ~isempty( path )
	scan_information = parse_scan_listing_v5(fullpath);
end
if (scan_information.NumSubjects ~= a.no_participant)
	disp('ERROR: Number of participants is inconsistent');
	return
end
a = Create_Subjects(scan_information, a);
clear scan_information;
[mask, cancelled] = select_mask_image('*.img;*.nii', 'Select your mask.img');
cancelled = 0;
if (cancelled) return; end; %#ok<UNRCH>
%create_mask(a, b);
a = Create_Z(mask, a);
a = Standardize_Z(a, mask);
p = get_participants(a);
a = create_g(a, p, com_dat);
ana = Create_Analysis;
regress_G(ana);
[u,d,v] = compile_CC(ana);
Create_Predictors(u,d,ana);
save('Analysis', 'ana');