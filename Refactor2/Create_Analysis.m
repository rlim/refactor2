function varargout = Create_Analysis(varargin)
% CREATE_ANALYSIS MATLAB code for Create_Analysis.fig
%      CREATE_ANALYSIS, by itself, creates a new CREATE_ANALYSIS or raises the existing
%      singleton*.
%
%      H = CREATE_ANALYSIS returns the handle to a new CREATE_ANALYSIS or the handle to
%      the existing singleton*.
%
%      CREATE_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATE_ANALYSIS.M with the given input arguments.
%
%      CREATE_ANALYSIS('Property','Value',...) creates a new CREATE_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Create_Analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Create_Analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Create_Analysis

% Last Modified by GUIDE v2.5 24-Aug-2016 11:59:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Create_Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @Create_Analysis_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Create_Analysis is made visible.
function Create_Analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Create_Analysis (see VARARGIN)

% Choose default command line output for Create_Analysis
handles.output = hObject;
handles.experiment_list = '';
handles.experiments = {};
handles.regress_G_bool = 0;
handles.regress_GA_bool = 0;
handles.regress_GAA_bool = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Create_Analysis wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Create_Analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if(~isempty(handles))
	varargout{1} = handles.analysis;
	delete(handles.figure1);
else 
	varargout{1} = [];
end


% --- Executes on selection change in Experiments.
function Experiments_Callback(hObject, eventdata, handles)
% hObject    handle to Experiments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Experiments contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Experiments
click = get(hObject, 'Value');
experiment = handles.experiments{click};
participants = get_participants(experiment);
participants_list = [];
set(handles.num_bins, 'String', num2str(get_no_bins(experiment)));
set(handles.TR_num, 'String', num2str(get_TR(experiment)));
set(handles.num_participants, 'String', num2str(size(participants,1)));
z_complete = 1;
g_complete = 1;
for i = 1:size(participants, 1) %%TODO: use commondata instead
	participants_list = [participants_list;{getID(participants(i))}];
	z_complete = z_complete*~isempty(get_path_to_Z_raw(participants(i)));
	g_complete = g_complete*~isempty(get_path_to_G_raw(participants(i)));
end
if(z_complete)
	set(handles.Z_bool, 'String', 'Yes');
else
	set(handles.Z_bool, 'String', 'No');
end
if(g_complete)
	set(handles.G_bool, 'String', 'Yes');
else
	set(handles.G_bool, 'String', 'No');
end
set(handles.Participants, 'String', participants_list);

guidata(handles.figure1, handles);




% --- Executes during object creation, after setting all properties.
function Experiments_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Experiments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_exp.
function load_exp_Callback(hObject, eventdata, handles)
% hObject    handle to load_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exp_filename = select_file({'*.mat', 'mat file'},'Select your experiments');

if(~isempty(exp_filename)) 
	load(exp_filename);
	if(~ismember(a.name, handles.experiment_list))
	handles.experiments = [handles.experiments {a}];
	handles.experiment_list = [handles.experiment_list; {get_experiment_name(a)}];
	set(handles.Experiments, 'String', handles.experiment_list);
	end
end
guidata(hObject, handles);



% --- Executes on selection change in Participants.
function Participants_Callback(hObject, eventdata, handles)
% hObject    handle to Participants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Participants contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Participants


% --- Executes during object creation, after setting all properties.
function Participants_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Participants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Okay.
function Okay_Callback(hObject, eventdata, handles)
% hObject    handle to Okay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isempty(handles.experiment_list))
	ana = Analysis(handles.experiment_list);
	for i = 1:size(handles.experiment_list, 1)
		add_participants(ana, get_participants(handles.experiments{i}));
	end	
	set_regress_G(ana, handles.regress_G_bool)
	set_regress_GA(ana, handles.regress_GA_bool);
	set_regress_GAA(ana, handles.regress_GAA_bool);
	handles.analysis = ana;
else
	warning('No experiments set');
end
guidata(hObject, handles);
uiresume(handles.figure1);



% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);

uiresume(handles.figure1);


% --- Executes on button press in regress_G.
function regress_G_Callback(hObject, eventdata, handles)
% hObject    handle to regress_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of regress_G
handles.regress_G_bool = get(hObject, 'Value');
guidata(hObject, handles);

% --- Executes on button press in regress_GA.
function regress_GA_Callback(hObject, eventdata, handles)
% hObject    handle to regress_GA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of regress_GA
handles.regress_GA_bool =  get(hObject,'Value');
guidata(hObject, handles);


% --- Executes on button press in regress_GAA.
function regress_GAA_Callback(hObject, eventdata, handles)
% hObject    handle to regress_GAA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of regress_GAA
handles.regress_GAA_bool = get(hObject, 'Value');
guidata(hObject, handles);
