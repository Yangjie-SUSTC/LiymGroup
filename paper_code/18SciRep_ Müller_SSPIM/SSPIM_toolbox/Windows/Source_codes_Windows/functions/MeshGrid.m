function [X Y r theta] = MeshGrid(x0,y0,Nx,Ny)
x = linspace(-x0./2,x0./2,Nx);
y = linspace(-y0./2,y0./2,Nx).*abs(x0./y0);
[X Y] = meshgrid(x,y);
[theta r] = cart2pol(X,Y);
