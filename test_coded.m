clc
clear all
A = xlsread('CNT_complete.xlsx','Ldh');
%load('Comprehensive.mat');
dose_time = [A(:,6) A(:,5) A(:,1)];
response = A(:,7);
a = [dose_time(:,1) dose_time(:,2)];
b = response;
c = dose_time(:,3);
clc
%% 
k = unique(c);
z = zeros(length(k),1);
beta = zeros(length(k),6);

for i=1:(length(k))
    
s = unique(c);

beta(i,1:4) = nlincoeff(a, b);
beta(i,6) = cross_err(a,b,beta(i,1:4));

rsq = rsquared([a c], b, beta(i,1:4), s)
[temp2, n, z(i)] = reduce([a c], rsq, b, s);
beta(i,5) = z(i);
disp(z);
a(temp2,:) = [];
c(temp2,:) = [];
b(temp2) = [];
rsq(n) = [];


end




