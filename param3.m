%% load Dose (X) and Post_exposure time (T) and Response (Y) matrix

%A = Input matrix containing Dose and T data
%B = Response matrix with Y data

function [beta] = param3(A, B)

model = @(b,x) (1 + (b(2)*exp(-b(1)*x(:,1)))) - (b(3)*x(:,2));
beta0 = [0.000000001 5 50];

mdl = fitnlm(A,B,model,beta0);

beta = [mdl.Coefficients{1,1} mdl.Coefficients{2,1} mdl.Coefficients{3,1}];
% 
