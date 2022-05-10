function l2normError=ObjectiveFuntion_SinglePendulumParameterEstimation(EstimationParameters,dt,Y_id)
% Description:
% This is the objective function that we use to find out the parameters of
% the Pendulum System. In this file, we will formulate an optimization
% problem to identify the parameters of the single pendulum system.
%
% Inputs:
% EstimationParameters: Parameters of the single pendulum. The sequence of the optimization
% parameter follows:  EstimationParameters=[a1 m1 I1 k1 g], where a1 (m) is the position of
% the mass center of single pendulum arm, m1 (kg) is the mass of signle
% pendulum arm, I1 (kg*m^2)is the moment of inertia of single pendulum, k1
% is the unitless friction coefficient, g1 (m/s^2) is the gravitational
% acceleration of earth. All units are: m-kg standard. If the "g" variable
% is not provided, then the default of 9.8083 will be used.
%
% dt: This is the simulation time-step used by the ODE45 solver, make sure
% this is the same as your measurement data sampling time-step
%
% Y_id: An m x 1 cell array, where m different trajectory of the pendulum is
% provided. For each tracjectory,it should be a n x 2 matrix, where the
% first column is the angular position of the pendulum arm and the second
% column is the angular velocity of the pendulum arm. The first data point
% will be used as initial condition of the ODE simulation along with the
% optimization parameters. For each simulation, an estimated trajectory
% using the optimization parameter is simulated, then the l2 norm of the
% simulated trajectory and actual measurement is calculated.
%
% Output:
% l2normError: An scalar that calculated the difference between the acutal
% measurement and simulated system begavior.
%
% Author: KK
% Date: 03/Oct/2021
%

%% Determine the number of optimization parameter, if it is 4, then set the g=9.8083 as defaults
if length(EstimationParameters)==4
    g=9.8083;
end

%% Run a for loop and simulate the system based on the given ceel array data
Y_es=cell(length(Y_id),1);

for i=1:length(Y_id)
    % First determine the simulation time
    tspan=0:dt:length(Y_id{1})*dt-dt;
    
    % Next, determine the initial condition used for simulation, the first
    % data will be used as initial condition
    y0=Y_id{i}(:,1);
    
    % Now, run the simulation and simulate the system
    if length(EstimationParameters)==5
        [~,y_es]=ode15s(@(t,y)SinglePendulumODE(t,y,EstimationParameters(1),EstimationParameters(2),...
            EstimationParameters(3),EstimationParameters(4),EstimationParameters(5)),tspan,y0);
    else
        [~,y_es]=ode15s(@(t,y)SinglePendulumODE(t,y,EstimationParameters(1),EstimationParameters(2)...
            ,EstimationParameters(3),EstimationParameters(4),g),tspan,y0);
    end
    
    % Now store the simulated data into an array
    Y_es{i}=y_es';
    
    % Now calculate the difference (l2 norm) of the simualted data and measrued data
    if i==1
        l2normError=norm(Y_id{i}-Y_es{i})^2;
    else
        l2normError=l2normError+norm(Y_id{i}-Y_es{i})^2;
    end
end

%% Plot the result of first few simulation
figure(1)
clf
for i=1:4
    subplot(2,2,i)
    plot(0:dt:length(Y_id{i})*dt-dt,Y_es{i}(1,:),'LineWidth',2.5)
    hold on
    plot(0:dt:length(Y_id{i})*dt-dt,Y_id{i}(1,:),'LineWidth',2.5,'LineStyle','--')
    legend("Simulated","Measured")
    xlabel("t (s)")
    ylabel("\theta")
end
