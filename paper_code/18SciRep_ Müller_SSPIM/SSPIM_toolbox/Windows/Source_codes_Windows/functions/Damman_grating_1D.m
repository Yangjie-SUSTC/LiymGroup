function out = Damman_grating_1D(Lx,N,freq,n,rot)
dL = Lx.*freq./N;
freq = freq+1;
fid = fopen('Damman_Grating_Values.txt');
C = textscan(fid, '%s','delimiter', '\n');
D = [0 str2num(C{1,1}{n,1}) 1];

D = D.*Lx;
t = 1;
c = 1;
for n = 1:size(D,2)-1
    for q = D(t):dL:D(t+1)
        if mod(n,2) == 1
            Garting_1D(:,c) = zeros(1);
        else
            Garting_1D(:,c) = ones(1);
        end
        c = c+1;
    end
    t = t+1;
end

if rot == 0
    Garting_1D = repmat(Garting_1D,1,1024);
    out = Garting_1D(1:N);
    out = repmat(out,N,1).*pi;
else
    Garting_1D = repmat(Garting_1D,1,1024);
    out = Garting_1D(1:2*N)';
    out = repmat(out,1,2*N).*pi;
end

