function varargout = SSPIM_Toolbox(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SSPIM_Toolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @SSPIM_Toolbox_OutputFcn, ...
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

% --------------------------------------------------------------------
function SSPIM_Toolbox_CreateFcn(hObject, eventdata, handles)
% Pix_SS = get(0,'screensize');
% set(hObject,'Position',[Pix_SS(3)./4 Pix_SS(4)./4 866 333])

% --------------------------------------------------------------------
function SSPIM_Toolbox_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

Initialize(hObject, eventdata, handles);

%---------------------------------------------------------------------
function handles = Initialize(hObject, eventdata, handles)
clc
warning off all
global count d
count = 0;
d = 1;
func = cd;
addpath([func '/functions'])



%---------------------------------------------------------------------
function handles = position(hObject, eventdata, handles)
% Pix_SS = get(0,'screensize');
% set(SSPIM_Toolbox,'Position',[Pix_SS(3)./2 Pix_SS(4)./2 614 319])

%---------------------------------------------------------------------
function initial_values(hObject, eventdata, handles)
Data = guidata(SSPIM_Toolbox);
nx = str2double(Data.Nx.String);
ny = str2double(Data.Ny.String);
phi = zeros(nx,ny);
grating = zeros(nx,ny);
phase_grating = zeros(nx,ny);
beam_phase = zeros(nx,ny);
Array_grating = zeros(nx,ny);
Aperture = ones(nx,ny);
Hologram = zeros(nx,ny);
unwrap_Hologram = zeros(nx,ny);
data = struct('Hologram',Hologram,...
              'unwrap_Hologram',unwrap_Hologram,...
              'Aperture',Aperture,...
              'Array_grating',Array_grating,...
              'phi',phi,...
              'beam_phase',beam_phase,...
              'phase_grating', phase_grating,...
              'grating',grating);
set(handles.Run,'UserData',data);

% --------------------------------------------------------------------
function varargout = SSPIM_Toolbox_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% ----------------------Run SLM GUI-----------------------------------
function pushbutton20_Callback(hObject, eventdata, handles)
run SLM
set(handles.save_figs,'Enable','off');

% ----------------------Run Beam_Phase GUI----------------------------
function pushbutton21_Callback(hObject, eventdata, handles)
run Beam_Phase
set(handles.save_figs,'Enable','off');

% ----------------------Tiling GUI------------------------------------
function tiling_Callback(hObject, eventdata, handles)
run Tiling
set(handles.save_figs,'Enable','off');

% ----------------------Run Aperture GUI------------------------------
function pushbutton22_Callback(hObject, eventdata, handles)
run Aperture
set(handles.save_figs,'Enable','off');

% ----------------------Run Phase_Grating GUI-------------------------
function pushbutton24_Callback(hObject, eventdata, handles)
run Phase_Grating
set(handles.save_figs,'Enable','off');

% ----------------------Run Damman_Grating GUI------------------------
function pushbutton26_Callback(hObject, eventdata, handles)
run Damman_Grating
set(handles.save_figs,'Enable','off');

% ----------------------Run------------------------------------------
function Run_Callback(hObject, eventdata, handles)

global count
try
    set(handles.Run,'Enable','off');
    set(handles.prev,'Enable','off')
    set(handles.next,'Enable','off')
    set(handles.Fig,'Enable','off')
    set(handles.Propagation,'Enable','off')
    set(handles.Run,'Enable','off');
    Data = guidata(SSPIM_Toolbox);

l0 = str2double(Data.wavelength.String).*1e-9;
k0 = 2.*pi./(l0);
x0 = str2double(Data.Lx.String).*1e-2;
y0 = str2double(Data.Ly.String).*1e-2;
Nx = str2double(Data.Nx.String);
Ny = str2double(Data.Ny.String);
if Nx < Ny
    nx = Ny;
else
    nx = Nx;
end
[X Y] = MeshGrid(x0,y0,nx,nx);
xt = str2double(Data.xt_phase.String);
yt = str2double(Data.yt_phase.String);
%%------------------------Tiling-------------------------------------------
Focal_tiling_start = str2double(Data.Focal_tiling_start.String);
Focal_tiling_end = str2double(Data.Focal_tiling_end.String);
if Focal_tiling_end == inf 
   Focal_tiling_end = 0;
end 
if Focal_tiling_start == inf
   Focal_tiling_start = 0;
end 

tiling_step = str2double(Data.tiling_step.String);
if tiling_step <= 0 
   tiling_step = 1;
end 
switch get(handles.tile_y_n,'Value')
    case 1
      tiling_step = 1;  
end
tiling_domain = linspace(Focal_tiling_start,Focal_tiling_end,tiling_step);
tiling_domain(tiling_domain == 0) = inf;

if Focal_tiling_end == 0 
   Focal_tiling_end = inf;
end 
if Focal_tiling_start == 0
   Focal_tiling_start = inf;
end

tile_y_n = Data.tile_y_n.Value;

%%------------------------Phase Grating------------------------------------
phase_rot = str2double(Data.phase_rot.String);
xg = Data.Phase_g_y_n.Value;
xg_coeff = str2double(Data.xg_coef.String);
xg_rot = str2double(Data.xg_rot.String);

starT = str2double(Data.starT.String);
enD = str2double(Data.enD.String);
steP = str2double(Data.steP.String);

%%------------------------Aperture-----------------------------------------
rot_aper = str2double(Data.rot_aper.String);
aper_y_n = Data.aper_y_n.Value;
pop5 = str2double(Data.pop2.String);
r_in = str2double(Data.r_in.String);
r_out = str2double(Data.r_out.String);
xt_aper = str2double(Data.xt_aper.String);
yt_aper = str2double(Data.yt_aper.String);

%%------------------------Damman Grating-----------------------------------
DG = Data.DG.Value;
N_DG1 = str2double(Data.N_DG1.String);
C_DG1 = str2double(Data.C_DG1.String);
N_DG2 = str2double(Data.N_DG2.String);
C_DG2 = str2double(Data.C_DG2.String);
v_DG = Data.v_DG.Value; 
h_DG = Data.h_DG.Value; 
DG_1D = Data.DG_1D.Value;
DG_2D = Data.DG_2D.Value;
%%------------------------Optimal Grating----------------------------------
OG = Data.OG.Value;
N_OG1 = str2double(Data.N_OG1.String);
C_OG1 = str2double(Data.C_OG1.String);
v_OG = Data.v_OG.Value;
h_OG = Data.h_OG.Value;
OG_1D = Data.OG_1D.Value;

array_beam_y_n = Data.array_beam_y_n.Value;


pop1 = Data.pop1.String;
a = str2double(get(handles.phase_coefficient,'String'));
if strcmp(pop1,' ')
    Initialize_dialog;
else
    
for xg_coeff = starT:steP:enD
%$%------------------------Beam Phase--------------------------------------


pop1 = str2double(Data.pop1.String);
Bessel_aperture = ones(size(X));
switch pop1
    case 1
        phi = airy_1D_phase(X,Y,xt,-yt,-phase_rot,a).*k0;
    case 2
        phi = airy_2D_phase(X,Y,xt,-yt,-phase_rot,a).*k0;
    case 3
        phi = ones(size(X));
        Bessel_aperture = ring(X,-Y,phase_rot.*1e-3,a.*1e-3,...
                xt,yt); 
    case 4
        f = a;
        phi = cylindrical_lens(X,Y,xt,-yt,-phase_rot,f).*k0;
    case 5
        f = a;
        phi = spherical_lens(X,Y,xt,-yt,-phase_rot,f).*k0;
    case 6
        phi = ones(size(X)).*k0;
    case 7
        phi = ones(size(X));

end


%$%--------------------Phase-Grating---------------------------------------

[X_rot Y_rot]= Rotaion(X,Y,xg_rot);
switch xg
    case 1
        grating = zeros(size(X));
    case 2
        if strcmp(get(handles.text_r_grating,'String'),...
                'Phase grating is Configured.')
            grating = x_grating(X_rot,xg_coeff).*k0;
        else
           grating = zeros(size(X)); 
        end
end

phase_grating = (wrapToPi(grating));

%$%--------------------Dammann-Grating and Optimal-Grating-----------------
Array_grating = zeros(size(X));
v = 0.85;
ov = 1;
switch array_beam_y_n
    case 1
    case 2
        if DG == 1

            if DG_1D == 1 & DG_2D == 0

                if h_DG == 1
                    Array_grating = Damman_grating_1D(x0,nx,C_DG1.*y0.*1e3,N_DG1,1);

                elseif v_DG == 1
                    Array_grating = Damman_grating_1D(x0,nx,C_DG1.*x0.*1e3,N_DG1,0);

                end
                Array_grating = v*Array_grating(1:nx,1:nx);
                
            elseif DG_1D == 0 && DG_2D == 1
                Array_grating = Damman_grating_2D(x0,nx,C_DG1,N_DG1);
                Array_grating = Array_grating(1:nx,1:nx);
            end
        elseif OG == 1
            
            if OG_1D == 1
                if h_OG == 1
                    Array_grating = ov*Optimal_grating_1D(nx,nx,C_OG1.*y0.*1e3,N_OG1,1);
                elseif v_OG == 1
                    Array_grating = ov*Optimal_grating_1D(nx,nx,C_OG1.*x0.*1e3,N_OG1,0);
                end
            end
        end
end

%$%--------------------Aperture--------------------------------------------
Ap_lattice = ones(size(X));
switch aper_y_n
    case 1
        Aperture = ones(size(X));
    case 2
    if pop5 == 1
            Aperture = sGauss(X,-Y,r_in.*1e-3,r_out.*1e-3,...
                xt_aper.*1e-3,yt_aper.*1e-3,-rot_aper);
    elseif pop5 == 2
            Aperture = ring(X,-Y,r_out.*1e-3,r_in.*1e-3,...
                xt_aper,yt_aper);
    elseif pop5 == 3
            Aperture = Gauss(X,-Y,r_in.*1e-3,r_out.*1e-3,...
                xt_aper,yt_aper,-rot_aper);
    elseif pop5 == 4
            Aperture = rectx(X,Y,r_in.*1e-3,r_out.*1e-3,xt_aper.*1e-3,-yt_aper.*1e-3,rot_aper)...
                     .*recty(X,Y,r_in.*1e-3,r_out.*1e-3,xt_aper.*1e-3,-yt_aper.*1e-3,rot_aper);
    end
end

if strcmp(get(handles.text_g_beam,'String'),'Lattice Beam is selected.') 
try
    Ap_lattice = load('aper.txt');
end
end
Aperture = Bessel_aperture.*Aperture.*Ap_lattice;


%$%---------------------------Hologram-------------------------------------
nor_holo = get(handles.Normal_Hologram,'Value');

%$%------------------------Tiling------------------------------------------
for nt = 1:size(tiling_domain,2)
    
    switch tile_y_n
        case 1
            Tiling(:,:,nt) = zeros(size(X));
        case 2
            Tiling(:,:,nt) = spherical_lens(X,Y,0,0,0,tiling_domain(nt)).*k0;
    end
   
    beam_phase = (wrapToPi(phi));
    
    if nor_holo == 1
        if DG_1D == 1 || DG_2D == 1
            I = (wrapToPi(grating+phi+Array_grating+ Tiling(:,:,nt)));
            Hologram(:,:,nt) = Aperture.*Normalize(I);
            if Bessel_aperture ~= ones(size(X)); 
            I = phi.*(wrapToPi(grating+Array_grating+ Tiling(:,:,nt)));
            Hologram(:,:,nt) = Aperture.*Normalize(I);
            end
            unwrap_Hologram = Aperture.*(grating+phi+Array_grating+ Tiling(:,:,nt));
        else
            I = (wrapToPi(grating+phi+Array_grating+ Tiling(:,:,nt)));
            Hologram(:,:,nt) = Aperture.*Normalize(I);
            if Bessel_aperture ~= ones(size(X)); 
            I = phi.*(wrapToPi(grating+Array_grating+ Tiling(:,:,nt)));
            Hologram(:,:,nt) = Aperture.*Normalize(I);
            end
            unwrap_Hologram = Aperture.*(grating+phi+Array_grating+ Tiling(:,:,nt));
        end
    else
        if DG_1D == 1 || DG_2D == 1
            I = (grating+phi+Array_grating+ Tiling(:,:,nt));
            I = mod(pi.*round(I./pi),2*pi);
            if sum(abs(I(:))) ==0
                I = ones(size(I));
            end
            Hologram(:,:,nt) = logical(Normalize(Aperture.*I));
            if Bessel_aperture ~= ones(size(X));
                I = phi.*(wrapToPi(grating+Array_grating+ Tiling(:,:,nt)));
                Hologram(:,:,nt) = Aperture.*Normalize(I);
            end
            unwrap_Hologram = Aperture.*(grating+phi+Array_grating+ Tiling(:,:,nt));
        else
            I = (grating+phi+Array_grating+ Tiling(:,:,nt));
            I = mod(pi.*round(I./pi),2*pi);
            if sum(abs(I(:))) ==0
                I = ones(size(I));
            end
            Hologram(:,:,nt) = logical(Normalize(Aperture.*I));
            if Bessel_aperture ~= ones(size(X));
                I = phi.*(wrapToPi(grating+Array_grating+ Tiling(:,:,nt)));
                Hologram(:,:,nt) = Aperture.*Normalize(I);
            end
            unwrap_Hologram = Aperture.*(grating+phi+Array_grating+ Tiling(:,:,nt));
        end
    end
end
H = Hologram(:,:,:);
if Nx > Ny
Hologram = Hologram(end/2-Ny/2:end/2+Ny/2-1,1:Nx,:,:);
beam_phase = beam_phase(end/2-Ny/2:end/2+Ny/2-1,1:Nx,:,:);
phase_grating = phase_grating(end/2-Ny/2:end/2+Ny/2-1,1:Nx,:,:);
Aperture = Aperture(end/2-Ny/2:end/2+Ny/2-1,1:Nx,:,:);

elseif Nx < Ny
Hologram = Hologram(1:Ny,end/2-Nx/2:end/2+Nx/2-1,:);
beam_phase = beam_phase(1:Ny,end/2-Nx/2:end/2+Nx/2-1,:);
phase_grating = phase_grating(1:Ny,end/2-Nx/2:end/2+Nx/2-1,:);
Aperture = Aperture(1:Ny,end/2-Nx/2:end/2+Nx/2-1,:);
end

%$%------------------------------------------------------------------------
set(handles.save_figs,'Enable','on')
%#%------------------------------------------------------------------------

if strcmp(get(handles.Fig,'String'),['Hide Figures'])
    h = getappdata(Figures);
    axes(h.UsedByGUIData_m.axes7)
    imagesc(beam_phase);colormap gray;axis off;axis image
    axes(h.UsedByGUIData_m.axes8)
    imagesc(phase_grating);colormap gray;axis off;axis image
    axes(h.UsedByGUIData_m.axes9)
    imagesc(Aperture);colormap gray;axis off;axis image
    axes(h.UsedByGUIData_m.axes10)
    imagesc(Hologram(:,:,1));colormap gray;axis off;axis image
    

    nt = size(Hologram,3);
    set(h.UsedByGUIData_m.total_n_holo,'String',num2str(nt))
    
    set(handles.Fig,'String','Hide Figures')

    count = 1;

end
data = struct('Hologram',Hologram,...
              'Holo',H,...
              'unwrap_Hologram',unwrap_Hologram,...
              'Aperture',Aperture,...
              'Array_grating',Array_grating,...
              'phi',phi,...
              'beam_phase',beam_phase,...
              'phase_grating', phase_grating,...
              'grating',grating);
set(handles.Run,'UserData',data);
set(handles.SSPIM_Toolbox,'UserData',data);
% figure
% imagesc(Array_grating)
end
end
try
axes(handles.axes11)
imagesc(Hologram(:,:,1));colormap gray;axis image;axis off

cmap = get(handles.cmap,'Value');
switch cmap
    case 1
        colormap gray
    case 2
        colormap gray
    case 3
        colormap hot
    case 4
        colormap jet
end
        
end
set(handles.Run,'Enable','on');
set(handles.n_t,'String',num2str(size(Hologram,3)));
set(handles.n_holo,'String','1');
set(handles.prev,'Enable','off')
set(handles.next,'Enable','on')
set(handles.Fig,'Enable','on')
set(handles.Propagation,'Enable','on')


end


% -----------------------Binary_Hologram------------------------------
function Binary_Hologram_Callback(hObject, eventdata, handles)
set(handles.Normal_Hologram,'Value',0)
set(handles.Binary_Hologram,'Value',1)
set(handles.save_figs,'Enable','off');
Run_Callback(hObject,eventdata,handles);

% -----------------------Normal_Hologram------------------------------
function Normal_Hologram_Callback(hObject, eventdata, handles)
set(handles.Normal_Hologram,'Value',1)
set(handles.Binary_Hologram,'Value',0)
set(handles.save_figs,'Enable','off');
Run_Callback(hObject,eventdata,handles);

% -----------------------Show Figrues---------------------------------
function Fig_Callback(hObject, eventdata, handles)
set(handles.Fig,'Enable','off');
try
if isempty(get(handles.Run,'UserData'))
    initial_values(hObject, eventdata, handles);
end
data = get(handles.Run,'UserData');
global count
a = get(handles.Fig,'Value');
if a == 1 & count == 0
run Figures
h = getappdata(Figures);
axes(h.UsedByGUIData_m.axes7)
imagesc(data.beam_phase);colormap gray;axis off;axis image
axes(h.UsedByGUIData_m.axes8)
imagesc(data.phase_grating);colormap gray;axis off;axis image
axes(h.UsedByGUIData_m.axes9)
imagesc(data.Aperture);colormap gray;axis off;axis image
axes(h.UsedByGUIData_m.axes10)
data = get(handles.Run,'UserData');
H = data.Hologram;
imagesc(H(:,:,1));colormap gray;axis off;axis image
set(handles.Fig,'String','Hide Figures')
count = 1;
else
    close Figures
    set(handles.Fig,'String','Show Figures')
    count = 0;
end
end
set(handles.Fig,'Enable','on');

% -------------------------Propagation--------------------------------
function Propagation_Callback(hObject, eventdata, handles)
try
data = get(handles.Run,'Userdata');
figure
A = interp2(block_zero_order(abs(fftshift(fft2(data.Holo(:,:,1))))));% 中间变成0
imagesc(((A)));axis image;axis off;colormap gray
A = A./max(A(:));
% imwrite(A,'SIM.png')
data = struct('Simulation',A);
set(handles.Propagation,'UserData',data);
end
% ---------------------Save Hologram----------------------------------
function save_figs_Callback(hObject, eventdata, handles)
try
data = get(handles.Run,'UserData');
Hologram = data.Hologram;
[filename, pathname] = uiputfile(...
 {'*.bmp'; '*.png';'*.tiff';},'Save Figures...');
tile_y_n = get(handles.tile_y_n,'Value');
switch tile_y_n
    case 1
        if ~strcmp(filename,0) & ~strcmp(pathname,0)
            H = Hologram(:,:,1);
            imwrite(H,[pathname filename]);
            set(handles.save_figs,'Enable','off')
        end
    case 2
        if ~strcmp(filename,0) & ~strcmp(pathname,0)
            for n = 1:size(Hologram,3)
            H = Hologram(:,:,n);
            imwrite(H,[pathname 'Tile_' num2str(n) '_' filename ]);
            set(handles.save_figs,'Enable','off')
            end
        end
end
end


% --------------------------------------------------------------------
function aper_y_n_Callback(hObject, eventdata, handles)
set(handles.save_figs,'Enable','off');
pop5 = get(handles.aper_y_n,'Value');
switch pop5
    case 1
%         set(handles.text_r_aper,'String','No aperture set')
%         set(handles.text_r_aper,'ForegroundColor',[1 0 0])
    case 2
        set(handles.pushbutton22,'Enable','on')
end



% --------------------------------------------------------------------
function Phase_g_y_n_Callback(hObject, eventdata, handles)

Phase_g_y_n = get(handles.Phase_g_y_n,'Value');
switch Phase_g_y_n
    case 1
%         set(handles.text_r_grating,'String','No phase grating set.')
%         set(handles.text_r_grating,'ForegroundColor',[1 0 0])
        set(handles.save_figs,'Enable','off');
    case 2
        set(handles.pushbutton24,'Enable','on')
        set(handles.save_figs,'Enable','off');

end

% -----------------------Quite----------------------------------------
function Quite_Callback(hObject, eventdata, handles)
delete(hObject);
delete(get(0,'Children'));
 delete('aper.txt');

% --------------------------------------------------------------------
function SSPIM_Toolbox_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);
delete(get(0,'Children'));

