function [rsq] = rsquared(dose_time, b, beta, s)
 for k=1:length(s)
    j=1;
    temp=[];
    q = size(dose_time,1);
for i=1:q
    if(s(k) == dose_time(i,3))
    temp(j,:) = [dose_time(i,:) b(i)];
    j=j+1;
    end
end
   rsq(k) = cross_err([temp(:,1) temp(:,2)],temp(:,4),beta);
 end
end
