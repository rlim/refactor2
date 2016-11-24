function [txt onsetsfile] = import_onsets_list( handles, numconds )
% will return the file name on successful import
% handles    handles from internal dialogs

txt = '';
onsetsfile = '';

import_file = constant_define( 'G_IMPORT_NAME' );

fullpath = select_file( {'*.m;*.txt', 'mat script or text file'}, ...
	'Select your condition onsets source');
if ~isempty( fullpath )
	
	onsetsfile = fullpath;
	experiment = handles.experiment;
	participants = get_participants(experiment);
	% --------------------------------------------------
	% --- first check that we have the correct number of defined onset variables
	% --------------------------------------------------
	
	% --------------------------------------------------
	% --- how many onset entries are we expecting
	% --------------------------------------------------
	required_onsets = 0;
	subject_onsets = struct( 'Subject', []);
	
	for SubjectNo = 1:size(participants,1)
		s = struct( 'Runs', zeros(1, get_num_runs(participants(SubjectNo)))) ;
		cond_list = get_conditions_list(participants(SubjectNo));
		for RunNo = 1:get_num_runs(participants(SubjectNo))
			for condno = 1:sum(~cellfun(@isempty,cond_list{RunNo,:}))
				required_onsets = required_onsets + 1;
				s.Runs( RunNo ) = s.Runs( RunNo ) + 1;
			end;
		end;
		
		subject_onsets.Subject = [ subject_onsets.Subject; s ];
		
	end;
	%     if ( handles.output.gh.model_type == constant_define( 'HRF_MODEL' ) )
	%         required_onsets = required_onsets * 2;	% -- onsets and durations
	%     end;
	
	% --------------------------------------------------
	% --- how many onset entries are in the file
	% --------------------------------------------------
	found_onsets = 0;
	fid = fopen ( fullpath, 'r' );
	
	while ~feof(fid)
		[~,good] = next_entry( fid );
		if good
			found_onsets = found_onsets + 1;
		end  % --- line text good ---
		
	end  % --- while ~feof() ---
	
	fclose(fid);
	
	if ( found_onsets ~= required_onsets )
		
		str = sprintf( 'Expected Trial count: %d <br>',  required_onsets );
		str = [str sprintf( '   Found Trial count: %d <br>',  found_onsets ) ];
		str = [str sprintf( '<br>Input File: %s <br>',  fullpath ) ];
		
		%      str = sprintf( 'We expected to find %d entries in the timing onset file, but instead encountered %d', required_onsets, found_onsets );
		show_message(  'Mismatched Trial Onsets Count', str );
		return
		
	end;
	
	% --------------------------------------------------
	% --- recreate the template with the onsets values inserted
	% --------------------------------------------------
	
	fid = fopen( import_file, 'w' );
	fidr = fopen ( fullpath, 'r' );
	
	if ( fid )
		
		fprintf( fid, handles.lin, handles.hdr, handles.lin );
		
		for  SubjectNo = 1:size(participants,1)
			s_id = getID(participants(SubjectNo));
			cond_list = get_conditions_list(participants(SubjectNo));
			fprintf( fid, '%s\n%% --- timing onsets for subject %d (%s)\n%s\n', handles.lin, SubjectNo, char(s_id), handles.lin );
			
			for RunNo = 1:get_num_runs(participants(SubjectNo))
				run_id = get_run_id(participants(SubjectNo),RunNo);	
				cond_lst = cond_list{RunNo, 1};
				for cond = 1:size(cond_lst,1)
					
					if ~isempty(cond_lst{cond, :})
					cond_id= get_cond_id(participants(SubjectNo), RunNo, cond);
					var_id = [s_id '_' run_id '_' cond_id ];
					var_id = strrep( var_id, '__', '_' );
					var_id = strrep( var_id, ' ', '_' );
					
					timings = next_entry( fidr );
					if ( fid ) fprintf( fid, '%s = [%s];\n', char(var_id), timings );  end;
					
% 					if ( handles.output.gh.model_type == constant_define( 'HRF_MODEL' ) )
% 						timings = next_entry( fidr );
% 						if ( fid ) fprintf( fid, '%s_dur = [%s];\n', char(var_id), timings );  end;
% 					end;
					end
				end;  % --- each condition ---
				
				fprintf( fid, '\n' );
				
			end;  % --- each subject run ---
			
			fprintf( fid, '\n' );
			
		end;  % --- each subject ---
		
		fclose( fid );
		fclose( fidr );
		txt = import_file;
		onsetsfile = 'source';
		
	end;  % --- template file opened ---
	
	
end;

