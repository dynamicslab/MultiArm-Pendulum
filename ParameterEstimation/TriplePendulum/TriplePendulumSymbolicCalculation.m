%% This file will calculate the equation of motion of the triple pendulum. 
%
% Coded By: KK
% Last Updated: 05/11/2022
%% Clear all previous result
clc;clear all; close all;

%% Define some variables
syms M m1 m2 m3 L1 L2 L3 I1 I2 I3 k0 k1 k2 k3 g x(t) the1(t) the2(t) the3(t) a1 a2 a3 dum Acce
syms dx(t) dthe1(t) dthe2(t) dthe3(t) ddx(t) ddthe1(t) ddthe2(t) ddthe3(t) y1 y2 y3 Acce dumddthe1 dumddthe2 dumddthe3

%% Define the center of mass position of the pendulum arm
x0=x;
x1=x0+a1*sin(the1);
x2=x0+L1*sin(the1)+a2*sin(the2);
x3=x0+L1*sin(the1)+L2*sin(the2)+a3*sin(the3);
%
y1=a1*cos(the1);
y2=L1*cos(the1)+a2*cos(the2);
y3=L1*cos(the1)+L2*cos(the2)+a3*cos(the3);
%
v0=diff(x0,t);
v1x=diff(x1,t);
v1y=diff(y1,t);
v2x=diff(x2,t);
v2y=diff(y2,t);
v3x=diff(x3,t);
v3y=diff(y3,t);

%% Get its velocity
%Substitute variables
v0=subs(v0,diff(x(t), t),dx);
v1x=subs(v1x,diff(x(t), t),dx);
v1y=subs(v1y,diff(x(t), t),dx);
v2x=subs(v2x,diff(x(t), t),dx);
v2y=subs(v2y,diff(x(t), t),dx);
v3x=subs(v3x,diff(x(t), t),dx);
v3y=subs(v3y,diff(x(t), t),dx);
%Subs dthe1
v1x=subs(v1x,diff(the1(t), t),dthe1);
v1y=subs(v1y,diff(the1(t), t),dthe1);
v2x=subs(v2x,diff(the1(t), t),dthe1);
v2y=subs(v2y,diff(the1(t), t),dthe1);
v3x=subs(v3x,diff(the1(t), t),dthe1);
v3y=subs(v3y,diff(the1(t), t),dthe1);
%Subs dthe2
v1x=subs(v1x,diff(the2(t), t),dthe2);
v1y=subs(v1y,diff(the2(t), t),dthe2);
v2x=subs(v2x,diff(the2(t), t),dthe2);
v2y=subs(v2y,diff(the2(t), t),dthe2);
v3x=subs(v3x,diff(the2(t), t),dthe2);
v3y=subs(v3y,diff(the2(t), t),dthe2);
%Subs dthe3
v1x=subs(v1x,diff(the3(t), t),dthe3);
v1y=subs(v1y,diff(the3(t), t),dthe3);
v2x=subs(v2x,diff(the3(t), t),dthe3);
v2y=subs(v2y,diff(the3(t), t),dthe3);
v3x=subs(v3x,diff(the3(t), t),dthe3);
v3y=subs(v3y,diff(the3(t), t),dthe3);

%% Define the Lagrangian and Damping coeificient
Damp=simplify(0.5*k0*v0^2+0.5*k1*dthe1^2+0.5*k2*(dthe2-dthe1)^2+0.5*k3*(dthe3-dthe2)^2);
Lag=simplify(0.5*M*v0^2+0.5*m1*(v1x^2+v1y^2)+0.5*m2*(v2x^2+v2y^2)+0.5*m3*(v3x^2+v3y^2)+0.5*(I1)*dthe1^2+0.5*I2*dthe2^2+0.5*I3*dthe3^2-m1*g*y1-m2*g*y2-m3*g*y3);

%% Calculate partial derivative
the1Part1=diff(subs(Lag,dthe1,dum),dum);
the1Part1=subs(the1Part1,dum,dthe1);
the1Part1=diff(the1Part1,t);
%
the1Part2=diff(subs(Lag,the1,dum),dum);
the1Part2=subs(the1Part2,dum,the1);
% 
the1Part3=diff(subs(Damp,dthe1,dum),dum);
the1Part3=subs(the1Part3,dum,dthe1);
eqn1=simplify(the1Part1-the1Part2+the1Part3);
%
the2Part1=diff(subs(Lag,dthe2,dum),dum);
the2Part1=subs(the2Part1,dum,dthe2);
the2Part1=diff(the2Part1,t);
%
the2Part2=diff(subs(Lag,the2,dum),dum);
the2Part2=subs(the2Part2,dum,the2);
% 
the2Part3=diff(subs(Damp,dthe2,dum),dum);
the2Part3=subs(the2Part3,dum,dthe2);
eqn2=simplify(the2Part1-the2Part2+the2Part3);
%
the3Part1=diff(subs(Lag,dthe3,dum),dum);
the3Part1=subs(the3Part1,dum,dthe3);
the3Part1=diff(the3Part1,t);
%
the3Part2=diff(subs(Lag,the3,dum),dum);
the3Part2=subs(the3Part2,dum,the3);
% 
the3Part3=diff(subs(Damp,dthe3,dum),dum);
the3Part3=subs(the3Part3,dum,dthe3);
eqn3=simplify(the3Part1-the3Part2+the3Part3);

