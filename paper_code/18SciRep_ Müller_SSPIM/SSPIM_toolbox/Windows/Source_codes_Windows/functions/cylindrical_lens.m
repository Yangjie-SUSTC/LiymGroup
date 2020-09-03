function [phi] = cylindrical_lens(X,Y,xt,yt,theta,f) 
[X,Y] = Rotaion(X-xt.*1e-3,Y-yt.*1e-3,theta);
phi = ((X).^2)./(2.*f);