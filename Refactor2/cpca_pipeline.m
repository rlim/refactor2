function varargout = cpca_pipeline(varargin)
% CPCA_PIPELINE MATLAB code for cpca_pipeline.fig
%      CPCA_PIPELINE, by itself, creates a new CPCA_PIPELINE or raises the existing
%      singleton*.
%
%      H = CPCA_PIPELINE returns the handle to a new CPCA_PIPELINE or the handle to
%      the existing singleton*.
%
%      CPCA_PIPELINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CPCA_PIPELINE.M with the given input arguments.
%
%      CPCA_PIPELINE('Property','Value',...) creates a new CPCA_PIPELINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cpca_pipeline_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cpca_pipeline_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cpca_pipeline

% Last Modified by GUIDE v2.5 14-Dec-2016 19:54:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cpca_pipeline_OpeningFcn, ...
                   'gui_OutputFcn',  @cpca_pipeline_OutputFcn, ...
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


% --- Executes just before cpca_pipeline is made visible.
function cpca_pipeline_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cpca_pipeline (see VARARGIN)

% Choose default command line output for cpca_pipeline
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cpca_pipeline wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cpca_pipeline_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in create_experiment.
function create_experiment_Callback(hObject, eventdata, handles)
% hObject    handle to create_experiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load_experiment.
function load_experiment_Callback(hObject, eventdata, handles)
% hObject    handle to load_experiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in file_list_creation.
function file_list_creation_Callback(hObject, eventdata, handles)
% hObject    handle to file_list_creation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in select_file_list.
function select_file_list_Callback(hObject, eventdata, handles)
% hObject    handle to select_file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in create_g.
function create_g_Callback(hObject, eventdata, handles)
% hObject    handle to create_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in run_analysis.
function run_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to run_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
