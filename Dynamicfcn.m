function x = Dynamicfcn(x,u)

m=10;        %weight of the whole robot (including wheels),(kg)
I=0.05;        %moment of inertia at center of mass,(kg.m^2)
d=0.1;      %distance betwen medium point of axis of wheels and center of mass,(m)
L=0.235/2;  %1/2 distance between two wheels,(m)
r=0.05;     %radius of wheels,(m)
%% unpacking intput
omega=x(2);
Ts = 0.01;
%% Parameter
M=[m*d*d+I,0;
    0,m];

M_inver=(1/(m*(m*d*d+I)))*M;

D=[0,-m*d*omega;
    m*d*omega,0];

B=(1/r)*[1,1;L,-L];

%% ODE
x_dot=M_inver*(-D*x+B*u);
x=x+x_dot*Ts;