%#%-------------------------------------------------------------------
%#%-------------------------------------------------------------------
%#%-------------------------------------------------------------------

% --------------------------------------------------------------------
function SSPIM_Toolbox_SizeChangedFcn(hObject, eventdata, handles)

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Load_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Save_Config_Callback(hObject, eventdata, handles)
Data = guidata(SSPIM_Toolbox);
Data = rmfield(Data,'SSPIM_Toolbox');
Data = rmfield(Data,'output');
Data = rmfield(Data,'Help');
try
[filename, pathname] = uiputfile('*.mat','Save Config...');
save([pathname filename] ,'Data');
catch filename, pathname;
end
% --------------------------------------------------------------------
function Load_Config_Callback(hObject, eventdata, handles)
try
    [FileName,PathName] = uigetfile('*.mat','Select the Config...');
    data = load([PathName FileName]);
    data_names = fieldnames(data.Data);
    h = getappdata(SSPIM_Toolbox);
    gui_names = fieldnames(h.UsedByGUIData_m);
    for k = [1:size(data_names,1)]
        p=data_names(k);
        bb = fieldnames(get(h.UsedByGUIData_m.(p{1,1})));
        if sum(strcmp(bb,'String'))
            set(h.UsedByGUIData_m.(p{1,1}),'String',get(data.Data.(p{1,1}),'String'));
        end
        if sum(strcmp(bb,'Value'))
            set(h.UsedByGUIData_m.(p{1,1}),'Value',get(data.Data.(p{1,1}),'Value'));
        end
        if sum(strcmp(bb,'Enable'))
            set(h.UsedByGUIData_m.(p{1,1}),'Enable',get(data.Data.(p{1,1}),'Enable'));
        end
        if sum(strcmp(bb,'ForegroundColor'))
            set(h.UsedByGUIData_m.(p{1,1}),'ForegroundColor',...
                get(data.Data.(p{1,1}),'ForegroundColor'));
        end
        if sum(strcmp(bb,'Visible'))
            set(h.UsedByGUIData_m.(p{1,1}),'Visible',...
                get(data.Data.(p{1,1}),'Visible'));
        end
    end
