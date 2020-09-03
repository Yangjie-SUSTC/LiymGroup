function varargout = SLM(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SLM_OpeningFcn, ...
                   'gui_OutputFcn',  @SLM_OutputFcn, ...
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

function slm_CreateFcn(hObject, eventdata, handles)
% Pix_SS = get(0,'screensize');
% set(hObject,'Position',[Pix_SS(3)./2-307 Pix_SS(4)./2 260 140])

function SLM_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = SLM_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function x_Callback(hObject, eventdata, handles)


function x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_Callback(hObject, eventdata, handles)

function y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ny_Callback(hObject, eventdata, handles)

function Ny_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Nx_Callback(hObject, eventdata, handles)

function Nx_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_values(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.text_r_slm,'String','SLM dimension is configured.')
set(h.UsedByGUIData_m.text_r_slm,'ForegroundColor',[0 0.498 0])
Nx = str2double(get(handles.Nx,'String'));
Ny = str2double(get(handles.Ny,'String'));
if Nx <= 0
    set(handles.Nx,'String',1);
else
    set(handles.Nx,'String',ceil(Nx));
end
if Ny <= 0
    set(handles.Ny,'String',1);
else
    set(handles.Ny,'String',ceil(Ny));
end
set(h.UsedByGUIData_m.Nx,'String',get(handles.Nx,'String'));
set(h.UsedByGUIData_m.Ny,'String',get(handles.Ny,'String'));
x = num2str(str2num(get(handles.x,'String')).*1e-1);
set(h.UsedByGUIData_m.Lx,'String',x);
y = num2str(str2num(get(handles.y,'String')).*1e-1);
set(h.UsedByGUIData_m.Ly,'String',y);

function ok_slm_Callback(hObject, eventdata, handles)
set_values(hObject, eventdata, handles)
set(handles.slm,'Visible','off')

function apply_Callback(hObject, eventdata, handles)
set_values(hObject, eventdata, handles)

function cancel_Callback(hObject, eventdata, handles)
set(handles.slm,'Visible','off')

function slm_CloseRequestFcn(hObject, eventdata, handles)
set(handles.slm,'Visible','off')
