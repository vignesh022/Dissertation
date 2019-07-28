function [ Afilt, Xfilt, Yfilt ] = filtermatrix( A, X, Y, col, val )
%FILTERMATRIX filters out rows in A, X, and Y where the value of column
%'col' of matrix A is not equal to 'val'.
%   Detailed explanation goes here


% USAGE:
%   [Afilt,Xfilt,Yfilt] = filtermatrix(a,x,y,col,val)

% EXAMPLE:
%   a = 
%
%   x = 
%
%   y = 
%
%   [Afilt,Xfilt,Yfilt] = filtermatrix(a,x,y,2,1)
%
%   Afilt = 
%
%   Xfilt = 
%
%   Yfilt = 
%

%   Author: Jeremy M. Gernand
%   e-mail: jmgernand@gmail.com
%   Release date: 02 MAY 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT VALIDATION, ERROR, AND WARNING MESSAGES

[r,c] = size(A);

if nargin > 5
    error('FILTERMATRIX:toomanyargs',...
        'No more than three arguments, A, X, Y, col, and val allowed')
elseif nargin < 5
    error('FILTERMATRIX:toofewargs',...
        'Too few arguments; See "help preprocess" for details')
end

if ~isvector(X) || ~isvector(Y)
    error('FILTERMATRIX:nonvectorinput','X AND Y must be vectors')
end

if size(X,1) < size(X,2)
    error('FILTERMATRIX:columnvecX','X must be a column vector, transpose')
elseif size(Y,1) < size(Y,2)
    error('FILTERMATRIX:columnvecY','Y must be a column vector, transpose')
end

if size(X,1) ~= size(Y,1) || size(A,1) ~= size(X,1)
    error('FILTERMATRIX:unequalinputargs',...
        'A, X, and Y input arguments must have the same number of rows')
end

if ~isscalar(col) || ~isscalar(val)
    error('FILTERMATRIX:nonscalarinputs',...
        'col and val input arguments must be single scalar values')
end

if col > c
    error('FILTERMATRIX:notsufcolumns',...
        'Value of col is greater than # of columns in matrix A')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REMOVE ROWS FROM A, X, AND Y ACCORDING TO FILTER CRITERIA

for i = 1:r
    if A(r-i+1,col) ~= val
        A(r-i+1,:) = [];
        X(r-i+1) = [];
        Y(r-i+1) = [];
    end    
end

Afilt = A;
Xfilt = X;
Yfilt = Y;
end