%% Now substitute the second derivative to variables
eqn1=subs(eqn1,diff(dx(t), t),ddx);
eqn1=subs(eqn1,diff(x(t), t, t),ddx);
eqn1=subs(eqn1,diff(the1(t), t),dthe1);
eqn1=subs(eqn1,diff(the2(t), t),dthe2);
eqn1=subs(eqn1,diff(the3(t), t),dthe3);
eqn1=subs(eqn1,diff(dthe1(t), t),ddthe1);
eqn1=subs(eqn1,diff(dthe2(t), t),ddthe2);
eqn1=subs(eqn1,diff(dthe3(t), t),ddthe3);
%
eqn2=subs(eqn2,diff(dx(t), t),ddx);
eqn2=subs(eqn2,diff(x(t), t, t),ddx);
eqn2=subs(eqn2,diff(the1(t), t),dthe1);
eqn2=subs(eqn2,diff(the2(t), t),dthe2);
eqn2=subs(eqn2,diff(the3(t), t),dthe3);
eqn2=subs(eqn2,diff(dthe1(t), t),ddthe1);
eqn2=subs(eqn2,diff(dthe2(t), t),ddthe2);
eqn2=subs(eqn2,diff(dthe3(t), t),ddthe3);
%
eqn3=subs(eqn3,diff(dx(t), t),ddx);
eqn3=subs(eqn3,diff(x(t), t, t),ddx);
eqn3=subs(eqn3,diff(the1(t), t),dthe1);
eqn3=subs(eqn3,diff(the2(t), t),dthe2);
eqn3=subs(eqn3,diff(the3(t), t),dthe3);
eqn3=subs(eqn3,diff(dthe1(t), t),ddthe1);
eqn3=subs(eqn3,diff(dthe2(t), t),ddthe2);
eqn3=subs(eqn3,diff(dthe3(t), t),ddthe3);

%% Nowsolve for ddthe1 and ddthe2
eqn1=subs(eqn1,ddthe1,dumddthe1);
eqn1=subs(eqn1,ddthe2,dumddthe2);
eqn1=subs(eqn1,ddthe3,dumddthe3);
%
eqn2=subs(eqn2,ddthe1,dumddthe1);
eqn2=subs(eqn2,ddthe2,dumddthe2);
eqn2=subs(eqn2,ddthe3,dumddthe3);
%
eqn3=subs(eqn3,ddthe1,dumddthe1);
eqn3=subs(eqn3,ddthe2,dumddthe2);
eqn3=subs(eqn3,ddthe3,dumddthe3);
%
eqn1=(simplify(eqn1)==0);
eqn2=(simplify(eqn2)==0);
eqn3=(simplify(eqn3)==0);

%% Solve for the second derivative
eqns=[eqn1 eqn2 eqn3];
vars=[dumddthe1 dumddthe2 dumddthe3];
[Ans1,Ans2,Ans3]=solve(eqns,vars);
Ans1=simplify(Ans1);
Ans2=simplify(Ans2);
Ans3=simplify(Ans3);

%% Define new symbolic parameters
syms z1 z2 z3 z4 z5 z6 z7 z8 Acce 
% The following will generate the ODE of mounted triple pendulum
thisisddtheta1=subs(Ans1,[the1(t) the2(t) the3(t) x(t) dthe1(t) dthe2(t) dthe3(t) dx(t) ddx(t)],[z1 z2 z3 0 z4 z5 z6 0 0])
thisisddtheta2=subs(Ans2,[the1(t) the2(t) the3(t) x(t) dthe1(t) dthe2(t) dthe3(t) dx(t) ddx(t)],[z1 z2 z3 0 z4 z5 z6 0 0])
thisisddtheta3=subs(Ans3,[the1(t) the2(t) the3(t) x(t) dthe1(t) dthe2(t) dthe3(t) dx(t) ddx(t)],[z1 z2 z3 0 z4 z5 z6 0 0])

% The following will generate ODE of triple pendulum on cart
%thisisddtheta1=subs(Ans1,[the1(t) the2(t) the3(t) x(t) dthe1(t) dthe2(t) dthe3(t) dx(t) ddx(t)],[z1 z2 z3 z4 z5 z6 z7 z8 Acce])
%thisisddtheta2=subs(Ans2,[the1(t) the2(t) the3(t) x(t) dthe1(t) dthe2(t) dthe3(t) dx(t) ddx(t)],[z1 z2 z3 z4 z5 z6 z7 z8 Acce])
%thisisddtheta3=subs(Ans3,[the1(t) the2(t) the3(t) x(t) dthe1(t) dthe2(t) dthe3(t) dx(t) ddx(t)],[z1 z2 z3 z4 z5 z6 z7 z8 Acce])

