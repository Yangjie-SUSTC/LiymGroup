function varargout = Damman_Grating(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Damman_Grating_OpeningFcn, ...
                   'gui_OutputFcn',  @Damman_Grating_OutputFcn, ...
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

function Damman_Grating_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = Damman_Grating_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function N_G_Callback(hObject, eventdata, handles)

function N_G_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function C_DG1_Callback(hObject, eventdata, handles)

function C_DG1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function N_DG2_Callback(hObject, eventdata, handles)

function N_DG2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function C_DG2_Callback(hObject, eventdata, handles)

function C_DG2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v_DG_Callback(hObject, eventdata, handles)
set(handles.v_DG,'Value',1)
set(handles.h_DG,'Value',0)

function h_DG_Callback(hObject, eventdata, handles)
set(handles.h_DG,'Value',1)
set(handles.v_DG,'Value',0)


function set_values(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
pop1 = get(handles.popupmenu1,'Value');

switch pop1 
    case 1
    
    %#%-------------------------Damman Grating---------------------------------
    set(h.UsedByGUIData_m.DG,'Value',1);
    set(h.UsedByGUIData_m.OG,'Value',0);
    set(h.UsedByGUIData_m.N_DG1,'String',get(handles.N_G,'String'));
    set(h.UsedByGUIData_m.C_DG1,'String',get(handles.C_G,'String'));
    set(h.UsedByGUIData_m.N_DG2,'String',get(handles.N_G,'String'));
    set(h.UsedByGUIData_m.C_DG2,'String',get(handles.C_G,'String'));
    set(h.UsedByGUIData_m.v_DG,'Value',get(handles.v_DG,'Value'));
    set(h.UsedByGUIData_m.h_DG,'Value',get(handles.h_DG,'Value'));
    set(h.UsedByGUIData_m.DG_1D,'Value',1);
    set(h.UsedByGUIData_m.DG_2D,'Value',0);
    set(h.UsedByGUIData_m.beam_array_r_txt,'ForegroundColor',[0 0.498 0])
    set(h.UsedByGUIData_m.beam_array_r_txt,'String','Array beam is configured.')
    
    %#%-------------------------Optimal Grating--------------------------------
    case 2
    set(h.UsedByGUIData_m.DG,'Value',0);
    set(h.UsedByGUIData_m.OG,'Value',1);
    set(h.UsedByGUIData_m.N_OG1,'String',get(handles.N_G,'String'));
    set(h.UsedByGUIData_m.C_OG1,'String',get(handles.C_G,'String'));
    set(h.UsedByGUIData_m.v_OG,'Value',get(handles.v_DG,'Value'));
    set(h.UsedByGUIData_m.h_OG,'Value',get(handles.h_DG,'Value'));
    set(h.UsedByGUIData_m.OG_1D,'Value',1);
    set(h.UsedByGUIData_m.beam_array_r_txt,'ForegroundColor',[0 0.498 0])
    set(h.UsedByGUIData_m.beam_array_r_txt,'String','Array beam is configured.')
end
set(h.UsedByGUIData_m.array_beam_y_n,'Enable','on')



function h_OG_Callback(hObject, eventdata, handles)
set(handles.h_DG,'Value',1)
set(handles.v_DG,'Value',0)

function v_OG_Callback(hObject, eventdata, handles)
set(handles.h_DG,'Value',0)
set(handles.v_DG,'Value',1)

function edit8_Callback(hObject, eventdata, handles)

function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function C_G_Callback(hObject, eventdata, handles)

function C_G_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function N_OG1_Callback(hObject, eventdata, handles)

function N_OG1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DG_Callback(hObject, eventdata, handles)




function OG_Callback(hObject, eventdata, handles)


function set_Callback(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.array_beam_y_n,'Value',2);
set_values(hObject, eventdata, handles)
set(handles.damman_grating,'Visible','off')

function apply_Callback(hObject, eventdata, handles)
set(handles.apply,'Enable','off');
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.array_beam_y_n,'Value',2);
set_values(hObject, eventdata, handles)
%%% RUN
handles1 = h.UsedByGUIData_m;
SSPIM_Toolbox('Run_Callback',handles1.Run,[],handles1)
getappdata(Damman_Grating);
set(handles.apply,'Enable','on');


function cancel_Callback(hObject, eventdata, handles)
set(handles.damman_grating,'Visible','off')

function damman_grating_CloseRequestFcn(hObject, eventdata, handles)
set(handles.damman_grating,'Visible','off')


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
pop1 = get(handles.popupmenu1,'Value');
switch pop1
    case 1
        set(handles.N,'String','Number of the array (2-21)')
        set(handles.C_G,'String','1')

    case 2
        set(handles.N,'String','Number of the array (3,5,7,9 or 11)')
        set(handles.C_G,'String','1')
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
