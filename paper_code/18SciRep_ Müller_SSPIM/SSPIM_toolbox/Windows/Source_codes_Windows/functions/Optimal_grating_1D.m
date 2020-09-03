function out = Optimal_grating_1D(Nx,Ny,freq,n,rot)
fid=fopen('Optimal_Grating_alpha_Values.txt');
C = textscan(fid, '%s','delimiter', '\n');
if rot == 0
    x = linspace(-pi,pi,Ny).*freq;
else
    x = linspace(-pi,pi,Nx).*freq;
end
if n <=11 & n > 0
    alpha = str2num(C{1,1}{n,1});
else 
    alpha = 0 ;
end   
P = 1;
Q = 0;
for k = 1:size(alpha,2)
    P = (2.*cos(alpha(k)).*cos(k.*x))+P;
    Q = (2.*sin(alpha(k)).*cos(k.*x))+Q;
end
phi = unwrap(2.*atan(Q./P))./2;
if rot == 0
    out = repmat(phi,Nx,1);
else
    out = repmat(phi',1,Ny);
end
