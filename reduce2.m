function [temp2] = reduce2(a,b,temp)
temp2 = [];
for i=1:size(temp,1)
A = a;
B = b;
m = 1;
temp3=[];
for j=1:size(temp,2)
for n=1:size(a,1)
if(temp(i,j) == a(n,3))
  temp3(m,1) = n;
    m=m+1;
end
end
end

A(temp3,:) = [];
B(temp3) = [];
C = A(:,3);
K = unique(C);
temp2(i,:) = K';
end
end