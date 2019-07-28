function [z,x,y] = nck(a,b,temp)
z=[];
y=[];
x=[];
n=1;
for j=1:size(temp,1)
    m = size(temp,2);
[z(n,1),x(n,1)] = fit(a, b, temp(j,:));
y(n,1:m) = temp(j,1:m);
n=n+1;
%fprintf('fit func over\n')
end
end
