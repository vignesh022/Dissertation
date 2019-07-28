function [m,r] = minaicc(z,y,v,w)
x = size(z,1);
total_aicc = zeros(x,1);
partition = zeros(x,1);
r = [];
for i=1:x
total_aicc(i,1)=(v(i) + z(i));
end
[m, n] = min(total_aicc);
r = horzcat(y(n,:),partition(n,:),w(n,:));
end