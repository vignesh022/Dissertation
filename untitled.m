function [x,fval,exitflag,output,population,score] = untitled(nvars)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'PopulationType', 'bitstring');
options = optimoptions(options,'MutationFcn', {  @mutationuniform [] });
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'PlotFcn', {  @gaplotbestf @gaplotbestindiv @gaplotexpectation });
[x,fval,exitflag,output,population,score] = ...
ga(@BitStringFitnessFcn,nvars,[],[],[],[],[],[],[],[],options);
