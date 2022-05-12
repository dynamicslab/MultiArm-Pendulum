%% This file is used to simulate the triple pendulum given initial conditions
% By: KK
% Last Updated: 05/11/2022
%
%% Close all and celar all
clc;clear all;close all;
%% Define the parameters
%Define the gravity constant and the first and second pendlum arm length 
g=9.81;L1=0.1727;L2=0.2286;L3=0.2413;
%The mass of the first and second pendulum arm mass
m1=0.11;m2=0.12;m3=0.1;
%The center of the mass of th efirst and second pendulum arm
a1=0.08755;a2=0.127;a3=0.12;
%The inertial of the first and second pendulum arm
I1=0.001578;I2=0.0029;I3=0.002157;
%Damping coeeficient of the first and second pendulum arm
k1=1e-4;k2=1e-4;k3=1e-4;

%% Simulate the dynamics
tspan=0:0.001:3;

x0=[pi+0.1;pi;pi;0;0;0];

[t,y]=ode89(@(t,y)TriplePendulumODE_Mounted(t,y,m1,m2,m3,a1,a2,a3,L1,L2,I1,I2,I3,k1,k2,k3,g),tspan,x0);

%% Plot it
figure(1)
plot(t,y(:,1),Color="blue",LineWidth=2.5)
xlabel("Time")
ylabel("\theta_1")
grid on

figure(2)
plot(t,y(:,2),Color="blue",LineWidth=2.5)
xlabel("Time")
ylabel("\theta_2")
grid on

figure(3)
plot(t,y(:,3),Color="blue",LineWidth=2.5)
xlabel("Time")
ylabel("\theta_3")
grid on


