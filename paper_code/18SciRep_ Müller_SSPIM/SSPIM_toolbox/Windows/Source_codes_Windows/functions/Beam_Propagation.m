% Fourier Methode --- Linear Beam Propagation  Code-2D
% Created by Mostafa Aakhte
% Department of Physics IASBS (19-Feb-2013)(3:10 AM)
%--------------------------------------------------------------------------
function [out] = Beam_Propagation(l0,Nx,hologram)
k0=2*pi/l0;
%------------------------mesh----------------------------------------------
x0=30e-6;  %Initial Coordinate
x=linspace(-30e-6,30e-6,Nx);
[Xn,Yn]=meshgrid(x,x);

%------------------------Gaussian Beam-------------------------------------
f=30e-6;
pp=k0.*(x.^2)/(2*f);
Lens=exp(-1j*k0.*1.*(Xn.^2+Yn.^2)/(2*f));
Phase=exp(-1j*hologram);
E0=exp(-4*log(2).*((Xn)/x0).^2).*exp(-4*log(2).*((Yn)/x0).^2).*Lens.*Phase;

%------------------------Define K-vector-----------------------------------
L=max(x)-min(x);
kx=-(2*pi/L).*[0:Nx/2-1 -Nx/2:-1];
[Kx,Ky]=meshgrid(kx,kx);

%--------------------------Propagation-------------------------------------


Ez=ifft2(fft2(E0).*exp(-1j.*f.*(Kx.^2+Ky.^2)./(2*k0)));
I=Ez.*conj(Ez);
out = I;
figure(2)
imagesc(x*1e3,x*1e3,I);axis image; colormap parula;colorbar


