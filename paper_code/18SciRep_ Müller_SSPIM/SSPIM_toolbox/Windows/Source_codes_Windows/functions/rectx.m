function out = rectx(X,Y,x0,y0,xt,yt,theta)
[Xrot Yrot] = Rotaion(X-xt,Y-yt,theta);
out = zeros(size(X));
out(Xrot<=x0/2 & Xrot>=-x0/2) = 1;