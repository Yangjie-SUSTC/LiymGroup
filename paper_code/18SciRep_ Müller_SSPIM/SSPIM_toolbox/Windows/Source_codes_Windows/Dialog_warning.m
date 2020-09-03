function varargout = Dialog_warning(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dialog_warning_OpeningFcn, ...
                   'gui_OutputFcn',  @Dialog_warning_OutputFcn, ...
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

function Dialog_warning_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = Dialog_warning_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)

delete(Dialog_warning)
