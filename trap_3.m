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
beta = zeros(length(k),5);
alen = length(a);

for i=1:(length(k))
    
s = unique(c);
l=0;

for j=1:alen
if(c(j) == s(i))
l = l+1;
end
end

m = zeros(l,2);
n = zeros(l,1);
z=1;
for k=1:alen
    if(c(k) == s(i))
    m(z,:) = a(k,:);
    n(z) = b(k);
    z=z+1;
    end
end
beta(i,1:3) = param3(m, n);
beta(i,5) = cross_err(m,n,beta(i,1:4));
    beta(i,4) = s(i);
end
%end



