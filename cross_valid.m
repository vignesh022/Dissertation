clc
clear all
warning off
A = xlsread('CNT_complete.xlsx','Ldh');
%load('Comprehensive.mat');
dose_time = [A(:,6) A(:,5) A(:,1)];
response = A(:,7);
clc
%%
k = unique(dose_time(:,3));
snew = length(k);
j=1;
for i=1:length(response)
if(dose_time(i,3) == k(1))
a(j,:) = [dose_time(i,1) dose_time(i,2) dose_time(i,3)];    
b(j,1) = response(i);
c(j,1) = dose_time(i,3);
j=j+1;
end
end
%% 
k(2)=[];
snew = length(k);
q = zeros(snew,2);
for i=1:snew
q(i,:) = [i snew-i];
end

x = length(q);
min_aicc = [];
min_aicc2 = [];
temp3 = [];
final1 = [];
final2 = [];
for i=1:x-1
temp = nchoosek(k,q(i,1));
[z,x,y] = nck(a,b,temp);
temp2 = reduce2(a,b,temp);
[v,p,w] = nck(a,b,temp2);
temp3 = [z,y,v,w,(z+v)];
temp4 = [x,y,p,w,(z+v)];

if (i==1)
final1 = temp3;
final2 = temp4;
else
final1 = vertcat(final1,temp3);
final2 = vertcat(final2,temp4);
end            
end

xlswrite('cvalid_ldh.xlsx',final1,'Sheet1','A1');
xlswrite('slopes_cvalid_ldh.xlsx',final2,'Sheet1','A1');

