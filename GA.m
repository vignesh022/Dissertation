function [x,fval,exitflag,output] = GA(nvars,MaxGenerations_Data)

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'PopulationType', 'bitstring');
options = optimoptions(options,'MaxGenerations', MaxGenerations_Data);
options = optimoptions(options,'MutationFcn', {  @mutationuniform [] });
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'PlotFcn', {  @gaplotbestf @gaplotbestindiv });
[x,fval,exitflag,output] = ...
ga(@BitStringFitnessFcn,nvars,[],[],[],[],[],[],[],[],options);
