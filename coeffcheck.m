%% load Dose (X) and Post_exposure time (T) and Response (Y) matrix

%A = Input matrix containing Dose and T data
%B = Response matrix with Y data

function [beta] = coeffcheck(A, Z)

model = @(b,x)(b(1)*(b(3) - ((b(3)-1)*exp(-b(2)*A(:,1)))) - b(4)*A(:,2));
x0 = [50 0.00000000001 5 50];
lb = [0 0 0 0];
ub = [1000 0.000001 50000 10000];
%beta0 = [1 0.000001 1 1];

beta = lsqcurvefit(model,x0,A,Z,lb,ub);
% 
