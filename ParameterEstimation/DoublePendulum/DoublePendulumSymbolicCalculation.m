%% This file will calculate the equation of motion of the double pendulum 
% and it's Hamiltonian.
%
% Coded By: KK
% Last Updated: 05/06/2019
%% Clear all, close all
clc;clear;

%% Define the parameters and variables that we need
syms M m1 m2 L1 L2 I1 I2 k0 k1 k2 g x(t) the1(t) the2(t) a1 a2 dum
syms dx(t) dthe1(t) dthe2(t) ddx(t) ddthe1(t) ddthe2(t) dumddthe1 dumddthe2 Acce ds

%% Calculate the intermediate variables 
% Calculate the position of mass center of each pendulum arm
x0=x;
x1=x0+a1*sin(the1);
x2=x0+L1*sin(the1)+a2*sin(the2);

% Note: How you define the "y" position of the pendulum arm, will determine
% how you define your "zero angle" of the pendulum, here by adding a minus
% sign, we are assuming the down-down position is the zero angle
y1=-a1*cos(the1);
y2=-L1*cos(the1)-a2*cos(the2);

%y1=-y1;
%y2=-y2;

% Calculate the velocity of the mass center
v0=diff(x0,t);
v1x=diff(x1,t);
v1y=diff(y1,t);
v2x=diff(x2,t);
v2y=diff(y2,t);

%Substitute variables
v0=subs(v0,diff(x(t), t),dx);
v1x=subs(v1x,diff(x(t), t),dx);
v1y=subs(v1y,diff(x(t), t),dx);
v2x=subs(v2x,diff(x(t), t),dx);
v2y=subs(v2y,diff(x(t), t),dx);

% Subs dthe1
v1x=subs(v1x,diff(the1(t), t),dthe1);
v1y=subs(v1y,diff(the1(t), t),dthe1);
v2x=subs(v2x,diff(the1(t), t),dthe1);
v2y=subs(v2y,diff(the1(t), t),dthe1);

% Subs dthe2
v1x=subs(v1x,diff(the2(t), t),dthe2);
v1y=subs(v1y,diff(the2(t), t),dthe2);
v2x=subs(v2x,diff(the2(t), t),dthe2);
v2y=subs(v2y,diff(the2(t), t),dthe2);

%% Calculate  the Lagrangian and Hamiltonian
%Define the Lagrangian and Damping coeificient
Damp=0.5*k0*v0^2+0.5*k1*dthe1^2+0.5*k2*(dthe2-dthe1)^2;
TEng=0.5*M*v0^2+0.5*m1*(v1x^2+v1y^2)+0.5*m2*(v2x^2+v2y^2)+0.5*(I1)*dthe1^2+0.5*I2*dthe2^2;
PEng=m1*g*y1+m2*g*y2;
Lag=0.5*M*v0^2+0.5*m1*(v1x^2+v1y^2)+0.5*m2*(v2x^2+v2y^2)+0.5*(I1)*dthe1^2+0.5*I2*dthe2^2-m1*g*y1-m2*g*y2;
LagEng=TEng+PEng;

%% Substitute the intermediate variables
% Subsitute the first one
the1Part1=diff(subs(Lag,dthe1,dum),dum);
the1Part1=subs(the1Part1,dum,dthe1);
the1Part1=diff(the1Part1,t);
%
the1Part2=diff(subs(Lag,the1,dum),dum);
the1Part2=subs(the1Part2,dum,the1);
% 
the1Part3=diff(subs(Damp,dthe1,dum),dum);
the1Part3=subs(the1Part3,dum,dthe1);
eqn1=the1Part1-the1Part2+the1Part3;

% Subsitute the second one
the2Part1=diff(subs(Lag,dthe2,dum),dum);
the2Part1=subs(the2Part1,dum,dthe2);
the2Part1=diff(the2Part1,t);
%
the2Part2=diff(subs(Lag,the2,dum),dum);
the2Part2=subs(the2Part2,dum,the2);
% 
the2Part3=diff(subs(Damp,dthe2,dum),dum);
the2Part3=subs(the2Part3,dum,dthe2);
eqn2=the2Part1-the2Part2+the2Part3;

% Now substitute the second derivative to variables
eqn1=subs(eqn1,diff(dx(t), t),ddx);
eqn1=subs(eqn1,diff(x(t), t, t),ddx);

eqn1=subs(eqn1,diff(the1(t), t),dthe1);
eqn1=subs(eqn1,diff(the2(t), t),dthe2);

eqn1=subs(eqn1,diff(dthe1(t), t),ddthe1);
eqn1=subs(eqn1,diff(dthe2(t), t),ddthe2);

eqn2=subs(eqn2,diff(dx(t), t),ddx);
eqn2=subs(eqn2,diff(x(t), t, t),ddx);

eqn2=subs(eqn2,diff(the1(t), t),dthe1);
eqn2=subs(eqn2,diff(the2(t), t),dthe2);

eqn2=subs(eqn2,diff(dthe1(t), t),ddthe1);
eqn2=subs(eqn2,diff(dthe2(t), t),ddthe2);

%Nowsolve for ddthe1 and ddthe2
eqn1=subs(eqn1,ddthe1,dumddthe1);
eqn1=subs(eqn1,ddthe2,dumddthe2);
%
eqn2=subs(eqn2,ddthe1,dumddthe1);
eqn2=subs(eqn2,ddthe2,dumddthe2);
% 
EOM1=eqn1;
EOM2=eqn2;
%
eqn1=(simplify(eqn1)==0);
eqn2=(simplify(eqn2)==0);
%
eqns=[eqn1 eqn2];
Lag1=simplify(eqn1);
Lag2=simplify(eqn2);

