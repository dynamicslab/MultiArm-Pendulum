%% This function is used to calculate the ODE of the single pendulum (mounted)
% Author: KK
% Date: 03/Oct/2021

%%
clc;clear;
%%
syms m1 L1 a1 I1 k1 g the1(t) dthe1(t) ddthe1 var1 var2 dum
%%
x1=a1*sin(the1);
y1=a1*cos(the1);
v1x=diff(x1,t);
v1y=diff(y1,t);
%%
%Subs dthe1
v1x=subs(v1x,diff(the1(t), t),dthe1);
v1y=subs(v1y,diff(the1(t), t),dthe1);
%%
%Define the Lagrangian and Damping coeificient
Damp=0.5*k1*dthe1^2;
Lag=0.5*m1*(v1x^2+v1y^2)+0.5*(I1)*dthe1^2-m1*g*y1;
%%
the1Part1=diff(subs(Lag,dthe1,dum),dum);
the1Part1=subs(the1Part1,dum,dthe1);
the1Part1=diff(the1Part1,t);
%
the1Part2=diff(subs(Lag,the1,dum),dum);
the1Part2=subs(the1Part2,dum,the1);
% 
the1Part3=diff(subs(Damp,dthe1,dum),dum);
the1Part3=subs(the1Part3,dum,dthe1);
eqn1=the1Part1-the1Part2+the1Part3==0;
%%
%Now substitute the second derivative
eqn1=subs(eqn1,diff(the1(t), t),dthe1);
eqn1=subs(eqn1,diff(dthe1(t), t),ddthe1);
eqn1=subs(eqn1,diff(the1(t), t , t),ddthe1);
%%
%Nowsolve for ddthe1
eqns=[eqn1];
vars=[ddthe1];
[Ans1]=solve(eqns,vars);
Ans1=simplify(Ans1)
%%
%Get Jacobian
syms dum1 dum2 dum3 dum4 u y1 y2 y3 y4
Ans2=simplify(subs(Ans1,[the1(t) dthe1(t)],[var1 var2]))