catch FileName,PathName;
end

% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
delete(hObject);
delete(get(0,'Children'));

% --------------------------------------------------------------------
function Help_ClickedCallback(hObject, eventdata, handles)
url = 'https://github.com/aakhtemostafa/SSPIM';
web(url,'-browser')


function OG_Callback(hObject, eventdata, handles)

function DG_Callback(hObject, eventdata, handles)



function starT_Callback(hObject, eventdata, handles)
% hObject    handle to starT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of starT as text
%        str2double(get(hObject,'String')) returns contents of starT as a double


% --- Executes during object creation, after setting all properties.
function starT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to starT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enD_Callback(hObject, eventdata, handles)
% hObject    handle to enD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enD as text
%        str2double(get(hObject,'String')) returns contents of enD as a double


% --- Executes during object creation, after setting all properties.
function enD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function steP_Callback(hObject, eventdata, handles)
% hObject    handle to steP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of steP as text
%        str2double(get(hObject,'String')) returns contents of steP as a double


% --- Executes during object creation, after setting all properties.
function steP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to steP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function tile_y_n_Callback(hObject, eventdata, handles)
set(handles.save_figs,'Enable','off');
tile_y_n = get(handles.tile_y_n,'Value');
switch tile_y_n
    case 1
%         set(handles.tiling_text,'String','No Tiling set.');
%         set(handles.tiling_text,'ForegroundColor',[1 0 0])

