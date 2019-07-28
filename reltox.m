%% load Dose (X) and Post_exposure time (T) and Response (Y) matrix

%A = Input matrix containing Dose and T data
%B = Response matrix with Y data

function reltox(b)

delta_x = 9000/1000;
delta_y = 89/1000;
x=[0:9:9000];
y=[1:0.089:90];
z = zeros(1,1001);
z_sum=0;
for i=1:1001
z(1,i) = (b(1)*(b(3) - ((b(3)-1)*exp(-b(2)*x(i))))) - (b(4)*y(i));
z_sum = z_sum + z(1,i);
end

tox = z_sum*delta_x*delta_y

end 
