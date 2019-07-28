% this script calls functions to run an exponential regression tree 
%   analysis

tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN LOOPS
for outputcol = [4]                 
                                    % 1~PMN, 2~MAC, 3~LDH, 4~TP
for xvalue = [1]                    
                                    % 1~totaldose, 2~concXhours
                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE INPUT PARAMETERS

inputX = OEL_X(:,xvalue);
inputY = OEL_Y(:,outputcol);
inputA = OELInputs;

% SIMULATED TEST PARAMETERS
% inputX = Xsim;
% inputY = Ysim;
% inputA = Asim;

nodes(1,1) = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROCESS AND FILTER DATA
disp('          preprocessing...')
[procA,procX,procY] = preprocess(inputA,inputX,inputY);

disp('          filtering...')
[filtA,filtX,filtY] = filtermatrix(procA,procX,procY,11,1);
% filtX = procX;
% filtY = procY;

disp('          regressing...')
[nodes(1,2),nodes(1,3),nodes(1,4:6),~,~,~,~] = expregress(filtX,filtY);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IDENTIFY POSSIBLE BRANCHES

disp('             creating prospective branch splits...')
[ ids, splits ] = branchsplit( filtA, 'median' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EVALUATE POSSIBLE BRANCHES

disp('             evaluating prospective branches...')
for z = 1:size(filtA,2)
    disp(['                ',num2str(z)])
    if ~isempty(ids(ids(:,z)==1)) && ~isempty(ids(ids(:,z)==2))
        [Aprime1,Xprime1,Yprime1] = filtermatrix(ids,filtX,filtY,z,1);
        [Aprime2,Xprime2,Yprime2] = filtermatrix(ids,filtX,filtY,z,2);
        [testnode(z,1),testnode(z,2),testnode(z,3:5),~,~,~,~] = ...
            expregress(Xprime1,Yprime1);
        [testnode(z,7),testnode(z,8),testnode(z,9:11),~,~,~,~] = ...
            expregress(Xprime2,Yprime2);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SELECT BEST BRANCH




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end %end of xvalue loop
end %end of outputcol loop
toc