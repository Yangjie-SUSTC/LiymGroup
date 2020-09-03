function varargout = Lattice(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Lattice_OpeningFcn, ...
                   'gui_OutputFcn',  @Lattice_OutputFcn, ...
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


function Lattice_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);
axes(handles.axes9);
imshow(imread('Bravais.jpg'));axis image;axis off
set(handles.pushbutton1,'Enable','off');
set(handles.Zoom,'Enable','off')

set(handles.axes1,'XTick',[]);
set(handles.axes1,'YTick',[]);
set(handles.axes2,'XTick',[]);
set(handles.axes2,'YTick',[]);
set(handles.axes4,'XTick',[]);
set(handles.axes4,'YTick',[]);
set(handles.axes13,'XTick',[]);
set(handles.axes13,'YTick',[]);
set(handles.axes10,'XTick',[]);
set(handles.axes10,'YTick',[]);
set(handles.axes6,'XTick',[]);
set(handles.axes6,'YTick',[]);
set(handles.axes7,'XTick',[]);
set(handles.axes7,'YTick',[]);
set(handles.axes8,'XTick',[]);
set(handles.axes8,'YTick',[]);
set(handles.axes11,'XTick',[]);
set(handles.axes11,'YTick',[]);
set(handles.axes12,'XTick',[]);
set(handles.axes12,'YTick',[]);


function varargout = Lattice_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
% try
I0 = get(handles.pushbutton2,'UserData');
I0 = I0.Lattice;

h = getappdata(SSPIM_Toolbox);

Nx = str2num(get(h.UsedByGUIData_m.Nx,'String'));
Ny = str2num(get(h.UsedByGUIData_m.Ny,'String'));
x0 = str2num(get(h.UsedByGUIData_m.Lx,'String')).*1e-2;
y0 = str2num(get(h.UsedByGUIData_m.Ly,'String')).*1e-2;
x = linspace(-x0./2,x0./2,Nx);
y = linspace(-y0./2,y0./2,Nx).*abs(x0./y0);
dx = x(end)-x(end-1);
dy = y(end)-y(end-1);

[X1 Y1] = meshgrid(x,y);

wx = str2num(get(handles.wx,'String')).*1e-3;
wy = str2num(get(handles.wy,'String')).*1e-3;
xt_bound = str2num(get(handles.xt_bound,'String')).*1e-3;
yt_bound = str2num(get(handles.yt_bound,'String')).*1e-3;

A = exp(-(((Y1-yt_bound)./wy).^2+((X1-xt_bound)./wx).^2));
axes(handles.axes2)
imagesc(A);axis image;axis off;colormap hot
B = A;
B(B<=0.5) = 0;
B(B>0.5) = 1;

E_bound0 = B.*I0;

E_bound = E_bound0./max(E_bound0(:));

E_bound(E_bound<=0.5) = 0;
E_bound(E_bound>0.5) = 1;

phi = pi.*E_bound;
E_bound0 = E_bound0./max(E_bound0(:));
if strcmp(get(handles.text6,'String'),'SLM Pattern')
   E_bound0 = phi;
end
axes(handles.axes4)
imagesc(E_bound0);axis image;colormap hot;axis off

U = fftshift(fft2(exp(1i.*phi)));
I = U.*conj(U);
U(floor(end/2)-5:floor(end/2)+5,...
  floor(end/2)-5:floor(end/2)+5) = 0;
axes(handles.axes13)
FFT_bound_lattice = abs(U)./max(abs(U(:)));
imagesc(FFT_bound_lattice);axis image;colormap hot;axis off

r1 = sqrt(X1.^2+Y1.^2);
B = ones(size(X1));
r01 = str2num(get(handles.Ri,'String')).*1e-3;
r02 = str2num(get(handles.Ro,'String')).*1e-3;
B(r1<r01) = 0;
B(r1>r02) = 0;
axes(handles.axes6)
imagesc(B);axis image;colormap hot;axis off

