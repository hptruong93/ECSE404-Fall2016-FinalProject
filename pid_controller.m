%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = 1.03; %kg
M = 2.5; %kg
l = 0.75; %m
g = 9.81; %m^2/s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% System construction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = -m * g / M;
b = (M + m) * g / (l * M);
c = 1 / M;
d = (-1)/(l * M);

A = ([0 0 1 0; 0 0 0 1; 0 a 0 0; 0 b 0 0]);
B = ([0; 0; c; d]);
C = ([0 0 0 1]);
D = ([0]);

states = {'x'; 'theta'; 'xdot'; 'thetadot'};
inputs = {'u'};
outputs = {'thetadot'};
sys = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);

p = 1;
i = 1;
d = 1;
Kp = p;
Ki = i;
Kd = d;
controller = pid(Kp,Ki,Kd);
sys_pid = feedback(sys, controller);

t = 0:0.01:10;
figure;
impulse(sys_pid, t);
figure
bode(sys_pid)
figure
pzmap(tf(sys_pid))