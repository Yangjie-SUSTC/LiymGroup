function out = ring(X,Y,r_out,r_in,xt,yt)
c_out = circ(X,Y,r_out,xt,yt);
c_in = circ(X,Y,r_in,xt,yt);
out = c_out-c_in;