E = B.*U;
E = E./max(E(:));
IE = E.*conj(E);
if strcmp(get(handles.text6,'String'),'SLM Pattern')
else
IE(IE<0.1) = 0 ;
IE(IE>=0.1) = 1 ;    
end

axes(handles.axes7)
imagesc(IE);axis image;colormap hot;axis off
dlmwrite('aper.txt',IE,'delimiter','\t')

EI =  (fft2(IE));
axes(handles.axes8)
EI = abs(fftshift(EI.*conj(EI)));
imagesc(EI);axis image;colormap hot;axis off

if wx <= wy
    Lattice_sheet = sum(EI);
    Lattice_sheet = repmat(Lattice_sheet,size(EI,1),1);
    
    Bessel_sheet = sum(abs(fftshift(fft2(B))));
    Bessel_sheet = repmat(Bessel_sheet,size(B,1),1);
    
else
    Lattice_sheet = sum(EI');
    Lattice_sheet = repmat(Lattice_sheet',1,size(EI,1));
    
    Bessel_sheet = sum(abs(fftshift(fft2(B)))');
    Bessel_sheet = repmat(Bessel_sheet',1,size(B,1));

end

axes(handles.axes11)
Lattice_sheet = Lattice_sheet./max(Lattice_sheet(:));
imagesc(Lattice_sheet);axis image;colormap hot;axis off

axes(handles.axes10)
I_Bessel = abs(fftshift(fft2(B)));
I_Bessel = I_Bessel./max(I_Bessel(:));
imagesc(I_Bessel);axis image;colormap hot;axis off

axes(handles.axes12)
imagesc(Bessel_sheet./max(Bessel_sheet(:)));axis image;colormap hot;axis off


data = struct('Bound',A,...
              'Phi',phi,...
              'Annular',B,...
              'I_p',IE,...
              'I_i',EI,...
              'Lattice_sheet',Lattice_sheet,...
              'Bessel_sheet',Bessel_sheet,...
              'dx',dx,...
              'dy',dy,...
              'FFT_bound_lattice',FFT_bound_lattice,...
              'E_bound0',E_bound0,...
              'I_Bessel',I_Bessel);
          
set(handles.pushbutton1,'UserData',data);

set(handles.Zoom,'Enable','on')
set(handles.Zoom,'String','zoom in');

if get(handles.save,'Value') == 0
    set(h.UsedByGUIData_m.text_g_beam,'String','Lattice Beam is selected.')
end
set(handles.view,'Enable','on');
% end
% set(h.UsedByGUIData_m.text_g_beam,'String','Lattice Beam is selected.')


function a_Callback(hObject, eventdata, handles)

function a_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)

function b_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phi_Callback(hObject, eventdata, handles)

function phi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vertical_offset_Callback(hObject, eventdata, handles)

function vertical_offset_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wx_Callback(hObject, eventdata, handles)

function wx_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wy_Callback(hObject, eventdata, handles)

function wy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton2_Callback(hObject, eventdata, handles)

try
set(handles.pushbutton2,'Enable','off');
set(handles.pushbutton1,'Enable','off');
set(handles.view,'Enable','off');
set(handles.Zoom,'Enable','off');

h = getappdata(SSPIM_Toolbox);

Nx = str2num(get(h.UsedByGUIData_m.Nx,'String'));
Ny = str2num(get(h.UsedByGUIData_m.Ny,'String'));
x0 = str2num(get(h.UsedByGUIData_m.Lx,'String')).*1e-2;
y0 = str2num(get(h.UsedByGUIData_m.Ly,'String')).*1e-2;
if Nx <= 0 | Ny <=0 | x0 <= 0 | y0 <=0
    Initialize_dialog;

else

x = linspace(-x0./2,x0./2,Nx);
y = linspace(-y0./2,y0./2,Nx).*abs(x0./y0);
I0 = 0;
theta = 0;

a = str2num(get(handles.a,'String')).*1e-3;
b = str2num(get(handles.b,'String')).*1e-3;
phi = str2num(get(handles.phi,'String'));

x0 = str2num(get(handles.alpha,'String')).*1e-3;
y0 = str2num(get(handles.beta,'String')).*1e-3;

[X Y] = meshgrid(x,y);

cb = b.*sind(phi);
ca = sqrt(abs(b^2-cb^2));
vertical_offset = cb;
u0 = zeros(Nx,Nx);
count = 0;
for yt = (y(1):cb:y(1)+cb)+vertical_offset
    if count == 0
        for xt = x(1):a:x(end)
            [X Y] = meshgrid(x+xt,y+yt);
            u0 = exp(-(((X)./x0).^2+((Y)./y0).^2))+u0;
        end
        count = 1;
    else
        for xt = (x(1):a:x(end))+ca
            [X Y] = meshgrid(x+xt,y+yt);
            u0 = exp(-(((X)./x0).^2+((Y)./y0).^2))+u0;
        end
        count = 0;
    end

end
I0 = I0+u0;

%%
II = (Y<=Y(end,1)-cb/2).*(Y>Y(end,1)-(2.5.*cb));
[xf yf] =  find(Y<Y(end,1)-cb/2 & Y>Y(end,1)-(2.5.*cb));
If = I0(xf(1):xf(end),yf(1):yf(end)); 
I_rep = repmat(If,ceil(size(If,2)./size(If,1)),1);
I0 = I_rep;
axes(handles.axes1)
imagesc(I0);axis image;colormap hot;axis off
I0 = I0(1:Nx,1:Nx);

%%
data = struct('Lattice',I0);
set(handles.pushbutton2,'UserData',data);
set(handles.pushbutton2,'Enable','on');
set(handles.pushbutton1,'Enable','on');

end
end

function xt_bound_Callback(hObject, eventdata, handles)

function xt_bound_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yt_bound_Callback(hObject, eventdata, handles)

function yt_bound_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)

function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)

function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ro_Callback(hObject, eventdata, handles)

function Ro_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ri_Callback(hObject, eventdata, handles)

function Ri_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Zoom_Callback(hObject, eventdata, handles)


Ro = str2num(get(handles.Ro,'String'));
dx = get(handles.pushbutton1,'UserData');
dx = dx.dx;
dy = get(handles.pushbutton1,'UserData');
dy = dy.dy;
I0 = get(handles.pushbutton2,'UserData');
I0 = I0.Lattice;
Bound = get(handles.pushbutton1,'UserData');
Bound = Bound.Bound;
E_bound0 = get(handles.pushbutton1,'UserData');
E_bound0 = E_bound0.E_bound0;
Annular = get(handles.pushbutton1,'UserData');
Annular = Annular.Annular;
I_p = get(handles.pushbutton1,'UserData');
I_p = I_p.I_p;
I_i = get(handles.pushbutton1,'UserData');
I_i = I_i.I_i;
x = find(Annular(end/2,:) == 1);
FFT_bound_lattice = get(handles.pushbutton1,'UserData');
FFT_bound_lattice = FFT_bound_lattice.FFT_bound_lattice;
Lattice_sheet = get(handles.pushbutton1,'UserData');
Lattice_sheet = Lattice_sheet.Lattice_sheet;
Bessel_sheet = get(handles.pushbutton1,'UserData');
Bessel_sheet = Bessel_sheet.Bessel_sheet;
I_Bessel = get(handles.pushbutton1,'UserData');
I_Bessel = I_Bessel.I_Bessel;

if strcmp(get(handles.Zoom,'String'),'zoom in')
    
    axes(handles.axes1)
    imagesc(I0(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes2)
    imagesc(Bound(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes4)
    imagesc(E_bound0(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes6)
    imagesc(Annular(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes7)
    imagesc(I_p(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes8)
    imagesc(I_i(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes13)
    imagesc(FFT_bound_lattice(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes11)
    imagesc(Lattice_sheet(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes12)
    imagesc(Bessel_sheet(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
    axes(handles.axes10)
    imagesc(I_Bessel(x(1):x(end),x(1):x(end)));axis image;axis off,colormap hot
 
    set(handles.Zoom,'String','zoom out');
else
    axes(handles.axes1)
    imagesc(I0);axis image;axis off,colormap hot
    axes(handles.axes2)
    imagesc(Bound);axis image;axis off,colormap hot
    axes(handles.axes4)
    imagesc(E_bound0);axis image;axis off,colormap hot
    axes(handles.axes6)
    imagesc(Annular);axis image;axis off,colormap hot
    axes(handles.axes7)
    imagesc(I_p);axis image;axis off,colormap hot
    axes(handles.axes8)
    imagesc(I_i);axis image;axis off,colormap hot
    axes(handles.axes13)
    imagesc(FFT_bound_lattice);axis image;axis off,colormap hot
    axes(handles.axes11)
    imagesc(Lattice_sheet);axis image;axis off,colormap hot
    axes(handles.axes12)
    imagesc(Bessel_sheet);axis image;axis off,colormap hot
    axes(handles.axes10)
    imagesc(I_Bessel);axis image;axis off,colormap hot
 
    set(handles.Zoom,'String','zoom in');
end



function alpha_Callback(hObject, eventdata, handles)

function alpha_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_Callback(hObject, eventdata, handles)

function beta_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_Callback(hObject, eventdata, handles)

function theta_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function view_Callback(hObject, eventdata, handles)

Ro = str2num(get(handles.Ro,'String'));
dx = get(handles.pushbutton1,'UserData');
dx = dx.dx;
dy = get(handles.pushbutton1,'UserData');
dy = dy.dy;
I0 = get(handles.pushbutton2,'UserData');
I0 = I0.Lattice;
Bound = get(handles.pushbutton1,'UserData');
Bound = Bound.Bound;
E_bound0 = get(handles.pushbutton1,'UserData');
E_bound0 = E_bound0.E_bound0;
Annular = get(handles.pushbutton1,'UserData');
Annular = Annular.Annular;
I_p = get(handles.pushbutton1,'UserData');
I_p = I_p.I_p;
I_i = get(handles.pushbutton1,'UserData');
I_i = I_i.I_i;
x = find(Annular(end/2,:) == 1);
FFT_bound_lattice = get(handles.pushbutton1,'UserData');
FFT_bound_lattice = FFT_bound_lattice.FFT_bound_lattice;
Lattice_sheet = get(handles.pushbutton1,'UserData');
Lattice_sheet = Lattice_sheet.Lattice_sheet;
Bessel_sheet = get(handles.pushbutton1,'UserData');
Bessel_sheet = Bessel_sheet.Bessel_sheet;
I_Bessel = get(handles.pushbutton1,'UserData');
I_Bessel = I_Bessel.I_Bessel;

figure
imagesc(I0./max(I0(:)));axis image;axis off,colormap hot;
title('Ideal Lattice');colorbar

figure
imagesc(Bound./max(Bound(:)));axis image;axis off,colormap hot
title('Bounding function');colorbar

figure
imagesc(E_bound0);axis image;axis off,colormap hot
title('Bound Lattice');colorbar

figure
imagesc(FFT_bound_lattice);axis image;axis off,colormap hot
title('FFT of bound Lattice');colorbar

figure
imagesc(Annular);axis image;axis off,colormap hot
title('Annular Mask');colorbar

figure
imagesc(I_p);axis image;axis off,colormap hot
title('SLM Pattern');colorbar

figure
imagesc(I_i./max(I_i(:)));axis image;axis off,colormap hot
title('Predicted Lattice');colorbar

figure
imagesc(Lattice_sheet);axis image;axis off,colormap hot
title('Dithered Lattice beam');colorbar

figure
imagesc(I_Bessel);axis image;axis off,colormap hot
title('Single Bessel beam');colorbar

figure
imagesc(Bessel_sheet./max(Bessel_sheet(:)));axis image;axis off,colormap hot
title('Scanned Bessel beam');colorbar




function save_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function axes7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes7
