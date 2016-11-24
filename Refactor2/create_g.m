function varargout = create_g(varargin)
% --- input form for creation of a G Matrix for applying to normalized subject data
% ---
% --- usage requires user to supply a timing vector file, contents of the form
% ---  subjID~runID~componentName = [ timing onsets . . .];
% ---
% --- it is best if the SubjID and runID equate to subject and run folder names
% --- for example:  C01_run1
% ---
% --- the runID component is optional
% ---

% --- Edit the above text to modify the response to help create_g

% --- Last Modified by GUIDE v2.5 22-Sep-2016 18:56:56

% --- Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
	'gui_Singleton',  gui_Singleton, ...
	'gui_OpeningFcn', @create_g_OpeningFcn, ...
	'gui_OutputFcn',  @create_g_OutputFcn, ...
	'gui_LayoutFcn',  [] , ...
	'gui_Callback',   []);
if nargin && ischar(varargin{1})
	gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
	[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
	gui_mainfcn(gui_State, varargin{:});
end
% --- End initialization code - DO NOT EDIT
end


% --- Executes just before create_g is made visible.
function create_g_OpeningFcn(hObject, eventdata, handles, varargin)
% --- This function has no output args, see OutputFcn.
% --- hObject    handle to figure
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)
% --- varargin   command line arguments to create_g (see VARARGIN)

