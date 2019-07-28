%% load Dose (X) and Post_exposure time (T) and Response (Y) matrix

%A = Input matrix containing Dose and T data
%B = Response matrix with Y data

function reltox_2(b)

Z = @(X,Y) (b(1)*(b(3) - ((b(3)-1)*exp(-b(2)*X)))) - (b(4)*Y);
tox = quad2d(Z,0,9000,1,90)

end 
