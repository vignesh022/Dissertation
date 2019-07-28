function [temp1, temp2] = splitting(a,b,s)
z=1;
for i=1:length(s)
for j=1:length(b)
if(a(j,3) == s(i,1));    
z=z+1;
end
end
end
temp1=zeros(z-1,size(a,2));
temp2=zeros(z-1,1);

t=1;
for i=1:length(s)
for j=1:length(b)
if(a(j,3) == s(i,1));    
temp1(t,:) = a(j,:);
temp2(t,:) = b(j);
t=t+1;
end
end
end
end