% --- Choose default command line output for create_g
set ( handles.chk_normalize, 'Visible', 'on' );
handles.normalize_me = 0;
set( hObject, 'Name', 'G Matrix Creation' );
handles.experiment = varargin{1};
participants = varargin{2};
CommonData = varargin{3};
set( handles.lst_subjects, 'String', CommonData.ID_List', 'Value', 1 );
set( handles.lst_runs, 'String', get_run_list(participants(1)), 'Value', 1 );
conds = get_conditions_list(participants(1));
set(handles.run_condition, 'String', conds{1});

set(handles.lst_conditionNames, 'String', get_cond_names(handles.experiment));
handles.lin = '% ------------------------------------------------------';
handles.hdr = '%s\n%% --- NOTE: The sequence of timing onset definitions is critical.\n%% --- All timing onsets must be prepared in the order displayed in this this file.\n%% --- Timing onsets may be inserted directly into this file, or imported from a separate text file\n%% --- All timing onsets imported from a separate text file must be prepared in the order displayed below\n%% --- Any onset condition names in an imported text file WILL BE IGNORED and those listed below will be used, in the order listed below\n%s\n\n';
% --- Update handles structure
guidata(hObject, handles);
% --- UIWAIT makes create_g wait for user response (see UIRESUME)
uiwait(handles.figure1);
end


% --- Outputs from this function are returned to the command line.
function varargout = create_g_OutputFcn(hObject, eventdata, handles)
% --- varargout  cell array for returning output args (see VARARGOUT);
% --- hObject    handle to figure
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

% --- Get default command line output from handles structure
varargout{1} = handles.experiment;
delete(handles.figure1);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% --- hObject    handle to figure1 (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

guidata(handles.figure1, handles);
uiresume(handles.figure1);
end



function txt_timingRate_Callback(hObject, eventdata, handles)
% --- hObject    handle to txt_timingRate (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

str = get(hObject,'String');
str = validate_numeric_entry( str );
set(hObject,'String', str );

create_button_state( handles );
end



% --- Executes on selection change in lst_subjects.
function lst_subjects_Callback(hObject, eventdata, handles)
% --- hObject    handle to lst_subjects (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

% --- If double click
exp = handles.experiment;
participants = get_participants(exp);
participant = participants(get(hObject, 'Value'));
conditions = get_conditions_list(participant);
if size(conditions, 1)<get(handles.lst_runs, 'Value')
	set(handles.lst_runs, 'Value', size(conditions,1));
end
set(handles.lst_runs, 'String', get_run_list(participant));


cond_list = conditions{get(handles.lst_runs, 'Value')};
set(handles.run_condition, 'String', cond_list);
end


% --- Executes during object creation, after setting all properties.
function lst_subjects_CreateFcn(hObject, eventdata, handles)
% --- hObject    handle to lst_subjects (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    empty - handles not created until after all CreateFcns called

% --- Hint: listbox controls usually have a white background on Windows.
% ---      See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end

end



% --- Executes on selection change in lst_conditionNames.
function lst_conditionNames_Callback(hObject, eventdata, handles)
% --- hObject    handle to lst_conditionNames (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

% --- If double click
if strcmp(get(handles.figure1,'SelectionType'),'open')
	btn_selectCondition_Callback( hObject, 0, handles );
end;
end


% --- Executes during object creation, after setting all properties.
function lst_conditionNames_CreateFcn(hObject, eventdata, handles)
% --- hObject    handle to lst_conditionNames (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    empty - handles not created until after all CreateFcns called

% --- Hint: listbox controls usually have a white background on Windows.
% ---      See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in btn_getFileList.
function btn_getFileList_Callback(hObject, eventdata, handles)
% --- hObject    handle to btn_getFileList (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

handles.conditions = (size(get_cond_names(handles.experiment), 1));
guidata(handles.figure1, handles);

[fl, imp] = import_onsets_list( handles, handles.conditions );



if ( length( fl ) > 0 )
	handles.imported_from = imp;
	guidata(handles.figure1, handles);
	eval( [ 'edit ''' fl ''';' ] );
end
set(handles.btn_okay, 'Enable', 'on');
guidata(handles.figure1, handles);
end



% --- Executes on button press in btn_cancel.
function btn_cancel_Callback(hObject, eventdata, handles)
% --- hObject    handle to btn_cancel (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)
guidata(handles.figure1, handles);
uiresume(handles.figure1);
end


% --- Executes on button press in btn_okay.
function btn_okay_Callback(hObject, eventdata, handles)
% --- hObject    handle to btn_okay (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

% --- set( hObject, 'Enable', 'off') ;	% --- avoid users pressing twice when lagging
% --- drawnow();

% handles.output.gh.path_to_segs = [ pwd filesep 'Gsegs' filesep];
% handles.output.gh.subject_encoded = [];
exp = handles.experiment;
participants = get_participants(exp);
TR = get_TR(exp);
% --- Update handles structure
guidata(hObject, handles);
if (~exist( [pwd filesep 'Gsegs'], 'dir' ))  % --- the directory does not exist
	mkdir Gsegs;
end;

gsWidth =get_no_bins(exp) * size(get_cond_names(exp), 1);
onsvec = [];
fid = fopen ( constant_define( 'G_IMPORT_NAME'), 'r' );  % --=

if ( fid )
	num_overrun = 0;
	max_overrun = 0;
	invalid_start_point = 0;
	
	fprintf( 1, 'Expected subject G rank: %d\n\n', gsWidth );
	subRank = [];
	for SubjectNo = 1:size(participants,1)
		id = getID(participants(SubjectNo));
		% ------------------------------------------------------
		% --- produce the full subject G for all subject runs
		% --=   Graw = zeros( numscans_thisrun, gsWidth);
		% ------------------------------------------------------
		G_Raw = cell(get_num_runs(participants(SubjectNo)), 1);
		G_Norm = cell(get_num_runs(participants(SubjectNo)), 1);
		par_conditions = get_conditions_list(participants(SubjectNo));
		gsWidth = get_no_bins(exp) * size(par_conditions{1,1}, 1);
		GG = zeros( gsWidth );
		for RunNo = 1:get_num_runs(participants(SubjectNo))
			run_conditions = par_conditions{RunNo};
			
			if ( get_is_FIR(exp))
				Gr = zeros(get_num_scans(participants(SubjectNo)), gsWidth);
				
			else
				Gr = [];
			end;
			cond = 0;
			for condno = 1:size(run_conditions, 1)
				cond = cond + 1;
				if ~isempty(run_conditions{condno})
					
					
					% --=  % read the next timing onsets line from input file
					% --=
					timings = next_entry( fid ); % --=
					if (~isempty(timings)) % --=
						
						eval( [ 'onsets = [' timings '];' ] ); % --=
						for ii = 1:size(onsets, 2 )
							onsvec = [onsvec onsets(ii) - floor(onsets(ii) )];
						end;
						
						% no NOT!! divide HRF model by TR - that is done in algorithm called later
						if( ~get_in_scans(exp) && get_is_FIR(exp) )
							onsets = onsets / TR;
							scan_hrf_offset = get_displacement(exp);   % seek HRF shape at n.n seconds after event
						else
							scan_hrf_offset = get_displacement(exp)/get_TR(exp);   % seek HRF shape at n.n seconds after event
						end;
						if (get_is_FIR(exp))
							flags = eye(get_no_bins(exp):get_no_bins(exp));
							scan0 = sort(floor(onsets)); 		% --=   absolute scan 0 of event
							onsets = scan0 + 1; 				% --=   always start at scan after event - TODO  add adjust from scan0 by 1 and 2
							
							[~,y] = size(onsets);		% --=
							
							cstart = ( (cond - 1) * get_no_bins(exp) ) + 1;
							cend = cstart + get_no_bins(exp) - 1;
							flagdepth = get_no_bins(exp);
							
							for ii = 1:y  % --=
								
								gMax = min( max(onsets(ii),1)+get_no_bins(exp)-1, get_num_scans(participants(SubjectNo)) );
								fMax = min( get_no_bins(exp), gMax-onsets(ii)+1);
								Gdepth = size(Gr, 1 );
								
								if ( gMax > Gdepth)  	% --= scan depth issue - perhaps should be seconds
									num_overrun = num_overrun + 1;	% --=
									% --=           flagdepth = nbins - (gMax - size(Graw,1) );
									flagdepth = get_no_bins(exp) - (gMax - Gdepth );
									gMax = Gdepth;		% --=
									% --=           max_overrun = max( flagdepth * TR, max_overrun );
									max_overrun = max( flagdepth*get_TR(exp), max_overrun );
								end
								
								if ( max(onsets(ii),1) <= Gdepth )		% --=
									
									Gr(max(onsets(ii), 1):gMax,cstart:cend) = Gr(max(onsets(ii),1):gMax, cstart:cend) + flags(1:flagdepth, :);
								else  % --=
									invalid_start_point = invalid_start_point + 1;  % --=
								end  % --=
							end
						end;  % --= each onset value ---
						
					else  % -- model is HRF
						%
						% 						timings = next_entry( fid ); % --=
						% 						eval( [ 't_dur = [' timings '];' ] ); % --=
						%
						% 						if size(t_dur,2) == 1	% allow a single duration entry to be used as default
						% 							t_durations = ones( size( onsets ) ) * t_dur;
						% 						else
						% 							t_durations = t_dur;
						% 						end;
						%
						% 						t_onsets = calculate_hrf_shape( [onsets' t_durations'], handles.Zheader.timeseries.subject(SubjectNo).run(RunNo,1), TR );
						% 						eval( [ 'Gr' num2str(RunNo) ' = [Gr' num2str(RunNo) ' t_onsets];' ] );
						%
					end  % --- model specific switch ---
				else
					cstart = ( (cond - 1) * get_no_bins(exp) ) + 1;
					cend = cstart + get_no_bins(exp) - 1;
					
				end
			end  % for each condition
			
			G_Raw{RunNo, 1} = cast(Gr, 'logical');
			
			if handles.normalize_me
				mn = mean(Gr);
				Gr = bsxfun(@minus,Gr, mn);
				st = std(Gr);
				if(isempty(find(st==0)))
					Gr = bsxfun(@rdivide,Gr, st);
				else
					for xx =1:size(Gr,2)
						if(st(1,xx) ~=0) 
							Gr(:,xx) = Gr(:,xx)./ st(1,xx);
						end
					end
				end
				% for non encoded conditions
				
				min_val = min(min(Gr));
				x = find(Gr ==0);
				if size(x,1)>0
					Gr(x(:)) = min_val;
				end
				G_Norm{RunNo, 1} = Gr;
			end;
			
			GG_raw = Gr'*Gr;
			GG= GG+GG_raw;
		end  % --= each run ---
		if(~exist([pwd filesep 'Gsegs' filesep 'Graw'], 'dir'))
			mkdir([pwd filesep 'Gsegs' filesep 'Graw']);
		end
		if(~exist([pwd filesep 'Gsegs' filesep 'Gnorm'], 'dir'))
			mkdir([pwd filesep 'Gsegs' filesep 'Gnorm']);
		end
		save([pwd filesep 'Gsegs' filesep 'Graw' filesep id '_G_Raw'], 'G_Raw');
		set_path_to_G_raw(participants(SubjectNo),[pwd filesep 'Gsegs' filesep 'Graw' filesep id '_G_Raw'])
		if handles.normalize_me
			save([pwd filesep 'Gsegs' filesep 'Gnorm' filesep id '_G_Norm'], 'G_Norm');
			set_path_G_norm(participants(SubjectNo), [pwd filesep 'Gsegs' filesep 'Gnorm' filesep id '_G_Norm']);
		end
		clear G_* GG_*
		this_rank = rank( GG );
		
		this_rcond = rcond(GG);
		if ( ~this_rcond > (eps*1.1) )
			
			warning([id ' is ill formed']);
			sr = sprintf( 'Subject %3d: id: %s  rank: %d ', SubjectNo, id, this_rank );
			subRank = [subRank; {sr}];
			
		end;
		
		try
			gg = sqrtm(pinv(GG));
			str = format_value(  sum( sum( gg ) ), '%.2f' );
		catch e
			x = e;
			str = 'ERR';
		end
		save([pwd filesep 'Gsegs' filesep id '_G_Summary.mat'], 'GG', 'gg');
		set_path_to_G_summary(participants(SubjectNo), [pwd filesep 'Gsegs' filesep id '_G_Summary.mat']);
	end;  % --= each subject ---
	set_mean_tr(exp, mean(onsvec));
end  % --- onsets input file opened ---
drawnow();

% --- Update handles structure
guidata(hObject, handles);
uiresume(handles.figure1);
end



% --- Executes on selection change in lst_runs.
function lst_runs_Callback(hObject, eventdata, handles)
% --- hObject    handle to lst_runs (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)
click = get(hObject,'Value');
subject = get(handles.lst_subjects, 'Value');
exp = handles.experiment;
participants = get_participants(exp);
participant = participants(subject);
conditions = get_conditions_list(participant);
set(handles.run_condition, 'String', conditions{click});

end


% --- Executes during object creation, after setting all properties.
function lst_runs_CreateFcn(hObject, eventdata, handles)
% --- hObject    handle to lst_runs (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    empty - handles not created until after all CreateFcns called

% --- Hint: listbox controls usually have a white background on Windows.
% ---      See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in btn_runs_and_conditions.
function btn_runs_and_conditions_Callback(hObject, eventdata, handles)
% --- hObject    handle to btn_runs_and_conditions (see GCBO)
% --- eventdata  reserved - to be defined in a future version of MATLAB
% --- handles    structure with handles and user data (see GUIDATA)

% --- do not allow import in runs and conditions dialog, as not all structure data may be preserved ---
GH = get_G_settings( handles );

x = Runs_and_Conditions( 'zheader',  handles.Zheader, 'scaninfo', handles.scan_information, 'import', 0, 'isHRF', GH.model_type );

if ( ~isempty( x ) )
	handles.Zheader.conditions = x;
	% --- Update handles structure
	guidata(hObject, handles);
	
	
	if ( size(handles.Zheader.conditions.subject,1) > 0 )
		x = max( 1, get(handles.lst_subjects,'Value') );
		y = max( 1, get(handles.lst_runs,'Value') );
		set( handles.lst_conditionNames, 'String', handles.Zheader.conditions.Names', 'Value', handles.Zheader.conditions.subject(x).Run(y).conditions );
	end;
	
	% --- Update handles structure
	guidata(hObject, handles);
	
	% --- save changes to Zheader and scan_information directly
	save_headers()
	
	create_button_state( handles );
end;
end



function GH = get_G_settings ( handles );

GH = structure_define( 'GHEADER' );

GH.conditions = size(handles.Zheader.conditions.Names, 2 );
GH.bins = str2double(get(handles.txt_timeBins,'String'));
GH.TR = str2double(get(handles.txt_timingRate,'String'));
GH.inScans = get(handles.btn_Scans,'Value');
GH.model_type = get(handles.btn_HRF,'Value');

GH.condition_name = handles.Zheader.conditions.Names ;
end



% --- Executes on button press in chk_normalize.
function chk_normalize_Callback(hObject, eventdata, handles)
% hObject    handle to chk_normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.normalize_me = get(hObject,'Value');

% --- Update handles structure
guidata(hObject, handles);
end



% --- Executes on button press in chk_use_source_onsets.
function chk_use_source_onsets_Callback(hObject, eventdata, handles)
% hObject    handle to chk_use_source_onsets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

create_button_state( handles );

end


% --- Executes on selection change in run_condition.
function run_condition_Callback(hObject, eventdata, handles)
% hObject    handle to run_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns run_condition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from run_condition

end
% --- Executes during object creation, after setting all properties.
function run_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to run_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end


end

% --- Executes on button press in Add_Condition.
function Add_Condition_Callback(hObject, eventdata, handles)
% hObject    handle to Add_Condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exp = handles.experiment;
participants = get_participants(exp);
participant = participants(get(handles.lst_subjects, 'Value'));
par_conditions = get_conditions_list(participant);
run_conditions = par_conditions{get(handles.lst_runs, 'Value')};
exp_conditions = get_cond_names(exp);
run_conditions{get(handles.lst_conditionNames, 'Value')} = exp_conditions{get(handles.lst_conditionNames, 'Value'), 1};
set_conditions_list_per_run(participant, run_conditions, get(handles.lst_runs, 'Value'));
set(handles.run_condition, 'String', run_conditions);
guidata(hObject, handles);
end


% --- Executes on button press in remove_condition.
function remove_condition_Callback(hObject, eventdata, handles)
% hObject    handle to remove_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exp = handles.experiment;
participants = get_participants(exp);
participant = participants(get(handles.lst_subjects, 'Value'));
conditions = get_conditions_list(participant);
cond_list = conditions{get(handles.lst_runs,'Value')};
del = 1;
for i = 1:get_num_runs(participant)
	if(i ~= get(handles.lst_runs,'Value') && ischar(conditions{i}{get(handles.run_condition,'Value')}))
		del = 0;
	end
end
if(~del)
	cond_list{get(handles.run_condition,'Value')} = [];
else 
	cond_list(get(handles.run_condition,'Value')) = [];
	if(get(handles.run_condition, 'Value') > size(cond_list, 1))
		set(handles.run_condition, 'Value', size(cond_list, 1));
	end
end
set_conditions_list_per_run(participant, cond_list, get(handles.lst_runs,'Value'));

set(handles.run_condition, 'String', cond_list);
end