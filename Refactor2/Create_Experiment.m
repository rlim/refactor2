function varargout = Create_Experiment(varargin)
% CREATE_EXPERIMENT MATLAB code for Create_Experiment.fig
%      CREATE_EXPERIMENT, by itself, creates a new CREATE_EXPERIMENT or raises the existing
%      singleton*.
%
%      H = CREATE_EXPERIMENT returns the handle to a new CREATE_EXPERIMENT or the handle to
%      the existing singleton*.
%
%      CREATE_EXPERIMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATE_EXPERIMENT.M with the given input arguments.
%
%      CREATE_EXPERIMENT('Property','Value',...) creates a new CREATE_EXPERIMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Create_Experiment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Create_Experiment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Create_Experiment

% Last Modified by GUIDE v2.5 03-Aug-2016 12:42:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
	'gui_Singleton',  gui_Singleton, ...
	'gui_OpeningFcn', @Create_Experiment_OpeningFcn, ...
	'gui_OutputFcn',  @Create_Experiment_OutputFcn, ...
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

end
% --- Executes just before Create_Experiment is made visible.
function Create_Experiment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Create_Experiment (see VARARGIN)

% Choose default command line output for Create_Experiment
handles.output = hObject;
set (handles.btn_Scans, 'Value', 1 );
set (handles.btn_Seconds, 'Value', 0 );
handles.cond_names = {};
handles.exp_name = '';
handles.bins = 0;
handles.TR=1;
handles.num_par=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Create_Experiment wait for user response (see UIRESUME)
uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = Create_Experiment_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if ~isempty(handles)
	varargout{1} = handles.output;
	
	delete(hObject);
else
	varargout{1} = 0;
end
end

function exp_name_Callback(hObject, eventdata, handles)
% hObject    handle to exp_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_name as text
%        str2double(get(hObject,'String')) returns contents of exp_name as a double
handles.exp_name= get(hObject, 'String');

guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function exp_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end



function no_bins_Callback(hObject, eventdata, handles)
% hObject    handle to no_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of no_bins as text
%        str2double(get(hObject,'String')) returns contents of no_bins as a double
handles.bins = str2double(get(hObject, 'String'));
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function no_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to no_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in btn_Seconds.
function btn_Seconds_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Seconds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btn_Seconds
this_btn = get(hObject,'Value'); % --- returns toggle state of btn_HRF
if ( this_btn == 1 )
	set ( handles.btn_Scans, 'Value', 0 );
else
	set ( handles.btn_Scans, 'Value', 1 );
end

guidata(hObject, handles);
end


% --- Executes on button press in btn_Scans.
function btn_Scans_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Scans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btn_Scans
this_btn = get(hObject,'Value'); % --- returns toggle state of btn_HRF
if ( this_btn == 1 )
	set ( handles.btn_Seconds, 'Value', 0 );
else
	set ( handles.btn_Seconds, 'Value', 1 );
end
guidata(hObject, handles);
end



function no_TR_Callback(hObject, eventdata, handles)
% hObject    handle to no_TR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of no_TR as text
%        str2double(get(hObject,'String')) returns contents of no_TR as a double
handles.TR = str2double(get(hObject, 'String'));
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function no_TR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to no_TR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end



function num_participants_Callback(hObject, eventdata, handles)
% hObject    handle to num_participants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_participants as text
%        str2double(get(hObject,'String')) returns contents of num_participants as a double
handles.num_par = str2double(get(hObject, 'String'));
guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function num_participants_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_participants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end


function condition_name_Callback(hObject, eventdata, handles)
% hObject    handle to condition_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of condition_name as text
%        str2double(get(hObject,'String')) returns contents of condition_name as a double
handles.cond_name_temp = get(hObject, 'String');
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function condition_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to condition_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end



% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cond_names = [handles.cond_names;{handles.cond_name_temp}];
set(handles.condition_name, 'String', '');
set(handles.lst_conditions, 'String', handles.cond_names, 'Value', 1);
guidata(hObject, handles);
end


% --- Executes on selection change in lst_conditions.
function lst_conditions_Callback(hObject, eventdata, handles)
% hObject    handle to lst_conditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lst_conditions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lst_conditions
end


% --- Executes during object creation, after setting all properties.
function lst_conditions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lst_conditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in Okay.
function Okay_Callback(hObject, eventdata, handles)
% hObject    handle to Okay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

newExp = Experiment(handles.exp_name);
set_no_bins(newExp, handles.bins);
set_TR(newExp, handles.TR);
set_no_participants(newExp, handles.num_par);
set_in_scans(newExp, get(handles.btn_Scans,'Value'));
set_cond_names(newExp, handles.cond_names)
handles.output = newExp;
guidata(hObject, handles);
uiresume;
end

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = [];
guidata(hObject, handles);
uiresume;
end


% --- Executes during object deletion, before destroying properties.
function uipanel1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = [];
guidata(hObject, handles);
uiresume;
end
