function varargout = Figures(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Figures_OpeningFcn, ...
                   'gui_OutputFcn',  @Figures_OutputFcn, ...
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

function Figures_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


Initialize(hObject, eventdata, handles);

set(handles.axes7,'XTick',[]);
set(handles.axes7,'YTick',[]);
set(handles.axes8,'XTick',[]);
set(handles.axes8,'YTick',[]);
set(handles.axes9,'XTick',[]);
set(handles.axes9,'YTick',[]);
set(handles.axes10,'XTick',[]);
set(handles.axes10,'YTick',[]);

%---------------------------------------------------------------------
function handles = Initialize(hObject, eventdata, handles)
global g
g = 1;
h = getappdata(SSPIM_Toolbox);
Holo = h.UsedByGUIData_m.SSPIM_Toolbox.UserData.Hologram;
nt = size(Holo,3)
set(handles.total_n_holo,'String',num2str(nt))

function varargout = Figures_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton2_Callback(hObject, eventdata, handles)
h = getappdata(Figures);
figure('Name','Hologram')
imagesc(h.UsedByGUIData_m.axes10.Children.CData);axis image;colormap gray
xlabel('Pixel');ylabel('Pixel');title('Hologram');colorbar

function pushbutton1_Callback(hObject, eventdata, handles)
h = getappdata(Figures);
figure('Name','Beam Phase')
imagesc(h.UsedByGUIData_m.axes7.Children.CData);axis image;colormap gray
xlabel('Pixel');ylabel('Pixel');title('Beam Phase');colorbar


function pushbutton3_Callback(hObject, eventdata, handles)
h = getappdata(Figures);
figure('Name','Phase Grating')
imagesc(h.UsedByGUIData_m.axes8.Children.CData);axis image;colormap gray
xlabel('Pixel');ylabel('Pixel');title('Phase Grating');colorbar

function pushbutton4_Callback(hObject, eventdata, handles)
h = getappdata(Figures);
figure('Name','Aperture')
imagesc(h.UsedByGUIData_m.axes9.Children.CData);axis image;colormap gray
xlabel('Pixel');ylabel('Pixel');title('Aperture');colorbar

function Figures_CloseRequestFcn(hObject, eventdata, handles)
h = getappdata(SSPIM_Toolbox);
set(h.UsedByGUIData_m.Fig,'Value',0)
set(h.UsedByGUIData_m.Fig,'String','Show Figures')
delete(hObject);


function pre_Callback(hObject, eventdata, handles)
try
global g
h = getappdata(SSPIM_Toolbox);
Holo = h.UsedByGUIData_m.SSPIM_Toolbox.UserData.Hologram;
nt = size(Holo,3);
set(handles.next,'Enable','on')
if g<1
    g = 2;
elseif g>nt
    g = nt;    
end
if g>1 & g<=nt
if get(handles.pre,'Value') == 1
g = g-1;
axes(handles.axes10)
imagesc(Holo(:,:,g));colormap gray;axis off;axis image
set(handles.n_holo,'String',num2str(g))
end
end
if g == 1
    set(handles.pre,'Enable','off')
end
end

function next_Callback(hObject, eventdata, handles)
try
global g
h = getappdata(SSPIM_Toolbox);
Holo = h.UsedByGUIData_m.SSPIM_Toolbox.UserData.Hologram;
nt = size(Holo,3);
set(handles.pre,'Enable','on')
if g<=1
    g = 1;
elseif g>nt
    g = nt;    
end
if g>=1 & g <nt 
if get(handles.next,'Value') == 1
g = g+1;
axes(handles.axes10)
imagesc(Holo(:,:,g));colormap gray;axis off;axis image
set(handles.n_holo,'String',num2str(g))

end
end
if g == nt
    set(handles.next,'Enable','off')
end
end


function total_n_holo_CreateFcn(hObject, eventdata, handles)
