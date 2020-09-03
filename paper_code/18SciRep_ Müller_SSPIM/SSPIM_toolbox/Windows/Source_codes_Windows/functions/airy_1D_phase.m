function [phi] = airy_1D_phase(X,Y,xt,yt,theta,a) 
[X,Y] = Rotaion(X-xt.*1e-3,Y-yt.*1e-3,theta);
phi = a.*((X).^3);

