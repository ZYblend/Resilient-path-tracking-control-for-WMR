function y3 = gps(x,Z)
%gps: measurement for x,y and theta
theta = Z(1);
d=0.1;      %distance betwen medium point of axis of wheels and center of mass,(m)
% sampling time
Ts = 0.001; % [s]

% C=[0,1;
%     cos(x(2)*Ts),-d*sin(x(2)*Ts);
%     sin(x(2)*Ts),d*cos(x(2)*Ts)];

C=[ cos(theta),-d*sin(theta);
    sin(theta),d*cos(theta)];
y3=C*x;
end

