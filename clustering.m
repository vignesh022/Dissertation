clc
clear all
A = xlsread('Ldh_levels.xlsx','Level3_2');
%load('Comprehensive.mat');
dose_time = [A(:,6) A(:,5) A(:,1)];
response = A(:,7);
a = [dose_time(:,1) dose_time(:,2) dose_time(:,3)];
b = response;
c = dose_time(:,3);
clc
%% 
k = unique(c);
s = length(k);
z=[];
y=[];
n=1;
for i=1:s
temp = nchoosek(k,i);
for j=1:size(temp,1)
    m = size(temp,2);
[z(n,1) z(n,2)] = fit(a, b, temp(j,:));
y(n,1:m) = temp(j,1:m);
n=n+1;
%fprintf('fit func over\n')
end
end
xlswrite('clustered.xlsx',z,'Sheet1','A1');
xlswrite('clustered.xlsx',y,'Sheet1','C1');