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
C = ([1 0 0 0; 0 1 0 0]);
D = ([0]);

states = {'x'; 'theta'; 'xdot'; 'thetadot'};
inputs = {'u'};
outputs = {'x', 'theta'};
sys = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);

t = 0:0.01:1;
figure
impulse(sys, t)
figure
bode(sys)
figure
pzmap(tf(sys))