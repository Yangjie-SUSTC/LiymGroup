function [phi] = airy_c_phase(X,Y,xt,yt,a) 
[theta r] = Radius_Theta(X,Y,xt,-yt);
phi = a.*(r.^3);


