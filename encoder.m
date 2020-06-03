function y2 = encoder(x)
%encoder: measurement for wl and wr

L=0.235/2;  %1/2 distance between two wheels,(m)
r=0.05;     %radius of wheels,(m)

C=[0.25/r,0.25*L/r;
    0.25/r,-0.25*L/r];
y2=C*x;

end

