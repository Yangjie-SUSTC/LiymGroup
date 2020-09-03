function varargout = Beam_Phase(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Beam_Phase_OpeningFcn, ...
                   'gui_OutputFcn',  @Beam_Phase_OutputFcn, ...
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

function Beam_Phase_CreateFcn(hObject, eventdata, handles)
% 
% Pix_SS = get(0,'screensize');
% set(hObject,'Position',[Pix_SS(3)/2 Pix_SS(4)/2 63 19])


function Beam_Phase_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = Beam_Phase_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function popupmenu1_Callback(hObject, eventdata, handles)

pop1 = get(handles.popupmenu1,'Value');
switch pop1
    case 1
        set(handles.text14,'Enable','on')
        set(handles.text23,'Enable','on')
        set(handles.text26,'Enable','on')
        set(handles.text43,'Enable','on')
        set(handles.text25,'Enable','on')
        set(handles.text27,'Enable','on')
        set(handles.text44,'Enable','on')
        set(handles.yt_phase,'Enable','on')
        set(handles.xt_phase,'Enable','on')
        set(handles.phase_rot,'Enable','on')
        set(handles.phase_coefficient,'Enable','on')
        
        set(handles.text67,'Visible','off')
        
        set(handles.phase_coefficient,'String','10')
        set(handles.text14,'String','Phase Coefficient')
        set(handles.text44,'String','(deg)')
        set(handles.text43,'String','Rotation')
        set(handles.phase_rot,'String','0')
        set(handles.setup,'Visible','off')
        set(handles.focal_plane,'Visible','off')
        set(handles.rear_pupil,'Visible','off')        
    case 2
        set(handles.phase_coefficient,'String','10')
        set(handles.text14,'Enable','on')
        set(handles.text14,'String','Phase Coefficient')
        set(handles.text67,'Visible','off')
        set(handles.text23,'Enable','on')
        set(handles.text26,'Enable','on')
        set(handles.text43,'Enable','on')
        set(handles.phase_coefficient,'Enable','on')
        set(handles.xt_phase,'Enable','on')
        set(handles.yt_phase,'Enable','on')
        set(handles.phase_rot,'Enable','on')
        set(handles.text25,'Enable','on')
        set(handles.text27,'Enable','on')
        set(handles.text44,'Enable','on')
        set(handles.text44,'String','(deg)')
        set(handles.text43,'String','Rotation')
        set(handles.phase_rot,'String','0')
        set(handles.setup,'Visible','off')
        set(handles.focal_plane,'Visible','off')
        set(handles.rear_pupil,'Visible','off')
    case 3
        set(handles.phase_coefficient,'String','3')
        set(handles.phase_rot,'String','4')
        set(handles.text14,'String','R_in (radius)')
        set(handles.text43,'String','R_out (radius)')
        set(handles.text14,'Enable','on')
        set(handles.text67,'Visible','on')
        set(handles.text23,'Enable','on')
        set(handles.text26,'Enable','on')
        set(handles.text43,'Enable','on')
        set(handles.text43,'Enable','on')
        set(handles.text44,'String','(mm)')
        set(handles.xt_phase,'Enable','on')
        set(handles.yt_phase,'Enable','on')
        set(handles.phase_rot,'Enable','on')
        set(handles.text25,'Enable','on')
        set(handles.text27,'Enable','on')
        set(handles.text44,'Enable','on')
        set(handles.text67,'Enable','on')
        set(handles.phase_coefficient,'Enable','on')
        set(handles.setup,'Visible','off')
        set(handles.focal_plane,'Visible','off')
        set(handles.rear_pupil,'Visible','off')        
    case 4
        set(handles.phase_coefficient,'String','40')
        set(handles.text14,'Enable','on')
        set(handles.text67,'Visible','on')
        set(handles.text14,'String','Focal Length')
        set(handles.text23,'Enable','on')
        set(handles.text26,'Enable','on')
        set(handles.text43,'Enable','on')
        set(handles.phase_coefficient,'Enable','on')
        set(handles.xt_phase,'Enable','on')
        set(handles.yt_phase,'Enable','on')
        set(handles.phase_rot,'Enable','on')
        set(handles.text25,'Enable','on')
        set(handles.text27,'Enable','on')
        set(handles.text44,'Enable','on')
        set(handles.text44,'String','(deg)')
        set(handles.text43,'String','Rotation')
        set(handles.phase_rot,'String','0')
        set(handles.text67,'Enable','on')
        set(handles.setup,'Visible','off')
        set(handles.focal_plane,'Visible','off')
        set(handles.rear_pupil,'Visible','off')
        
    case 5
        set(handles.phase_coefficient,'String','40')
        set(handles.text14,'Enable','on')
        set(handles.text67,'Visible','on')
        set(handles.text14,'String','Focal Length')
        set(handles.text23,'Enable','on')
        set(handles.text26,'Enable','on')
        set(handles.text43,'Enable','on')
        set(handles.phase_coefficient,'Enable','on')
        set(handles.xt_phase,'Enable','on')
        set(handles.yt_phase,'Enable','on')
        set(handles.phase_rot,'Enable','on')
        set(handles.text25,'Enable','on')
        set(handles.text27,'Enable','on')
        set(handles.text44,'Enable','on')
        set(handles.text44,'String','(deg)')
        set(handles.text43,'String','Rotation')
        set(handles.phase_rot,'String','0')
        set(handles.text67,'Enable','on')
        set(handles.setup,'Visible','off')
        set(handles.focal_plane,'Visible','off')
        set(handles.rear_pupil,'Visible','off')
        set(handles.phase_rot,'Enable','off')
        set(handles.text43,'Enable','off')
        set(handles.text44,'Enable','off')
        
    case 7
        set(handles.text14,'Enable','off')
        set(handles.text23,'Enable','off')
        set(handles.text26,'Enable','off')
        set(handles.text43,'Enable','off')
        set(handles.phase_coefficient,'Enable','off')
        set(handles.xt_phase,'Enable','off')
        set(handles.yt_phase,'Enable','off')
        set(handles.phase_rot,'Enable','off')
        set(handles.text25,'Enable','off')
        set(handles.text27,'Enable','off')
        set(handles.text44,'Enable','off')
        set(handles.text67,'Enable','off')
        set(handles.setup,'Visible','off')
        set(handles.focal_plane,'Visible','off')
        set(handles.rear_pupil,'Visible','off')
    case 6 
        set(handles.text14,'Enable','off')
        set(handles.text23,'Enable','off')
        set(handles.text26,'Enable','off')
        set(handles.text43,'Enable','off')
        set(handles.phase_coefficient,'Enable','off')
        set(handles.xt_phase,'Enable','off')
        set(handles.yt_phase,'Enable','off')
        set(handles.phase_rot,'Enable','off')
        set(handles.text25,'Enable','off')
        set(handles.text27,'Enable','off')
        set(handles.text44,'Enable','off')
        set(handles.text67,'Enable','off')
        set(handles.setup,'Visible','on')
        set(handles.focal_plane,'Visible','on')
        set(handles.rear_pupil,'Visible','on')
end

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function yt_phase_Callback(hObject, eventdata, handles)

function yt_phase_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function xt_phase_Callback(hObject, eventdata, handles)

function xt_phase_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function phase_rot_Callback(hObject, eventdata, handles)

function phase_rot_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function phase_coefficient_Callback(hObject, eventdata, handles)

function phase_coefficient_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function wavelength_Callback(hObject, eventdata, handles)

function wavelength_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function set_active(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.text_r_aper,'Enable','on')
set(h.UsedByGUIData_m.text115,'Enable','on')
% set(h.UsedByGUIData_m.aper_y_n,'Enable','on')
set(h.UsedByGUIData_m.pushbutton22,'Enable','on')

set(h.UsedByGUIData_m.text_r_grating,'Enable','on')
set(h.UsedByGUIData_m.text120,'Enable','on')
% set(h.UsedByGUIData_m.Phase_g_y_n,'Enable','on')
set(h.UsedByGUIData_m.pushbutton24,'Enable','on')

set(h.UsedByGUIData_m.beam_array_r_txt,'Enable','on')
set(h.UsedByGUIData_m.text123,'Enable','on')
% set(h.UsedByGUIData_m.array_beam_y_n,'Enable','on')
set(h.UsedByGUIData_m.pushbutton26,'Enable','on')

set(h.UsedByGUIData_m.Normal_Hologram,'Enable','on')
set(h.UsedByGUIData_m.Binary_Hologram,'Enable','on')

% set(h.UsedByGUIData_m.Fig,'Enable','on')
% set(h.UsedByGUIData_m.Propagation,'Enable','on')
set(h.UsedByGUIData_m.Run,'Enable','on')
set(h.UsedByGUIData_m.Quite,'Enable','on')
        
        
function set_values(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.text_r_beam,'Visible','off');
pop1 = get(handles.popupmenu1,'Value');
set(h.UsedByGUIData_m.pop1,'String',pop1);

switch pop1
    case 1
        set(h.UsedByGUIData_m.Des_beam,'String','1D Airy Beam');
        set(h.UsedByGUIData_m.text_g_beam,'String','1D cubic phase is selected.')
        set_active(hObject, eventdata, handles)
    case 2
        set(h.UsedByGUIData_m.Des_beam,'String','2D Airy Beam');
        set(h.UsedByGUIData_m.text_g_beam,'String','2D cubic phase is selected.')
        set_active(hObject, eventdata, handles)
    case 3
        set(h.UsedByGUIData_m.Des_beam,'String','Bessel Beam');
        set(h.UsedByGUIData_m.text_g_beam,'String','Annular mask is selected.')
        set_active(hObject, eventdata, handles)
    case 4
        set(h.UsedByGUIData_m.Des_beam,'String','Cylindrical Lens');
        set(h.UsedByGUIData_m.text_g_beam,'String','Cylindrical Lens is selected.')
        set_active(hObject, eventdata, handles)
    case 5
        set(h.UsedByGUIData_m.Des_beam,'String','Spherical Lens');
        set(h.UsedByGUIData_m.text_g_beam,'String','Spherical Lens is selected.')
        set_active(hObject, eventdata, handles)
    case 7
        set(h.UsedByGUIData_m.Des_beam,'String','Only Grating');
        set(h.UsedByGUIData_m.text_g_beam,'String','None is selected.')
        set_active(hObject, eventdata, handles)
    case 6
        h1 = getappdata(Lattice);
        set(h.UsedByGUIData_m.Des_beam,'String','Lattice Beam');
        set(h.UsedByGUIData_m.text_g_beam,'String','Lattice Beam is selected.') 
        set(h1.UsedByGUIData_m.text6,'String','Bound Lattice')
        set(h1.UsedByGUIData_m.text6,'FontWeight','normal')
        set(h1.UsedByGUIData_m.text9,'String','SLM Pattern')
        set(h1.UsedByGUIData_m.text9,'FontWeight','bold')
        set(h1.UsedByGUIData_m.save,'Visible','off')
        set_active(hObject, eventdata, handles)
        
        if get(handles.focal_plane,'Value') == 1
            
        set(h1.UsedByGUIData_m.text6,'String','SLM Pattern')
        set(h1.UsedByGUIData_m.text6,'FontWeight','bold')
        set(h1.UsedByGUIData_m.text9,'String','Intensity at Rear Pupil')
        set(h1.UsedByGUIData_m.text9,'FontWeight','normal')
        set(h1.UsedByGUIData_m.save,'Visible','on')

        set(h.UsedByGUIData_m.text_r_aper,'Enable','off')
        set(h.UsedByGUIData_m.text115,'Enable','off')
        set(h.UsedByGUIData_m.aper_y_n,'Enable','off')
        set(h.UsedByGUIData_m.pushbutton22,'Enable','off')
        
        set(h.UsedByGUIData_m.text_r_grating,'Enable','off')
        set(h.UsedByGUIData_m.text120,'Enable','off')
        set(h.UsedByGUIData_m.Phase_g_y_n,'Enable','off')
        set(h.UsedByGUIData_m.pushbutton24,'Enable','off')
        
        set(h.UsedByGUIData_m.beam_array_r_txt,'Enable','off')
        set(h.UsedByGUIData_m.text123,'Enable','off')
        set(h.UsedByGUIData_m.array_beam_y_n,'Enable','off')
        set(h.UsedByGUIData_m.pushbutton26,'Enable','off')
       
        set(h.UsedByGUIData_m.Normal_Hologram,'Enable','off')
        set(h.UsedByGUIData_m.Binary_Hologram,'Enable','off')
        
        set(h.UsedByGUIData_m.Fig,'Enable','off')
        set(h.UsedByGUIData_m.Propagation,'Enable','off')
        set(h.UsedByGUIData_m.Run,'Enable','off')
        set(h.UsedByGUIData_m.save_figs,'Enable','off')
        end
end

set(h.UsedByGUIData_m.text_g_beam,'ForegroundColor',[0 0.498 0])
set(h.UsedByGUIData_m.wavelength,'String',get(handles.wavelength,'String'));
set(h.UsedByGUIData_m.phase_coefficient,'String',get(handles.phase_coefficient,'String'));
set(h.UsedByGUIData_m.xt_phase,'String',get(handles.xt_phase,'String'));
set(h.UsedByGUIData_m.yt_phase,'String',get(handles.yt_phase,'String'));
set(h.UsedByGUIData_m.phase_rot,'String',get(handles.phase_rot,'String'));

function ok_Callback(hObject, eventdata, handles)
set_values(hObject, eventdata, handles);
set(handles.Beam_Phase,'Visible','off');


function cancel_Callback(hObject, eventdata, handles)
set(handles.Beam_Phase,'Visible','off');

function apply_Callback(hObject, eventdata, handles)
set(handles.apply,'Enable','off');
set_values(hObject, eventdata, handles);
%%%% RUN
h = getappdata(SSPIM_Toolbox);
handles1 = h.UsedByGUIData_m;
SSPIM_Toolbox('Run_Callback',handles1.Run,[],handles1)
getappdata(Beam_Phase);
set(handles.apply,'Enable','on')


function Beam_Phase_CloseRequestFcn(hObject, eventdata, handles)
set(handles.Beam_Phase,'Visible','off');


function focal_plane_Callback(hObject, eventdata, handles)
set(handles.rear_pupil,'Value',0)
set(handles.focal_plane,'Value',1)


function rear_pupil_Callback(hObject, eventdata, handles)
set(handles.rear_pupil,'Value',1)
set(handles.focal_plane,'Value',0)




function setup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to setup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
