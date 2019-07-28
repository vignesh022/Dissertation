function [temp2, n, z] = reduce(dose_time, rsq, b, s)
[m n] = min(rsq);
ind = rsq == m;
z = s(ind);
 temp2=[];
    j=1;
for i=1:size(dose_time,1)
   
    if(z == dose_time(i,3))
        temp2(j,1) = [i];
        j=j+1;
    end
end
end
