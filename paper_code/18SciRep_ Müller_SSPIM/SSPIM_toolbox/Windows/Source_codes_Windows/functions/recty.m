function out = recty(X,Y,x0,y0,xt,yt,theta)
[Xrot Yrot] = Rotaion(X-xt,Y-yt,theta);
out = zeros(size(Y));
out(Yrot<=y0/2 & Yrot>=-y0/2) = 1;