%% load Dose (X) and Post_exposure time (T) and Response (Y) matrix

%A = Input matrix containing Dose and T data
%B = Response matrix with Y data

function [aicc,slope] = nlincoeff(A, B)

model = @(b,x) (b(1)*(b(3) - ((b(3)-1)*exp(-b(2)*x(:,1)))) - b(4)*x(:,2));
beta0 = [50 0.00000000001 5 50];
%beta0 = [1 0.000001 1 1];

mdl = fitnlm(A,B,model,beta0);
aicc = mdl.ModelCriterion.AIC;
slope = mdl.Coefficients{2,1};
beta = [mdl.Coefficients{1,1} mdl.Coefficients{2,1} mdl.Coefficients{3,1} mdl.Coefficients{4,1}];
% 
