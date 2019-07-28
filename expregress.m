function [ a, b, stat, aint, bint, linres, CVres ] = expregress( X, Y )
%EXPREGRESS produces an exponential regression function for the data in
%vectors X and Y
%   This function takes two input arguments in the column vectors X and Y
%   that include the independent and dependent variables respectively. The
%   function will return the coefficients 'a' and 'b' that provide the best
%   least squares regression fit for an equation of form:
%       Y = a*X^b
%   the values stat returns the goodness of fit statistics: r-squared,
%   q-squared, and the root mean squared error (rmse); aint and bint 
%   return the 95% confidence intervals for the values of a and b
%   respectively. 'res' is a vector of the residuals.

%   USAGE:
%   [a,b,stat,aint,bint,res] = expregress(X,Y)

%   EXAMPLE:
%   x = [1; 4; 9; 13; 17; 23; 37];
%   y = [13; 19; 27; 42; 63; 85; 113];
%   
%   [a,b,stat,aint,bint,res] = expregress(x,y)
%
%   a = 
%     9.8705
% 
%   b =
%     0.6249
% 
%   stat =
%     0.9069    r2
%     0.9507    q2
%     1.0484    rmse
% 
%   aint =
%     1.7109    2.8682
% 
%   bint =
%     0.3948    0.8551
% 
%   linres =
%     1.3171
%     0.8094
%     0.6929
%     0.8566
%     1.0865
%     1.2136
%     1.1987
%
%   CVres =
%     

%   Author: Jeremy M. Gernand
%   e-mail: jmgernand@gmail.com
%   Release date: 30 APR 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT VALIDATION, ERROR, AND WARNING MESSAGES

if nargin > 2
    error('EXPREGRESS:toomanyargs',...
        'No more than two arguments, X and Y, allowed')
elseif nargin < 2
    error('EXPREGRESS:toofewargs',...
        'Too few arguments; See "help expregress" for details')
end

if ~isvector(X) || ~isvector(Y)
    error('EXPREGRESS:nonvectorinput','X AND Y must be vectors')
end

if size(X,1) < size(X,2)
    error('EXPREGRESS:columnvecX','X must be a column vector, transpose')
elseif size(Y,1) < size(Y,2)
    error('EXPREGRESS:columnvecY','Y must be a column vector, transpose')
end

if numel(X)<3 || numel(Y)<3
    warning('EXPREGRESS:insufdata',...
        'There may be insufficient data for analysis')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRANSFORM INPUT DATA AND REGRESS

warning('off','all');
X(X==1) = 1.00001;                  %controls log(1) = 0 problem
Y(Y==1) = 1.00001;

tss = sum((Y-mean(Y)).^2);          %total sum of squares

logX = log(X);
logY = log(Y);
finalX = [ ones(size(logX)) logX ];

[c,cint,res,~,stats] = regress(logY,finalX);
stat(1) = stats(1);
linres = exp(res);
a = exp(c(1));
b = c(2);
aint = exp(cint(1,:));
bint = cint(2,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULATE Q-SQUARED (CROSS VALIDATION ERROR), 10-FOLD UNLESS FEWER THAN
%   10 ELEMENTS IN X

sser = 0;                                   %sum squared error
CVres = zeros(1,4);
CVresADD = zeros(1,4);
if size(X,1) > 10
    K = 10;
else
    K = size(X,1);
end
indices = crossvalind('Kfold',size(X,1),K);
for i = 1:K
    test = (indices == i); train = ~test;
    train = +train;
    test = +test;
    Ytrain = logY .* train;
    Xtrain = logX .* train;
    for j = 1:size(train,1)
        if train(size(train,1)-j+1)==0
            Ytrain(size(train,1)-j+1) = [];
            Xtrain(size(train,1)-j+1) = [];
        end
    end
    finalXtrain = [ ones(size(Xtrain)) Xtrain ];
    [CVc,~,~,~,~] = regress(Ytrain,finalXtrain);
    Xtest = logX .* test;
    Xtest = exp(Xtest);
    Ytest = logY .* test;
    Ytest = exp(Ytest);
    for k = 1:size(test,1)
        if test(size(test,1)-k+1)==0
            Ytest(size(test,1)-k+1) = [];
            Xtest(size(test,1)-k+1) = [];
        end
    end
    CVa = exp(CVc(1));
    Ypredict = (CVa*Xtest).^CVc(2);
    sser = sser + nansum((Ypredict - Ytest).^2);
    
    CVresADD(1:size(Xtest,1),1) = Xtest;
    CVresADD(1:size(Ytest,1),2) = Ytest;
    CVresADD(1:size(Ypredict,1),3) = Ypredict;
    CVresADD(1:size(Ypredict,1),4) = Ypredict - Ytest;
    CVres = [CVres; CVresADD];
end
if sser==0;
    sser = NaN;
end
q2 = 1 - (sser/tss);

stat(2) = q2;

CVres(1,:) = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULATE ROOT MEAN SQUARED ERROR (RMSE)

rmse = sqrt(sum(linres.^2)/size(linres,1));
stat(3) = rmse;
warning('on','all');
end

