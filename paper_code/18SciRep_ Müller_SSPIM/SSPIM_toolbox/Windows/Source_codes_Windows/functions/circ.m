function out = circ(X,Y,r0,xt,yt)
[theta r] = Radius_Theta(X,Y,xt,yt);
out = zeros(size(r));
out(r<=r0) = 1;
