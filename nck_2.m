clc
clear all
warning off
%A = xlsread('CNT_complete.xlsx','Ldh');
load('Comprehensive.mat');
dose_time = [A(:,5) A(:,4) A(:,1)];
response = A(:,8);
a = [dose_time(:,1) dose_time(:,2) dose_time(:,3)];
b = response;
c=dose_time(:,3);
clc
%% 
k = unique(c);
s = length(k);
q = zeros(s,2);
for i=1:s
q(i,:) = [i s-i];
end
z = [];
x = length(q);
for i=1:x-1
temp = nchoosek(k,q(i,1));
temp2 = reduce2(a,b,temp);
end
z = [temp temp2];