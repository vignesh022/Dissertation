function y = BitStringFitnessFcn(x)
warning off
A = xlsread('CNT_complete.xlsx','Ldh');
dose_time = [A(:,6) A(:,5) A(:,1)];
response = A(:,7);
a = [dose_time(:,1) dose_time(:,2) dose_time(:,3)];
b = response;
c=dose_time(:,3);
%%
k = unique(c);
temp5 = x';
n = 1;m=1;
for i=1:length(temp5)
if(temp5(i) == 1)
n=n+1;
end
if(temp5(i) == 0)
m=m+1;
end
end
s=zeros(n-1,1);
r=zeros(m-1,1);
n=1;m=1;
for i=1:length(temp5)
if(temp5(i) == 1)
s(n,1) = k(i);
n=n+1;
end
if(temp5(i) == 0)
r(m,1) = k(i);    
m=m+1;
end
end
%%
if(isempty(s)==1 || isempty(r)==1)
y = 1e+10;
else
[temp3, temp4] = splitting(a,b,s);
[temp6, temp7] = splitting(a,b,r);
%%
aic1 = beta_finder(temp3(:,1:2),temp4);
aic2 = beta_finder(temp6(:,1:2),temp7);
y = aic1 + aic2;
fprintf('Score: %f \n', x,y);
end
end