%% Prrtify the expression
% Define the new variable: theta1=z1, theta2=z2, dtheta1=dz1, dtheta2=dz2,
% ddtheta1 =ddz1, ddtheta2=ddz2. For the mounted double pendulum we do not 
% consider the cart movement and set variables related to the x position to 
% zeros.  
syms z1 z2 dz1 dz2 ddz1 ddz2

% Prretify and calculate the total energy (Hamiltonian).
Lag1=subs(Lag1,[the1(t) the2(t) dthe1(t) dthe2(t) dumddthe1 dumddthe2 ddx(t)],[z1 z2 dz1 dz2 ddz1 ddz2 Acce]);
Lag2=subs(Lag2,[the1(t) the2(t) dthe1(t) dthe2(t) dumddthe1 dumddthe2 ddx(t)],[z1 z2 dz1 dz2 ddz1 ddz2 Acce]);
EOM1=subs(EOM1,[the1(t) the2(t) dthe1(t) dthe2(t) dumddthe1 dumddthe2 ddx(t)],[z1 z2 dz1 dz2 ddz1 ddz2 Acce]);
EOM2=subs(EOM2,[the1(t) the2(t) dthe1(t) dthe2(t) dumddthe1 dumddthe2 ddx(t)],[z1 z2 dz1 dz2 ddz1 ddz2 Acce]);
Tenergy=subs(TEng,[the1(t) the2(t) dthe1(t) dthe2(t) dumddthe1 dumddthe2 dx(t) ddx(t)],[z1 z2 dz1 dz2 ddz1 ddz2 0 0]);
PotentialEng=subs(PEng,[the1(t) the2(t) dthe1(t) dthe2(t) dumddthe1 dumddthe2 dx(t) ddx(t)],[z1 z2 dz1 dz2 ddz1 ddz2 0 0]);
Hamil=subs(LagEng,[the1(t) the2(t) dthe1(t) dthe2(t) dumddthe1 dumddthe2 dx(t) ddx(t) M],[z1 z2 dz1 dz2 ddz1 ddz2 0 0 0]);

% Print the EOM
fprintf('\n\n\n **********The symbolic form of the expression are:**********\n\n\n')
fprintf('\v Print the EOM of the double pendulum \n')
fprintf('\n\t ***The first EOM is:***\n')
fprintf('\n\t %s \n',char(simplify(Lag1)))

fprintf('\n\t ***The second EOM is:***\n')
fprintf('\n\t %s \n',char(simplify(Lag2)))

% Print the Kinetic energy
fprintf('\n\t ***The kinetic energy of the system is:***\n')
fprintf('\n\t %s \n',char(simplify(Tenergy)))

% Print the Potential energy
fprintf('\n\t ***The potential energy of the system is:***\n')
fprintf('\n\t %s \n',char(simplify(PotentialEng)))

% Print the Hamiltonian
fprintf('\n\t ***The Hamiltonian of the system is:***\n')
fprintf('\n\t %s \n',char(simplify(Hamil)))

% Below showns the Lagrangian mentioned in the paper by Graichen et al., we put it here just to double check our result
% LagNum1=(I1+a1^2*m1+L1^2*m2)*ddz1+a2*L1*m2*cos(z1 - z2)*ddz2-(a1*m1+L1*m2)*g*sin(z1)+a2*L1*m2*sin(z1 - z2)*dz2^2+k1*dz1+k2*(dz1 - dz2)-(a1*m1+L1*m2)*cos(z1)*Acce;
% LagNum2=a2*L1*m2*cos(z1-z2)*ddz1+(I2+a2^2*m2)*ddz2-a2*g*m2*sin(z2)-a2*L1*m2*sin(z1-z2)*dz1^2-k2*(dz1-dz2)-a2*m2*cos(z2)*Acce;

% Print the residual of our model and the one in the paper 
% (This residual will become zero when we use the same coordinate formulation shown in paper)
% fprintf('\n\t ***The first residual is:***\n')
% fprintf('\n\t %s \n',simplify(EOM1-LagNum1))
% fprintf('\n\t ***The second residual is:***\n')
% fprintf('\n\t %s \n',simplify(EOM2-LagNum2))

%% We calculate the system ODE in this sub section
% The ODE of the system is calcultaed by solving the EOM.
vars=[dumddthe1 dumddthe2];
[Ans1 Ans2]=solve(eqns,vars);

%ddthe1
Ans1=simplify(Ans1);

%ddthe2
Ans2=simplify(Ans2);

% Pretify the result
thisisddtheta1=simplify(subs(Ans1,[the1(t) the2(t) dthe1(t) dthe2(t) ddx(t)],[z1 z2 dz1 dz2 Acce]));
thisisddtheta2=simplify(subs(Ans2,[the1(t) the2(t) dthe1(t) dthe2(t) ddx(t)],[z1 z2 dz1 dz2 Acce]));

%%
% Edit this part to determine whether you want the friction in the final model and whether you
% want the pendulum to be mounted
%thisisddtheta1=simplify(subs(thisisddtheta1,[k1 k2 Acce],[0 0 0]));
%thisisddtheta2=simplify(subs(thisisddtheta2,[k1 k2 Acce],[0 0 0]));
thisisddtheta1=simplify(subs(thisisddtheta1,Acce,0));
thisisddtheta2=simplify(subs(thisisddtheta2,Acce,0));


% Print the result of ODE
fprintf('\v The ODE of the double pendulum \n')
fprintf('\n\t ***The first ODE is:***\n')
fprintf('\n\t %s \n',char(simplify(thisisddtheta1)))

fprintf('\n\t ***The second ODE is:***\n')
fprintf('\n\t %s \n',char(simplify(thisisddtheta2)))
