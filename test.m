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
%% 

n = 1;
for i=1:(length(q)-1)

[z, y] = nck_2(a,b,c, k, q(i,1));


%xlswrite('clustered.xlsx',z,i,'A1');
%xlswrite('clustered.xlsx',y,i,'D1');
%xlswrite('clustered.xlsx',v,i,'P1');
%xlswrite('clustered.xlsx',w,i,'S1');

end

