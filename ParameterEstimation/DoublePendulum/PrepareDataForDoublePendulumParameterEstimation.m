%% Description:
% This file is used to process the double pendulum experimental data. It
% can help users remove the noise in velocity measurement, and generate a
% cell array that chops the single measurmeent data into pices. This cell
% array can then be used to identify the parameters of the pendulum setup.
%
% Author: KK
% Date: 07/Oct/2021

%% Clear all the data
clc;clear all;close all;

%% Let user define the file name of the pendulum measurement data
filename='DoublePendulumData_Raw.mat';

%% Let user determine how many pices they would like to chop the measurements
Npices=30;
% Determine how many of the pices you would like to use as validation data
Nvad=4;

%% Let user define where the actual experiments starts
time_start=20000;
time_end=100000;

%% Load the file for processing
load(filename);

%% Extract the measurement data time information and pendulum arm angular position and velocity information
% Prepare the data from time series to time vector
Theta1Raw=data{1}.Values.data;
dTheta1Raw=data{3}.Values.data;
Theta2Raw=data{2}.Values.data;
dTheta2Raw=data{4}.Values.data;
% Extract the timming information
Time=data{1}.Values.Time;
% Determine the time-step used during the data logging
dt=Time(2)-Time(1);

%% Now, denoise the volocity data (THe angular data is farily clean, and there's no need to filter it)
% First get rid of the unexpected peak
dTheta1Denoised1=medfilt1(dTheta1Raw,10);
dTheta2Denoised1=medfilt1(dTheta2Raw,10);
% Next, use "wden" to denoise the previous one more data 
wname = 'db3';
lev = 4;
dTheta1Denoised2= wden(dTheta1Denoised1,'sqtwolog','s','mln',lev,wname);
dTheta2Denoised2= wden(dTheta2Denoised1,'sqtwolog','s','mln',lev,wname);
%
close all
figure(1)
plot(Time(20000:26000),dTheta1Raw(20000:26000),'LineWidth',2.5)
hold on 
plot(Time(20000:26000),dTheta1Denoised1(20000:26000),'LineWidth',2.5)
plot(Time(20000:26000),dTheta1Denoised2(20000:26000),'LineWidth',2.5)
legend('Noisy','Denoised1','Denoised2')
xlabel("t (s)")
ylabel("d\theta_1")
grid on

figure(2)
plot(Time(20000:26000),dTheta2Raw(20000:26000),'LineWidth',2.5)
hold on 
plot(Time(20000:26000),dTheta2Denoised1(20000:26000),'LineWidth',2.5)
plot(Time(20000:26000),dTheta2Denoised2(20000:26000),'LineWidth',2.5)
legend('Noisy','Denoised1','Denoised2')
xlabel("t (s)")
ylabel("d\theta_1")
grid on

dTheta1Denoised=dTheta1Denoised2;
dTheta2Denoised=dTheta2Denoised2;

%% In this subsection, we will discard the first/last few seconds of the measurement data
% Select the region that you would like to discard
Theta1Es=Theta1Raw(time_start:time_end);
dTheta1Es=dTheta1Denoised(time_start:time_end);
Theta2Es=Theta2Raw(time_start:time_end);
dTheta2Es=dTheta2Denoised(time_start:time_end);
Time_sample=Time(time_start:time_end)-Time(time_start);

% Plot the data you will chop into different sub-pices
figure(3)
plot(Time_sample,Theta1Es)
xlabel("t (s)")
ylabel("\theta_1")
title("\theta_1")
grid on
figure(4)
plot(Time_sample,dTheta1Es)
grid on
title("d\theta_1")
xlabel("t (s)")
ylabel("d\theta_1")

figure(5)
plot(Time_sample,Theta2Es)
xlabel("t (s)")
ylabel("\theta_2")
title("\theta_2")
grid on
figure(6)
plot(Time_sample,dTheta2Es)
grid on
title("d\theta_2")
xlabel("t (s)")
ylabel("d\theta_2")

%% In this subsection, we will chop the data into pices, and arrange them into an cell array
% Get the length of entire data you decided to use
Ndata=length(Theta1Es);

% Determine the length of each pices
Nlength_pice=floor(Ndata/Npices);

% Initialize an empty cell array  
Y_id=cell(Npices-Nvad,1);
Time_id=cell(Npices-Nvad,1);
Y_vad=cell(Nvad,1);
Time_vad=cell(Nvad,1);

% Set a counter to count the data index
j=1;
for i=1:Npices-Nvad
    Y_id{i}=[Theta1Es(j:j+Nlength_pice) Theta2Es(j:j+Nlength_pice) dTheta1Es(j:j+Nlength_pice) dTheta2Es(j:j+Nlength_pice)]';
    Time_id{i}=Time_sample(j:j+Nlength_pice);
    j=j+Nlength_pice+1;
end

for i=1:Nvad
    try
        Y_vad{i}=[Theta1Es(j:j+Nlength_pice) Theta2Es(j:j+Nlength_pice) dTheta1Es(j:j+Nlength_pice) dTheta2Es(j:j+Nlength_pice)]';
        Time_vad{i}=Time_sample(j:j+Nlength_pice);
        j=j+Nlength_pice+1;
    catch
        Y_vad{i}=[Theta1Es(j:end) Theta2Es(j:end) dTheta1Es(j:end) dTheta2Es(j:end)]';
        Time_vad{i}=Time_sample(j:end);
    end
end
    
%% Store the cell array used to identify the parameters
%Save the data for later use
%save('DoublePendulumDataForParameterEstimation.mat','Y_id','Y_vad','Time_id','Time_vad','dt')