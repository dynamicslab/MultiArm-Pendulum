%% Description:
% This file is used to process the triple pendulum experimental data. It
% can help users remove the noise in velocity measurement, and generate a
% cell array that chops the single measurmeent data into pices. This cell
% array can then be used to identify the parameters of the pendulum setup.
%
% Author: KK
% Date: 11/May/2022

%% Clear all the data
clc;clear all;close all;

%% Let user define the file name of the pendulum measurement data
filename='TriplePendulumData_Raw.mat';

%% Let user determine how many pices they would like to chop the measurements
Npices=26;
% Determine how many of the pices you would like to use as validation data
Nvad=4;

%% Load the file for processing
load(filename);

% Extract the timming information
Time=data{1}.Values.Time;
% Determine the time-step used during the data logging
dt=Time(2)-Time(1);

%% Let user define where the actual experiments starts
time_start=ceil(20/dt);
time_end=ceil(60/dt);

%% Extract the measurement data time information and pendulum arm angular position and velocity information
% Prepare the data from time series to time vector
Theta1Raw=data{1}.Values.data(:);
Theta2Raw=data{2}.Values.data(:);
Theta3Raw=data{3}.Values.data(:);
%
dTheta1Raw=data{5}.Values.data(:);
dTheta2Raw=data{6}.Values.data(:);
dTheta3Raw=data{4}.Values.data(:);


%% Now, denoise the volocity data (THe angular data is farily clean, and there's no need to filter it)
% First get rid of the unexpected peak
dTheta1Denoised1=medfilt1(dTheta1Raw,3);
dTheta2Denoised1=medfilt1(dTheta2Raw,3);
dTheta3Denoised1=medfilt1(dTheta3Raw,3);
% Next, use "wden" to denoise the previous one more time 
wname = 'db3';
lev = 4;
dTheta1Denoised2= wden(dTheta1Denoised1,'sqtwolog','s','mln',lev,wname);
dTheta2Denoised2= wden(dTheta2Denoised1,'sqtwolog','s','mln',lev,wname);
dTheta3Denoised2= wden(dTheta3Denoised1,'sqtwolog','s','mln',lev,wname);
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

figure(3)
plot(Time(20000:26000),dTheta3Raw(20000:26000),'LineWidth',2.5)
hold on 
plot(Time(20000:26000),dTheta3Denoised1(20000:26000),'LineWidth',2.5)
plot(Time(20000:26000),dTheta3Denoised2(20000:26000),'LineWidth',2.5)
legend('Noisy','Denoised1','Denoised2')
xlabel("t (s)")
ylabel("d\theta_3")
grid on

%
dTheta1Denoised=dTheta1Denoised2;
dTheta2Denoised=dTheta2Denoised2;
dTheta3Denoised=dTheta3Denoised2;

%% In this subsection, we will discard the first/last few seconds of the measurement data
% Select the region that you would like to discard
Theta1Es=Theta1Raw(time_start:time_end);
Theta2Es=Theta2Raw(time_start:time_end);
Theta3Es=Theta3Raw(time_start:time_end);
%
dTheta1Es=dTheta1Denoised(time_start:time_end);
dTheta2Es=dTheta2Denoised(time_start:time_end);
dTheta3Es=dTheta3Denoised(time_start:time_end);
%
Time_sample=Time(time_start:time_end)-Time(time_start);

% Plot the data you will chop into different sub-pices
figure(4)
plot(Time_sample,Theta1Es)
xlabel("t (s)")
ylabel("\theta_1")
title("\theta_1")
grid on
figure(5)
plot(Time_sample,dTheta1Es)
grid on
title("d\theta_1")
xlabel("t (s)")
ylabel("d\theta_1")

figure(6)
plot(Time_sample,Theta2Es)
xlabel("t (s)")
ylabel("\theta_2")
title("\theta_2")
grid on
figure(7)
plot(Time_sample,dTheta2Es)
grid on
title("d\theta_2")
xlabel("t (s)")
ylabel("d\theta_2")

figure(8)
plot(Time_sample,Theta3Es)
xlabel("t (s)")
ylabel("\theta_3")
title("\theta_3")
grid on
figure(9)
plot(Time_sample,dTheta3Es)
grid on
title("d\theta_3")
xlabel("t (s)")
ylabel("d\theta_3")

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
    Y_id{i}=[Theta1Es(j:j+Nlength_pice) Theta2Es(j:j+Nlength_pice) Theta3Es(j:j+Nlength_pice) dTheta1Es(j:j+Nlength_pice) dTheta2Es(j:j+Nlength_pice) dTheta3Es(j:j+Nlength_pice)]';
    Time_id{i}=Time_sample(j:j+Nlength_pice);
    j=j+Nlength_pice+1;
end

for i=1:Nvad
    try
        Y_vad{i}=[Theta1Es(j:j+Nlength_pice) Theta2Es(j:j+Nlength_pice) Theta3Es(j:j+Nlength_pice) dTheta1Es(j:j+Nlength_pice) dTheta2Es(j:j+Nlength_pice) dTheta3Es(j:j+Nlength_pice)]';
        Time_vad{i}=Time_sample(j:j+Nlength_pice);
        j=j+Nlength_pice+1;
    catch
        Y_vad{i}=[Theta1Es(j:end) Theta2Es(j:end) Theta3Es(j:end) dTheta1Es(j:end) dTheta2Es(j:end) dTheta3Es(j:end)]';
        Time_vad{i}=Time_sample(j:end);
    end
end
    
%% Store the cell array used to identify the parameters
%Save the data for later use
save('TriplePendulumDataForParameterEstimation.mat','Y_id','Y_vad','Time_id','Time_vad','dt')