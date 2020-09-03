function out = sGauss(X,Y,x0,y0,xt,yt,theta)
[Xrot Yrot] = Rotaion(X-xt,Y-yt,theta);
r = sqrt(((Xrot)./x0).^2+((Yrot)./y0).^2);
out = exp(-(r).^2000);