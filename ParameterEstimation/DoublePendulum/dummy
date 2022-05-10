# This folder contains files for estimating the parameters of double pendulum.

The files contained in this folders are:
- DoublePendulumData_Raw.mat: The raw data collected from the double pendulum free-swing experiments. The sampling rate used is dt=0.001s and the pendulum cart is mounted when recording the data. This file is used by "PrepareDataForDoublePendulumParameterEstimation.m" to generated processed double pendulum data for parameter estimation.
- PrepareDataForDoublePendulumParameterEstimation.m: This file is used to chop the raw double pendulum data into pieces. Those pieces of data are stored into a cell array for parameter estimation and validation. The training data and validation data are stored in the "DoublePendulumDataForParameterEstimation.mat" file.
- DoublePendulumDataForParameterEstimation.mat: The data used for parameter estimation and validation.
- ObjectiveFuntion_DoublePendulumParameterEstimation.m: The objective function for the parameter estimation.
- OptimizeParameter_DoublePendulum.mlx: The Matlab script that solves the parameter estimation problem.
- DoublePendulumODE_Mounted.m: The ODE files for simulating the mounted double pendulum. This file is used in the objection file.
- EstimatedParameters_DoublePendulum.mat: The estimated values of double pendulum arm's parameters.
- DoublePendulumSymbolicCalculation.m: The symbolic calculation file needed for deriving the ODEs of double pendulum.

