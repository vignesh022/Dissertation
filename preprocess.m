function [ Aproc, Xproc, Yproc ] = preprocess( A, X, Y )
%PREPROCESS Eliminates pairs containing NaNs from the X and Y data
%   preprocess removes pairs of data points from X and Y and the associated
%   rows in attribute matrix A that contain undefined values (i.e. NaN).
%   The function returns the same array and vectors as inputted, but with
%   the NaN rows removed. NaNs in the matrix A are preserved. 

%   USAGE:
%   [Aproc,Xproc,Yproc] = preprocess(A,X,Y)

%   EXAMPLE:
%   a = [0.2 0.5;
%        0.1 0.9;
%        1.3 2.1;
%        NaN 0.0;
%        6.1 0.3;
%        1.7 NaN;
%        0.8 2.6]
%   x = [1; NaN; 9; 13; 17; NaN; 37];
%   y = [13; 19; 27; 42; NaN; 85; 113];
%
%   [a_proc,x_prox,y_proc] = preprocess(a,x,y);
%
%   a = 
%       0.2     0.5
%       1.3     2.1
%       NaN     0.0
%       0.8     2.6
%
%   x =
%       1
%       9
%       13
%       37
%
%   y = 
%       13
%       27
%       42
%       113

%   Author: Jeremy M. Gernand
%   e-mail: jmgernand@gmail.com
%   Release date: 01 MAY 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT VALIDATION, ERROR, AND WARNING MESSAGES

if nargin > 3
    error('PREPROCESS:toomanyargs',...
        'No more than three arguments, A, X and Y, allowed')
elseif nargin < 3
    error('PREPROCESS:toofewargs',...
        'Too few arguments; See "help preprocess" for details')
end

if ~isvector(X) || ~isvector(Y)
    error('PREPROCESS:nonvectorinput','X AND Y must be vectors')
end

if size(X,1) < size(X,2)
    error('PREPROCESS:columnvecX','X must be a column vector, transpose')
elseif size(Y,1) < size(Y,2)
    error('PREPROCESS:columnvecY','Y must be a column vector, transpose')
end

if size(X,1) ~= size(Y,1) || size(A,1) ~= size(X,1)
    error('PREPROCESS:unequalinputargs',...
        'A, X, and Y input arguments must have the same number of rows')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEAN DATA AND RETURN UPDATED ARRAYS

[r,c] = size(X);

for i = 1:r
    if isnan(Y(r-i+1)) || isnan(X(r-i+1))
        A(r-i+1,:) = [];
        X(r-i+1) = [];
        Y(r-i+1) = [];
    end
end

Aproc = A;
Xproc = X;
Yproc = Y;

end

