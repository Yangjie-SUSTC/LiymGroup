function varargout = Tiling(varargin)
% TILING MATLAB code for Tiling.fig
%      TILING, by itself, creates a new TILING or raises the existing
%      singleton*.
%
%      H = TILING returns the handle to a new TILING or the handle to
%      the existing singleton*.
%
%      TILING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TILING.M with the given input arguments.
%
%      TILING('Property','Value',...) creates a new TILING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tiling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tiling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tiling

% Last Modified by GUIDE v2.5 12-Jul-2017 19:08:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tiling_OpeningFcn, ...
                   'gui_OutputFcn',  @Tiling_OutputFcn, ...
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


% --- Executes just before Tiling is made visible.
function Tiling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tiling (see VARARGIN)

% Choose default command line output for Tiling
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tiling wait for user response (see UIRESUME)
% uiwait(handles.Tiling);


% --- Outputs from this function are returned to the command line.
function varargout = Tiling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Focal_tiling_start_Callback(hObject, eventdata, handles)
% hObject    handle to Focal_tiling_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Focal_tiling_start as text
%        str2double(get(hObject,'String')) returns contents of Focal_tiling_start as a double


function Focal_tiling_start_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_values(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);

set(h.UsedByGUIData_m.Focal_tiling_start,'String',get(handles.Focal_tiling_start,'String'));
set(h.UsedByGUIData_m.Focal_tiling_end,'String',get(handles.Focal_tiling_end,'String'));
set(h.UsedByGUIData_m.tiling_step,'String',get(handles.tiling_step,'String'));

set(h.UsedByGUIData_m.tiling_text,'String','Tiling is configured.')
set(h.UsedByGUIData_m.tiling_text,'ForegroundColor',[0 0.498 0])

set(h.UsedByGUIData_m.tile_y_n,'Value',2);
set(h.UsedByGUIData_m.tile_y_n,'Enable','on')




function set_Callback(hObject, eventdata, handles)
set_values(hObject, eventdata, handles);
set(handles.Tiling,'Visible','off');

function cancel_Callback(hObject, eventdata, handles)
set(handles.Tiling,'Visible','off');

function apply_Callback(hObject, eventdata, handles)
set(handles.apply,'Enable','off');
h = getappdata(SSPIM_Toolbox);
set_values(hObject, eventdata, handles)
%%% RUN
handles1 = h.UsedByGUIData_m;
SSPIM_Toolbox('Run_Callback',handles1.Run,[],handles1)
getappdata(Tiling);
set(handles.apply,'Enable','on');

function Tiling_CloseRequestFcn(hObject, eventdata, handles)
set(handles.Tiling,'Visible','off');


function Focal_tiling_end_Callback(hObject, eventdata, handles)
% hObject    handle to Focal_tiling_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Focal_tiling_end as text
%        str2double(get(hObject,'String')) returns contents of Focal_tiling_end as a double


% --- Executes during object creation, after setting all properties.
function Focal_tiling_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Focal_tiling_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tiling_step_Callback(hObject, eventdata, handles)
% hObject    handle to tiling_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tiling_step as text
%        str2double(get(hObject,'String')) returns contents of tiling_step as a double


% --- Executes during object creation, after setting all properties.
function tiling_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tiling_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