%         h = getappdata(Figures);
%         set(h.UsedByGUIData_m.total_n_holo,'String',num2str(1))
%         set(h.UsedByGUIData_m.next,'Enable','off')
%         set(h.UsedByGUIData_m.pre,'Enable','off')

    case 2
        set(handles.pushbutton35,'Enable','on')
        data = get(handles.Run,'UserData');
%         Hologram = data.Hologram;
%         h = getappdata(Figures);
%         nt = size(Hologram,3);
%         set(h.UsedByGUIData_m.total_n_holo,'String',num2str(nt))
%         set(h.UsedByGUIData_m.next,'Enable','on')

end


% --- Executes during object creation, after setting all properties.
function tile_y_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tile_y_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton35_Callback(hObject, eventdata, handles)
run Tiling
set(handles.save_figs,'Enable','off');



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


function array_beam_y_n_Callback(hObject, eventdata, handles)
set(handles.save_figs,'Enable','off');


% --- Executes on selection change in cmap.
function cmap_Callback(hObject, eventdata, handles)
data = get(handles.Run,'UserData');
try
axes(handles.axes11)
imagesc(data.Hologram(:,:,1));colormap gray;axis image;axis off
cmap = get(handles.cmap,'Value');
switch cmap
    case 1
        colormap gray
    case 2
        colormap gray
    case 3
        colormap hot
    case 4
        colormap jet
