% Run_this_file_for_DDWMR_model

%% parameter
r  = 0.05;                       % wheel's radium (m)
mc = 10;                         % robot platform's weight (kg)
mw = 2.5;                        % Wheel's weight (kg)
m  = mc+2*mw;                    % total weight (kg)
L  = 0.235/2;                    % half of distance between two wheels (m)
d  = 0.1;                        % distance betwen medium point of axis of wheels and center of mass(m)
Ic = 0.05;                       % inertia of robot about vertical axis (kg.m^2)
Iw = 0.025;                      % inertia of wheel about wheel axis (kg.m^2)
Im = 0.025;                      % inertia of wheel about wheel diameter (kg.m^2)
I  = Ic +mc*d^2+2*mw*L^2+2*Im;   % inertia of whole robot (kg.m^2)

%% Initial condition
theta_0=0;
x_0=0;
y_0=0;
v_0=0;
w_0=0;

q_initial = [theta_0;x_0;y_0];   % initial for reference kinematic model
V_initial = [v_0;w_0];


  
%% sampling time
Ts = 0.01;  % (s)

%% covariance of measurement noise
R = 1e-3;

% number of meansurement nodes
N =6;

%% run this for pruning observer

TP = 0.6;
s = 0.5;
eta = 0.8;
rp=0.6;
