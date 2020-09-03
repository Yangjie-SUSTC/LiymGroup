function out = Damman_grating_2D(Lx,N,freq,n)
u1 = Damman_grating_1D(Lx,N,freq,n,0);
D = u1+u1';
D(D==0) =1;
D(D==-2) =-1;
D(D==2) =-1;
out = D;