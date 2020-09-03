function out = rect(X,Y,a,b,xt,yt)
A = (((X-xt)./a).^2000)+(((Y-yt)./b).^2000);
out = exp(-A);