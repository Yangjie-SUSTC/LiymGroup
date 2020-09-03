function varargout = Phase_Grating(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Phase_Grating_OpeningFcn, ...
                   'gui_OutputFcn',  @Phase_Grating_OutputFcn, ...
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

function Phase_Grating_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = Phase_Grating_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function radiobutton1_Callback(hObject, eventdata, handles)


function xg_coef_Callback(hObject, eventdata, handles)


function xg_coef_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xg_rot_Callback(hObject, eventdata, handles)


function xg_rot_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_values(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.xg_rot,'String',get(handles.xg_rot,'String'))

if get(handles.tilt,'Value') == 1
    set(h.UsedByGUIData_m.xg_coef,'String',get(handles.xg_coef,'String'))
    set(h.UsedByGUIData_m.text_r_grating,'ForegroundColor',[0 0.498 0])
    set(h.UsedByGUIData_m.text_r_grating,'String','Phase grating is Configured.')
    set(h.UsedByGUIData_m.pushbutton24,'Enable','on')
    set(h.UsedByGUIData_m.starT,'String',get(handles.START,'String'))
    set(h.UsedByGUIData_m.enD,'String',get(handles.END,'String'))
    set(h.UsedByGUIData_m.steP,'String',get(handles.Step_size,'String'))
elseif get(handles.steer,'Value') == 1
    set(h.UsedByGUIData_m.starT,'String',get(handles.START,'String'))
    set(h.UsedByGUIData_m.enD,'String',get(handles.END,'String'))
    set(h.UsedByGUIData_m.steP,'String',get(handles.Step_size,'String'))
    set(h.UsedByGUIData_m.text_r_grating,'ForegroundColor',[0 0.498 0])
    set(h.UsedByGUIData_m.text_r_grating,'String','Phase grating is Configured.')
    set(h.UsedByGUIData_m.pushbutton24,'Enable','on')
end

function set_Callback(hObject, eventdata, handles)

h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.Phase_g_y_n,'Value',2)

set_values(hObject, eventdata, handles)
set(handles.phase_grating,'Visible','off')
if get(handles.tilt,'Value') == 1
    set(handles.START,'String',get(handles.xg_coef,'String'));
    set(h.UsedByGUIData_m.starT,'String',get(handles.START,'String'))
    set(handles.END,'String',get(handles.xg_coef,'String'));
    set(h.UsedByGUIData_m.enD,'String',get(handles.END,'String'))
    set(handles.Step_size,'String','1');
    set(h.UsedByGUIData_m.steP,'String',get(handles.Step_size,'String'))
end
set(h.UsedByGUIData_m.Phase_g_y_n,'Enable','on')


function apply_Callback(hObject, eventdata, handles)
set(handles.apply,'Enable','off');
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.Phase_g_y_n,'Value',2);

set_values(hObject, eventdata, handles)
if get(handles.tilt,'Value') == 1
    set(handles.START,'String',get(handles.xg_coef,'String'));
    set(h.UsedByGUIData_m.starT,'String',get(handles.START,'String'))
    set(handles.END,'String',get(handles.xg_coef,'String'));
    set(h.UsedByGUIData_m.enD,'String',get(handles.END,'String'))
    set(handles.Step_size,'String','1');
    set(h.UsedByGUIData_m.steP,'String',get(handles.Step_size,'String'))
end
set(h.UsedByGUIData_m.Phase_g_y_n,'Enable','on');
%%%% RUN
handles1 = h.UsedByGUIData_m;
SSPIM_Toolbox('Run_Callback',handles1.Run,[],handles1)
getappdata(Phase_Grating);
set(handles.apply,'Enable','on');

%

function cancel_Callback(hObject, eventdata, handles)
set(handles.phase_grating,'Visible','off')



function phase_grating_CloseRequestFcn(hObject, eventdata, handles)
set(handles.phase_grating,'Visible','off')


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in tilt.
function tilt_Callback(hObject, eventdata, handles)

set(handles.steer,'Value',0)
set(handles.tilt,'Value',1)

set(handles.text5,'Enable','off')
set(handles.text8,'Enable','off')
set(handles.text9,'Enable','off')
set(handles.START,'Enable','off')
set(handles.END,'Enable','off')
set(handles.Step_size,'Enable','off')

set(handles.text2,'Enable','on')
set(handles.xg_coef,'Enable','on')



% --- Executes on button press in steer.
function steer_Callback(hObject, eventdata, handles)

set(handles.tilt,'Value',0)
set(handles.steer,'Value',1)

set(handles.text5,'Enable','on')
set(handles.text8,'Enable','on')
set(handles.text9,'Enable','on')
set(handles.START,'Enable','on')
set(handles.END,'Enable','on')
set(handles.Step_size,'Enable','on')

set(handles.text2,'Enable','off')
set(handles.xg_coef,'Enable','off')

function START_Callback(hObject, eventdata, handles)
% hObject    handle to START (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of START as text
%        str2double(get(hObject,'String')) returns contents of START as a double


% --- Executes during object creation, after setting all properties.
function START_CreateFcn(hObject, eventdata, handles)
% hObject    handle to START (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function END_Callback(hObject, eventdata, handles)
% hObject    handle to END (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of END as text
%        str2double(get(hObject,'String')) returns contents of END as a double


% --- Executes during object creation, after setting all properties.
function END_CreateFcn(hObject, eventdata, handles)
% hObject    handle to END (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step_size_Callback(hObject, eventdata, handles)
% hObject    handle to Step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step_size as text
%        str2double(get(hObject,'String')) returns contents of Step_size as a double


% --- Executes during object creation, after setting all properties.
function Step_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
