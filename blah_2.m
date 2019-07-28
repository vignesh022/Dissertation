clc
clear all
warning off
A = xlsread('CNT_complete.xlsx','TC');
%load('Comprehensive.mat');
dose_time = [A(:,6) A(:,5) A(:,1)];
response = A(:,7);
%% 
a = [dose_time(:,1) dose_time(:,2) dose_time(:,3)];
b = response;
c=dose_time(:,3);
clc
k = unique(c);
s = length(k);
if(mod(s,2)==0)
q = zeros(s/2,2);
for i=1:s/2
q(i,:) = [i s-i];
end
else
q = zeros((s-1)/2,2);
for i=1:(s-1)/2
q(i,:) = [i s-i];
end
end
x = size(q,1);
min_aicc = [];
min_aicc2 = [];
temp3 = [];
final1 = [];
final2 = [];
%%
for i=1:x
fprintf('Status Check: Loop running through %d iteration \n',i);
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
[r, c] = size(final1);
final1 = sortrows(final1,c);
final2 = sortrows(final2,c);

final1 = final1(1,:);
final2 = final2(1,:);

%xlswrite('tcc_cls.xlsx',final1,'Sheet1','A11');
%xlswrite('slope_tcc.xlsx',final2,'Sheet1','A11');
