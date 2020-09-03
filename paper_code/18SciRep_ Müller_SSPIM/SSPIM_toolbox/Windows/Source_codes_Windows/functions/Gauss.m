function out = Gauss(X,Y,x0,y0,xt,yt,theta)
[Xrot Yrot] = Rotaion(X,Y,theta);
out = exp(-((Xrot-xt.*1e-3)./x0).^2).*exp(-((Yrot-yt.*1e-3)./y0).^2);
