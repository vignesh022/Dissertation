outputcol = [4]; % 1~PMN, 2~MAC, 3~LDH, 4~TP
xvalue = [1];

inputX = OEL_X(:,xvalue);
inputY = OEL_Y(:,outputcol);
inputA = [ OELInputs StudyIDexpanded ];

nodes(1,1) = 1;
disp('          preprocessing...')
[procA,procX,procY] = preprocess(inputA,inputX,inputY);
disp('          filtering...')
[filtA,filtX,filtY] = filtermatrix(procA,procX,procY,11,1);

for z = 1:max(filtA(:,12))
    disp(['                regressing study # ',num2str(z)])
        [Aprime1,Xprime1,Yprime1] = filtermatrix(filtA,filtX,filtY,12,z);
        if isempty(Xprime1) || isempty(Yprime1)
            disp('                             ...skipped')
        else
        [studytestnode(z,1),studytestnode(z,2),studytestnode(z,3:5),~,~,~,~] = ...
            expregress(Xprime1,Yprime1);
        end
end