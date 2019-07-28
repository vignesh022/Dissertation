function [rsquared] = cross_err(a, b, coeff)

m = mean(b);

sst = 0;
ssr = 0;

n = size(b,1);
z = zeros(n,1);
for i = 1:n
   z(i,1) = (coeff(1)*(coeff(3) - ((coeff(3)-1)*exp(-coeff(2)*a(i,1))))) - (coeff(4)*a(i,2));
end

    for j=1:n
        ssr = ssr + (b(j,1) - z(j,1))^2;
        sst = sst + (b(j,1) - m)^2;
    end

    rsquared = 1 - (ssr/sst);
end
