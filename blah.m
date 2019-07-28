clc
clear all
warning off
A = xlsread('MO_comp.xlsx','PMN');
%load('Comprehensive.mat');
dose_time = [A(:,5) A(:,4) A(:,1)];
response = A(:,6);
a = [dose_time(:,1) dose_time(:,2) dose_time(:,3)];
b = response;
c=dose_time(:,3);
clc
%% 
k = unique(c);
s = length(k);
final1 = [];
final2 = [];
for i=1:s
fprintf('Status Check: Loop running through %d iteration \n',i);
temp1 = [];
temp2 = [];
l=1;
for j=1:length(b)
if(a(j,3) == k(i))
temp1(l,:) =  [a(j,1) a(j,2) a(j,3)];
temp2(l,1) = b(j);
l=l+1;
end
end
[final1, r, mdl] = beta_finder(temp1,temp2);
final2(i,:) = [k(i) final1 r];
%figure(i)
%scatter(temp1(:,1),temp2)
%plotSlice(mdl)
end