end
        
end


% --- Executes during object creation, after setting all properties.
function cmap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% try
global d
Holo1 = get(handles.Run,'UserData');
Holo2 = Holo1.Hologram;
nt = size(Holo2,3);
set(handles.prev,'Enable','on')
if d<=1
    d = 1;
elseif d>nt
    d = nt;    
end
if d>=1 & d <nt 
if get(handles.next,'Value') == 1
d = d+1;
axes(handles.axes11)
imagesc(Holo2(:,:,d));colormap gray;axis off;axis image
set(handles.n_holo,'String',num2str(d))

end
end
if d == nt
    set(handles.next,'Enable','off')
end
% end
% --- Executes on button press in prev.
function prev_Callback(hObject, eventdata, handles)
% try
global d
Holo1 = get(handles.Run,'UserData');
Holo2 = Holo1.Hologram;
nt = size(Holo2,3);
set(handles.next,'Enable','on')
if d<1
    d = 2;
elseif d>nt
    d = nt;    
end
if d>1 & d<=nt
if get(handles.prev,'Value') == 1
d = d-1;
axes(handles.axes11)
imagesc(Holo2(:,:,d));colormap gray;axis off;axis image
set(handles.n_holo,'String',num2str(d))
end
end
if d == 1
    set(handles.prev,'Enable','off')
end
% end
function popupmenu17_Callback(hObject, eventdata, handles)



function popupmenu17_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu18.
function popupmenu18_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu18 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu18


% --- Executes during object creation, after setting all properties.
function popupmenu18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
