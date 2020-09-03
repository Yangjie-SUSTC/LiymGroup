function varargout = Aperture(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Aperture_OpeningFcn, ...
                   'gui_OutputFcn',  @Aperture_OutputFcn, ...
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

function Aperture_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = Aperture_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function popupmenu1_Callback(hObject, eventdata, handles)
pop1 = get(handles.popupmenu1,'Value');
switch pop1
    case 1
        set(handles.text2,'String','X-axis');
        set(handles.text3,'String','Y-axis');
        set(handles.r_in,'String','4');
        set(handles.r_out,'String','4');
    case 2
        set(handles.r_in,'String','3');
        set(handles.r_out,'String','4');
        set(handles.text2,'String','Inner radius');
        set(handles.text3,'String','Outer radius');       
    case 3
        set(handles.text2,'String','X-axis');
        set(handles.text3,'String','Y-axis');
        set(handles.r_in,'String','4');
        set(handles.r_out,'String','4');
    case 4
        set(handles.text2,'String','X-axis');
        set(handles.text3,'String','Y-axis');
        set(handles.r_in,'String','3');
        set(handles.r_out,'String','4');
end

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function inverse_aper_Callback(hObject, eventdata, handles)

function radiobutton2_Callback(hObject, eventdata, handles)

function r_in_Callback(hObject, eventdata, handles)

function r_in_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function r_out_Callback(hObject, eventdata, handles)

function r_out_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function xt_aper_Callback(hObject, eventdata, handles)

function xt_aper_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function yt_aper_Callback(hObject, eventdata, handles)

function yt_aper_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rot_aper_Callback(hObject, eventdata, handles)

function rot_aper_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_values(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
pop1 = get(handles.popupmenu1,'Value');
set(h.UsedByGUIData_m.pop2,'String',pop1)
switch pop1
    case 1
        set(h.UsedByGUIData_m.Des_aper,'String','Ellipse Aperture');
        set(h.UsedByGUIData_m.text_r_aper,'String','Ellipse function is selected.')
    case 2
        set(h.UsedByGUIData_m.Des_aper,'String','Ring Aperture');
        set(h.UsedByGUIData_m.text_r_aper,'String','Ring function is selected.')
    case 3
        set(h.UsedByGUIData_m.Des_aper,'String','Gaussian Aperture');
        set(h.UsedByGUIData_m.text_r_aper,'String','Gaussian function is selected.')
    case 4
        set(h.UsedByGUIData_m.Des_aper,'String','Rectangular Aperture');
        set(h.UsedByGUIData_m.text_r_aper,'String','Rectangular function is selected.')
    case 5
end
set(h.UsedByGUIData_m.text_r_aper,'ForegroundColor',[0 0.498 0])
set(h.UsedByGUIData_m.r_in,'String',get(handles.r_in,'String'))
set(h.UsedByGUIData_m.r_out,'String',get(handles.r_out,'String'))
set(h.UsedByGUIData_m.xt_aper,'String',get(handles.xt_aper,'String'))
set(h.UsedByGUIData_m.yt_aper,'String',get(handles.yt_aper,'String'))
set(h.UsedByGUIData_m.rot_aper,'String',get(handles.rot_aper,'String'))

set(h.UsedByGUIData_m.pushbutton22,'Enable','on')
set(h.UsedByGUIData_m.aper_y_n,'Enable','on')


function cancel_Callback(hObject, eventdata, handles)
set(handles.aperture,'Visible','off')

function set_Callback(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.aper_y_n,'Value',2);
set_values(hObject, eventdata, handles)
set(handles.aperture,'Visible','off')

function apply_Callback(hObject, eventdata, handles)
set(handles.apply,'Enable','off');
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.aper_y_n,'Value',2);
set_values(hObject, eventdata, handles)
%%% RUN
handles1 = h.UsedByGUIData_m;
SSPIM_Toolbox('Run_Callback',handles1.Run,[],handles1)
getappdata(Aperture);
set(handles.apply,'Enable','on');


function aperture_CloseRequestFcn(hObject, eventdata, handles)
set(handles.aperture,'Visible','off')
