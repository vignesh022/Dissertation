function [ diff ] = fit_simp( x,Xdata )
%toxicity exponential fitting function
%   xxx

A = x(1);
B = x(2);
C = x(3);
diff = A .* ( C - ( C - 1 ) .* exp( -B .* Xdata ) );

end

