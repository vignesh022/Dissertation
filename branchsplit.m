function [ ids, splits ] = branchsplit( A, method )
%BRANCHSPLIT Produces a series of split populations based on the attribute
%matrix A
%   Branchsplit returns an array of group IDs (1 or 2) for a prospective
%   division of each column of the attribute array A. For cases where
%   missing values occur in A, the group ID for the record will be assigned
%   a value of 1.5. The 'splits' variable is a vector defining the value of
%   the possible split points for each of the columns in A. There is one
%   element of splits for each column of A. The 'ids' array is the same
%   size as the attribute array A, with one column for each attribute, and
%   one row for each record. 'method' must be a string, either 'mean',
%   'median', or 'quartile'.

%   USAGE:
%   

%   EXAMPLE:
%      
%   
%   
%   
%   
%   
%   
%   
%   
%   

%   Author: Jeremy M. Gernand
%   e-mail: jmgernand@gmail.com
%   Release date: 02 MAY 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT VALIDATION, ERROR, AND WARNING MESSAGES

if ~ismatrix(A)
    error('BRANCHSPLIT:nonmatrixinputs',...
        'A must be a matrix')
end

if ~strcmp(method,'mean') && ~strcmp(method,'median')
    error('BRANCHSPLIT:invalidmethod',...
        'Method must be a string: "mean", or "median"')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULATE BRANCH SPLIT POINTS FOR EACH COLUMN

if strcmp(method,'mean')
    splits = nanmean(A);
elseif strcmp(method,'median')
    splits = nanmedian(A);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASSIGN SPLIT INDICIES BASED ON EACH SPLIT POINT

ids = nan(size(A));
[r,c] = size(A);

for i = 1:r
    for j = 1:c
        if A(i,j) < splits(j)
            ids(i,j) = 1;
        elseif A(i,j) >= splits(j)
            ids(i,j) = 2;
        elseif isnan(A(i,j))      
            ids(i,j) = 0;        
        end
    end
end

end

