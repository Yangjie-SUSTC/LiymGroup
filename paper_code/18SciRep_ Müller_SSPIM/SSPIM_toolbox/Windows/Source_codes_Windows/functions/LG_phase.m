function [phi] = LG_phase(X,Y,xt,yt,l) 
[theta r] = Radius_Theta(X,Y,xt,-yt);
phi = l.*(theta);