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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program starts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q = C'*C;
R = 1;
Q(1,1) = 500;
Q(2,2) = 10;

K = lqr(A,B,Q,R);

Ac = [(A-B*K)];
Bc = [B];
Cc = [C];
Dc = [D];

states = {'x'; 'x_dot'; 'theta'; 'theta_dot'};
inputs = {'u'};
outputs = {'x', 'theta'};
sys = ss(Ac,Bc,Cc,Dc,'statename',states,'inputname',inputs,'outputname',outputs);

t = 0:0.01:10;
figure
impulse(sys, t)
figure
bode(sys)
figure
pzmap(tf(sys))

