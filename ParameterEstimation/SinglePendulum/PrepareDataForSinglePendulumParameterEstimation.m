%% Description:
% This file is used to process the single pendulum experimental data. It
% can help users remove the noise in velocity measurement, and generate a
% cell array that chops the signle measurmeent data into pieces. This cell
% array can then be used to identify the parameters of the pendulum data.
%
% Author: KK
% Date: 03/Oct/2021

%% Clear all the data
clc;clear all;close all;

%% Let user define the file name of the pendulum measurement data
filename='SinglePendulumArm_RawData_1.mat';

%% Let user determine how many pices they would like to chop the measurements
Npices=6;
% Determine how many of the pices you would like to use as validation data
Nvad=2;

%% Let user define where the actual experiments starts
time_start=15000;
time_end=70000;

%% Load the file for processing
load(filename);

%% Extract the measurement data time information and pendulum arm angular position and velocity information
% Prepare the data from time series to time vector
ThetaRaw=data{1}.Values.data;
dThetaRaw=data{2}.Values.data;
% Extract the timming information
Time=data{1}.Values.Time;
% Determine the time-step used during the data logging
dt=Time(2)-Time(1);

%% Now, denoise the volocity data (THe angular data is farily clean, and there's no need to filter it)
% First get rid of the unexpected peak
dThetaDenoised1=medfilt1(dThetaRaw,10);
% Next, use "wden" to denoise the previous one more data 
wname = 'db3';
lev = 4;
dThetaDenoised2= wden(dThetaDenoised1,'sqtwolog','s','mln',lev,wname);
%
close all
figure(1)
plot(Time(20000:26000),dThetaRaw(20000:26000),'LineWidth',2.5)
hold on 
plot(Time(20000:26000),dThetaDenoised1(20000:26000),'LineWidth',2.5)
plot(Time(20000:26000),dThetaDenoised2(20000:26000),'LineWidth',2.5)
legend('Noisy','Denoised1','Denoised2')
xlabel("t (s)")
ylabel("d\theta_1")
grid on

dThetaDenoised=dThetaDenoised2;

%% In this subsection, we will discard the first/last few seconds of the measurement data
% Select the region that you would like to discard
ThetaEs=ThetaRaw(time_start:time_end);
dThetaEs=dThetaDenoised(time_start:time_end);
Time_sample=Time(time_start:time_end)-Time(time_start);

% Plot the data you will chop into different sub-pices
figure(2)
plot(Time_sample,ThetaEs)
xlabel("t (s)")
ylabel("\theta_1")
title("\theta_1")
grid on
figure(3)
plot(Time_sample,dThetaEs)
grid on
title("d\theta_1")
xlabel("t (s)")
ylabel("d\theta_1")

%% In this subsection, we will chop the data into pices, and arrange them into an cell array
% Get the length of entire data you decided to use
Ndata=length(ThetaEs);

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
    Y_id{i}=[ThetaEs(j:j+Nlength_pice) dThetaEs(j:j+Nlength_pice)]';
    Time_id{i}=Time_sample(j:j+Nlength_pice);
    j=j+Nlength_pice+1;
end

for i=1:Nvad
    try
        Y_vad{i}=[ThetaEs(j:j+Nlength_pice) dThetaEs(j:j+Nlength_pice)]';
        Time_vad{i}=Time_sample(j:j+Nlength_pice);
        j=j+Nlength_pice+1;
    catch
        Y_vad{i}=[ThetaEs(j:end) dThetaEs(j:end)]';
        Time_vad{i}=Time_sample(j:end);
    end
end
    
%% Store the cell array used to identify the 
%Save the data for later use
save('SinglePendulumDataForParameterEstimation.mat','Y_id','Y_vad','Time_id','Time_vad','dt')