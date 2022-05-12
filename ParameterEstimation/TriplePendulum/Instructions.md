# This folder contains files for the parameter estimation of the triple pendulum.

This folder contains following files:
- TriplePendulumData_Raw.mat: Experimental data gather from the triple pendulum free-swing moton, with sampling rate of dt=0.001. This file will be processed by "PrepareDataForTriplePendulumParameterEstimation.m" to get rid of the noise in the derivative measurements. Then it will be trimed into pieces and stored into a cell array.
- PrepareDataForTriplePendulumParameterEstimation.m: This file is used to process the "TriplePendulumData_Raw.mat" file so that it can be used for parameter estimation.
- TriplePendulumSymbolicCalculation.m: This file is usd to calculate the ODE of the triple pendulum via symbolic toolbox of Matlab.
- TriplePendulumODE_Mounted.m: This file is the ODE file of the triple pendulum. It can used used to simulate the behavior of the triple pendulum.
- TriplePendulumSimWithX0.m: This file is used to simulate the ODE of the triple pendulum given some user define initial condition of triple pendulum.
- ObjectiveFuntion_TriplePendulumParameterEstimation.m: This file is used to define the objective function of the parameter estimation problem of the triple pendulum.
- OptimizeParameter_TriplePendulum.mlx: This file is used to solve the prameter estimation problem of the triple pndulum. It will also save the estimated parameters of the triple pendulum.
-  EstimatedParameters_TriplePendulum.mat: This file stores the estimated parameters of the triple pendulum. For their meaning, please check the "OptimizeParameter_TriplePendulum.mlx" file.
