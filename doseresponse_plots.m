X1_clean = X_expd_totaldose;
X2_clean = X_expd_concXhours;
Y1_clean = Y_expd_TP;
Y2_clean = Y_expd_TP;
X0 = [1 1 1]';
y_new1 = [];
y_new2 = [];
X1_nonex = X_totaldose;
X2_nonex = X_concXhours;
Y1_nonex = Y_nonex_TP;
Y2_nonex = Y_nonex_TP;
SD1_nonex = Y_nonex_SD_TP;
SD2_nonex = Y_nonex_SD_TP;
ArrayInputs1 = NonExInputs;
ArrayInputs2 = NonExInputs;
[NEWnonExIds,NEWnonExSplits] = branchsplit(NonExInputs, 'mean');
NEWnonExIds1 = NEWnonExIds;
NEWnonExIds2 = NEWnonExIds;

for j = 1:size(X_totaldose,1);
    
    if isnan(X_totaldose(size(X_totaldose,1)-j+1,1)) || isnan(Y_nonex_TP(size(X_totaldose,1)-j+1,1));
        X1_nonex(size(X_totaldose,1)-j+1,:) = [];
        Y1_nonex(size(X_totaldose,1)-j+1,:) = [];
        SD1_nonex(size(X_totaldose,1)-j+1,:) = [];
        ArrayInputs1(size(X_totaldose,1)-j+1,:) = [];
        NEWnonExIds1(size(X_totaldose,1)-j+1,:) = [];
    end
    
    if isnan(X_concXhours(size(X_concXhours,1)-j+1,1)) || isnan(Y_nonex_TP(size(X_concXhours,1)-j+1,1));
        X2_nonex(size(X_concXhours,1)-j+1,:) = [];
        Y2_nonex(size(X_concXhours,1)-j+1,:) = [];
        SD2_nonex(size(X_concXhours,1)-j+1,:) = [];
        ArrayInputs2(size(X_concXhours,1)-j+1,:) = [];
        NEWnonExIds2(size(X_concXhours,1)-j+1,:) = [];
    end
    
end

% figure;
% hold on;
% %title('dose-response %change in TP vs. totaldose -NONEXPANDED');
% scatter(X_totaldose,Y_nonex_TP,'+');
% [xfit,resnorm2] = lsqcurvefit(@fit_simp,X0,X1_nonex,Y1_nonex);
% X1_plot = [min(X1_nonex):(max(X1_nonex)-min(X1_nonex))/1000:max(X1_nonex)];
% %y_new1 = xfit(1) + xfit(2).*exp(-xfit(3).*X1_plot);
% y_new1 = xfit(1) .* ( xfit(3) - (xfit(3) - 1) .* exp( -xfit(2) .* X1_plot));
% plot(X1_plot,y_new1,'-r','LineWidth',2);
% errorbar(X1_nonex,Y1_nonex,SD1_nonex,'+');
% axis([-100 9000 -0.1 18])
% SSerr = 0;
% SStot = 0;
% for q = 1:size(X1_nonex,1)
%     SSerr = ((xfit(1)*(xfit(3)-(xfit(3)-1)*exp(-xfit(2)*q)))-Y1_nonex(q))^2 + SSerr;
%     SStot = (Y1_nonex(q) - mean(Y1_nonex))^2 + SStot;
% end
% R2 = 1-(SSerr/SStot);
% str = ['R^2 = ' num2str(R2)];
% text(min(X1_nonex),max(Y1_nonex),str,'color','r');
% eq = 'y = A*[C-(C-1)*exp(-B*x)]';
% coef = ['A = ', num2str(xfit(1)),', B = ', num2str(xfit(2)),', C = ', num2str(xfit(3))];
% text(mean(X1_nonex),min(Y1_nonex),coef,'color','r');
% xlabel('Total Dose of CNTs (ug/kg)');
% ylabel('Change in BAL Total Protein (fold of control)');
% hold off;
% 
% %CREATE AND PLOT 2 CHILD NODES
% 
% for z = 1:size(NEWnonExIds1,2)
%     if ~isempty(NEWnonExIds1(NEWnonExIds1(:,z)==1)) && ~isempty(NEWnonExIds1(NEWnonExIds1(:,z)==2))
%         [Aprime1,Xprime1,Yprime1] = filtermatrix(NEWnonExIds1,X1_nonex,Y1_nonex,z,1);
%         [Aprime2,Xprime2,Yprime2] = filtermatrix(NEWnonExIds1,X1_nonex,Y1_nonex,z,2);
%         
%         [xfit1_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,Xprime1,Yprime1);
%         [xfit1_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,Xprime2,Yprime2);
%         
%         SStot1 = sum((Yprime1 - mean(Yprime1)).^2);
%         SStot2 = sum((Yprime2 - mean(Yprime2)).^2);
%         
%         testchild1(z,1) = xfit1_child1(1);
%         testchild1(z,2) = xfit1_child1(2);
%         testchild1(z,3) = xfit1_child1(3);
%         testchild1(z,4) = resnorm1;
%         testchild1(z,5) = xfit1_child2(1);
%         testchild1(z,6) = xfit1_child2(2);
%         testchild1(z,7) = xfit1_child2(3);
%         testchild1(z,8) = resnorm2;
%         testchild1(z,10) = (1-(resnorm1/SStot1)) + (1-(resnorm2/SStot2));
%         
%     end
% end
% z = 2;
% if ~isempty(NEWnonExIds1(NEWnonExIds1(:,z)==1)) && ~isempty(NEWnonExIds1(NEWnonExIds1(:,z)==2))
%     [Aprime1,Xprime1,Yprime1] = filtermatrix(NEWnonExIds1,X1_nonex,Y1_nonex,z,1);
%     [Aprime2,Xprime2,Yprime2] = filtermatrix(NEWnonExIds1,X1_nonex,Y1_nonex,z,2);
%     [Aprime1,Xprime1,SDprime1] = filtermatrix(NEWnonExIds1,X1_nonex,SD1_nonex,z,1);
%     [Aprime2,Xprime2,SDprime2] = filtermatrix(NEWnonExIds1,X1_nonex,SD1_nonex,z,2);
%     [xfit1_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,Xprime1,Yprime1);
%     [xfit1_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,Xprime2,Yprime2);
%     SStot1 = sum((Yprime1 - mean(Yprime1)).^2);
%     SStot2 = sum((Yprime2 - mean(Yprime2)).^2);
% end
% 
% figure;
% hold on;
% scatter(Xprime1,Yprime1,'+');
% X1_primeplot1 = [min(Xprime1):(max(Xprime1)-min(Xprime1))/1000:max(Xprime1)];
% yprime_new1 = xfit1_child1(1) .* ( xfit1_child1(3) - (xfit1_child1(3) - 1) .* exp( -xfit1_child1(2) .* X1_primeplot1));
% plot(X1_primeplot1,yprime_new1,'-r','LineWidth',2);
% errorbar(Xprime1,Yprime1,SDprime1,'+');
% xlabel('Total Dose of CNTs (ug/kg)');
% ylabel('Change in BAL Total Protein (fold of control)');
% str = ['R^2 = ' num2str(1-(resnorm1/SStot1))];
% text(min(Xprime1),max(Yprime1),str,'color','r');
% hold off;
% 
% figure;
% hold on;
% scatter(Xprime2,Yprime2,'+');
% X1_primeplot2 = [min(Xprime2):(max(Xprime2)-min(Xprime2))/1000:max(Xprime2)];
% yprime_new2 = xfit1_child2(1) .* ( xfit1_child2(3) - (xfit1_child2(3) - 1) .* exp( -xfit1_child2(2) .* X1_primeplot2));
% plot(X1_primeplot2,yprime_new2,'-r','LineWidth',2);
% errorbar(Xprime2,Yprime2,SDprime2,'+');
% xlabel('Total Dose of CNTs (ug/kg)');
% ylabel('Change in BAL Total Protein (fold of control)');
% str = ['R^2 = ' num2str(1-(resnorm2/SStot2))];
% text(min(Xprime2),max(Yprime2),str,'color','r');
% hold off;

%% TREED EXPONENTIAL REGRESSION USING CONCENTRATION X HOURS
% figure;
% hold on;
% %title('dose-response % change in TP vs. conc.Xhours -NONEXPANDED');
% scatter(X_concXhours,Y_nonex_TP,'+');
% [xfit2,resnorm4] = lsqcurvefit(@fit_simp,X0,X2_nonex,Y2_nonex);
% X2_plot = [min(X2_nonex):(max(X2_nonex)-min(X2_nonex))/1000:max(X2_nonex)];
% %y_new2 = xfit2(1) + xfit2(2).*exp(-xfit2(3).*X2_plot);
% y_new2 = xfit2(1) .* ( xfit2(3) - (xfit2(3) - 1) .* exp( -xfit2(2) .* X2_plot));
% plot(X2_plot,y_new2,'-r','LineWidth',2)
% errorbar(X2_nonex,Y2_nonex,SD2_nonex,'+');
% axis([-50 2500 -0.1 8])
% SSerr = 0;
% SStot = 0;
% for q = 1:size(X2_nonex,1)
%     SSerr = ((xfit2(1)*(xfit2(3)-(xfit2(3)-1)*exp(-xfit2(2)*q)))-Y2_nonex(q))^2 + SSerr;
%     SStot = (Y1_nonex(q) - mean(Y1_nonex))^2 + SStot;
% end
% R2 = 1-(SSerr/SStot);
% str2 = ['R^2 = ' num2str(R2)];
% text(min(X2_nonex),max(Y2_nonex),str2,'color','r');
% eq = 'y = A*[C-(C-1)*exp(-B*x)]';
% coef2 = ['A = ', num2str(xfit2(1)),', B = ', num2str(xfit2(2)),', C = ', num2str(xfit2(3))];
% text(mean(X2_nonex),min(Y2_nonex),coef2,'color','r');
% text(mean(X2_nonex),mean(Y2_nonex),eq,'color','r');
% xlabel('Exposure Concentration (mg/m^3) X Exposure Hours');
% ylabel('Change in BAL Total Protein (fold of control)');
% hold off;
% 
% % PLOT 2 CHILD NODES
% 
% for z = 1:size(NEWnonExIds2,2)
%     if ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==1)) && ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==2))
%         [Aprime1,X2prime1,Y2prime1] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,1);
%         [Aprime2,X2prime2,Y2prime2] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,2);
%         
%         [xfit2_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,X2prime1,Y2prime1);
%         [xfit2_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,X2prime2,Y2prime2);
%         
%         SStot1 = sum((Y2prime1 - mean(Y2prime1)).^2);
%         SStot2 = sum((Y2prime2 - mean(Y2prime2)).^2);
%         
%         testchild2(z,1) = xfit2_child1(1);
%         testchild2(z,2) = xfit2_child1(2);
%         testchild2(z,3) = xfit2_child1(3);
%         testchild2(z,4) = resnorm1;
%         testchild2(z,5) = xfit2_child2(1);
%         testchild2(z,6) = xfit2_child2(2);
%         testchild2(z,7) = xfit2_child2(3);
%         testchild2(z,8) = resnorm2;
%         testchild2(z,10) = (1-(resnorm1/SStot1)) + (1-(resnorm2/SStot2));
%         
%     end
% end
% z = 2;
% if ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==1)) && ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==2))
%     [Aprime1,Xprime1,Yprime1] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,1);
%     [Aprime2,Xprime2,Yprime2] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,2);
%     [Aprime1,Xprime1,SDprime1] = filtermatrix(NEWnonExIds2,X2_nonex,SD2_nonex,z,1);
%     [Aprime2,Xprime2,SDprime2] = filtermatrix(NEWnonExIds2,X2_nonex,SD2_nonex,z,2);
%     [xfit2_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,Xprime1,Yprime1);
%     [xfit2_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,Xprime2,Yprime2);
%     SStot1 = sum((Yprime1 - mean(Yprime1)).^2);
%     SStot2 = sum((Yprime2 - mean(Yprime2)).^2);
% end
% 
% figure;
% hold on;
% scatter(Xprime1,Yprime1,'+');
% X2_primeplot1 = [min(Xprime1):(max(Xprime1)-min(Xprime1))/1000:max(Xprime1)];
% yprime_new2 = xfit2_child1(1) .* ( xfit2_child1(3) - (xfit2_child1(3) - 1) .* exp( -xfit2_child1(2) .* X2_primeplot1));
% plot(X2_primeplot1,yprime_new2,'-r','LineWidth',2);
% errorbar(Xprime1,Yprime1,SDprime1,'+');
% xlabel('Exposure Concentration (mg/m^3) X Exposure Hours');
% ylabel('Change in BAL Total Protein (fold of control)');
% str = ['R^2 = ' num2str(1-(resnorm1/SStot1))];
% text(min(Xprime1),max(Yprime1),str,'color','r');
% coef2 = ['A = ', num2str(xfit2_child1(1)),', B = ', num2str(xfit2_child1(2)),', C = ', num2str(xfit2_child1(3))];
% text(mean(X2_nonex),min(Y2_nonex),coef2,'color','r');
% text(mean(X2_nonex),mean(Y2_nonex),eq,'color','r');
% hold off;
% 
% % PLOT TWO CHILD NODES OF CHILD ONE
% NEWnonExIds2 = Aprime1;
% X2_nonex = Xprime1;
% Y2_nonex = Yprime1;
% [NEWnonExIds,NEWnonExSplits] = branchsplit(NonExInputs, 'mean');
% 
% for z = 1:size(NEWnonExIds2,2)
%     if ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==1)) && ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==2))
%         [Aprime1,X2prime1,Y2prime1] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,1);
%         [Aprime2,X2prime2,Y2prime2] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,2);
%         
%         [xfit2_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,X2prime1,Y2prime1);
%         [xfit2_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,X2prime2,Y2prime2);
%         
%         SStot1 = sum((Y2prime1 - mean(Y2prime1)).^2);
%         SStot2 = sum((Y2prime2 - mean(Y2prime2)).^2);
%         
%         testchild4(z,1) = xfit2_child1(1);
%         testchild4(z,2) = xfit2_child1(2);
%         testchild4(z,3) = xfit2_child1(3);
%         testchild4(z,4) = resnorm1;
%         testchild4(z,5) = xfit2_child2(1);
%         testchild4(z,6) = xfit2_child2(2);
%         testchild4(z,7) = xfit2_child2(3);
%         testchild4(z,8) = resnorm2;
%         testchild4(z,10) = (1-(resnorm1/SStot1)) + (1-(resnorm2/SStot2));
%         
%     end
% end
% SD2_nonex = SDprime1;
% z = 7;
% if ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==1)) && ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==2))
%     [Aprime1,Xprime1,Yprime1] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,1);
%     [Aprime2,Xprime2,Yprime2] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,2);
%     [Aprime1,Xprime1,SDprime1] = filtermatrix(NEWnonExIds2,X2_nonex,SD2_nonex,z,1);
%     [Aprime2,Xprime2,SDprime2] = filtermatrix(NEWnonExIds2,X2_nonex,SD2_nonex,z,2);
%     [xfit2_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,Xprime1,Yprime1);
%     [xfit2_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,Xprime2,Yprime2);
%     SStot1 = sum((Yprime1 - mean(Yprime1)).^2);
%     SStot2 = sum((Yprime2 - mean(Yprime2)).^2);
% end
% 
% figure;
% hold on;
% scatter(Xprime1,Yprime1,'+');
% X2_primeplot1 = [min(Xprime1):(max(Xprime1)-min(Xprime1))/1000:max(Xprime1)];
% yprime_new2 = xfit2_child1(1) .* ( xfit2_child1(3) - (xfit2_child1(3) - 1) .* exp( -xfit2_child1(2) .* X2_primeplot1));
% plot(X2_primeplot1,yprime_new2,'-r','LineWidth',2);
% errorbar(Xprime1,Yprime1,SDprime1,'+');
% xlabel('Exposure Concentration (mg/m^3) X Exposure Hours');
% ylabel('Change in BAL Total Protein (fold of control)');
% str = ['R^2 = ' num2str(1-(resnorm1/SStot1))];
% text(min(Xprime1),max(Yprime1),str,'color','r');
% coef2 = ['A = ', num2str(xfit2_child1(1)),', B = ', num2str(xfit2_child1(2)),', C = ', num2str(xfit2_child1(3))];
% text(mean(Xprime1),min(Yprime1),coef2,'color','r');
% text(mean(Xprime1),mean(Yprime1),eq,'color','r');
% hold off;
% 
% figure;
% hold on;
% scatter(Xprime2,Yprime2,'+');
% X2_primeplot2 = [min(Xprime2):(max(Xprime2)-min(Xprime2))/1000:max(Xprime2)];
% yprime_new2 = xfit2_child2(1) .* ( xfit2_child2(3) - (xfit2_child2(3) - 1) .* exp( -xfit2_child2(2) .* X2_primeplot2));
% plot(X1_primeplot2,yprime_new2,'-r','LineWidth',2);
% errorbar(Xprime2,Yprime2,SDprime2,'+');
% xlabel('Exposure Concentration (mg/m^3) X Exposure Hours');
% ylabel('Change in BAL Total Protein (fold of control)');
% str = ['R^2 = ' num2str(1-(resnorm2/SStot2))];
% text(min(Xprime2),max(Yprime2),str,'color','r');
% coef2 = ['A = ', num2str(xfit2_child2(1)),', B = ', num2str(xfit2_child2(2)),', C = ', num2str(xfit2_child2(3))];
% text(mean(Xprime2),min(Yprime2),coef2,'color','r');
% text(mean(Xprime2),mean(Yprime2),eq,'color','r');
% hold off;
% 
% NEWnonExIds2 = Aprime1;
% X2_nonex = Xprime1;
% Y2_nonex = Yprime1;
% [NEWnonExIds,NEWnonExSplits] = branchsplit(NonExInputs, 'mean');
% 
% for z = 1:size(NEWnonExIds2,2)
%     if ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==1)) && ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==2))
%         [Aprime1,X2prime1,Y2prime1] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,1);
%         [Aprime2,X2prime2,Y2prime2] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,2);
%         
%         [xfit2_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,X2prime1,Y2prime1);
%         [xfit2_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,X2prime2,Y2prime2);
%         
%         SStot1 = sum((Y2prime1 - mean(Y2prime1)).^2);
%         SStot2 = sum((Y2prime2 - mean(Y2prime2)).^2);
%         
%         testchild6(z,1) = xfit2_child1(1);
%         testchild6(z,2) = xfit2_child1(2);
%         testchild6(z,3) = xfit2_child1(3);
%         testchild6(z,4) = resnorm1;
%         testchild6(z,5) = xfit2_child2(1);
%         testchild6(z,6) = xfit2_child2(2);
%         testchild6(z,7) = xfit2_child2(3);
%         testchild6(z,8) = resnorm2;
%         testchild6(z,10) = (1-(resnorm1/SStot1)) + (1-(resnorm2/SStot2));
%         
%     end
% end
% SD2_nonex = SDprime1;
% z = 10;
% if ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==1)) && ~isempty(NEWnonExIds2(NEWnonExIds2(:,z)==2))
%     [Aprime1,Xprime1,Yprime1] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,1);
%     [Aprime2,Xprime2,Yprime2] = filtermatrix(NEWnonExIds2,X2_nonex,Y2_nonex,z,2);
%     [Aprime1,Xprime1,SDprime1] = filtermatrix(NEWnonExIds2,X2_nonex,SD2_nonex,z,1);
%     [Aprime2,Xprime2,SDprime2] = filtermatrix(NEWnonExIds2,X2_nonex,SD2_nonex,z,2);
%     [xfit2_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,Xprime1,Yprime1);
%     [xfit2_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,Xprime2,Yprime2);
%     SStot1 = sum((Yprime1 - mean(Yprime1)).^2);
%     SStot2 = sum((Yprime2 - mean(Yprime2)).^2);
% end

figure;
hold on;
Xprime1 = [0 25 150 650 2400];
Yprime1 = [0 1.4 1.6 1.85 2.9];
SDprime1 = [0 0.2 0.1 0.4 0.3];
scatter(Xprime1,Yprime1,'+');
[xfit2_child1,resnorm1] = lsqcurvefit(@fit_simp,X0,Xprime1,Yprime1);
X2_primeplot1 = [min(Xprime1):(max(Xprime1)-min(Xprime1))/1000:max(Xprime1)];
yprime_new2 = xfit2_child1(1) .* ( xfit2_child1(3) - (xfit2_child1(3) - 1) .* exp( -xfit2_child1(2) .* X2_primeplot1));
plot(X2_primeplot1,yprime_new2,'-r','LineWidth',2);
errorbar(Xprime1,Yprime1,SDprime1,'+');
xlabel('Exposure Concentration (mg/m^3) X Exposure Hours');
ylabel('Change in BAL Total Protein (fold of control)');
str = ['R^2 = ' num2str(1-(resnorm1/SStot1))];
text(min(Xprime1),max(Yprime1),str,'color','r');
coef2 = ['A = ', num2str(xfit2_child1(1)),', B = ', num2str(xfit2_child1(2)),', C = ', num2str(xfit2_child1(3))];
text(mean(Xprime1),min(Yprime1),coef2,'color','r');
text(mean(Xprime1),mean(Yprime1),eq,'color','r');
hold off;

figure;
hold on;
Xprime2 = [0 25 150 650 2400];
Yprime2 = [0 1.5 2.2 2.8 3.9];
SDprime2 = [0 0.3 0.5 0.3 0.5];
scatter(Xprime2,Yprime2,'+');
[xfit2_child2,resnorm2] = lsqcurvefit(@fit_simp,X0,Xprime2,Yprime2);
X2_primeplot2 = [min(Xprime2):(max(Xprime2)-min(Xprime2))/1000:max(Xprime2)];
yprime_new2 = xfit2_child2(1) .* ( xfit2_child2(3) - (xfit2_child2(3) - 1) .* exp( -xfit2_child2(2) .* X2_primeplot2));
plot(X1_primeplot2,yprime_new2,'-r','LineWidth',2);
errorbar(Xprime2,Yprime2,SDprime2,'+');
xlabel('Exposure Concentration (mg/m^3) X Exposure Hours');
ylabel('Change in BAL Total Protein (fold of control)');
str = ['R^2 = ' num2str(1-(resnorm2/SStot2))];
text(min(Xprime2),max(Yprime2),str,'color','r');
coef2 = ['A = ', num2str(xfit2_child2(1)),', B = ', num2str(xfit2_child2(2)),', C = ', num2str(xfit2_child2(3))];
text(mean(Xprime2),min(Yprime2),coef2,'color','r');
text(mean(Xprime2),mean(Yprime2),eq,'color','r');
hold off;

%% ORIGINAL CHILD 2

% figure;
% hold on;
% scatter(Xprime2,Yprime2,'+');
% X2_primeplot2 = [min(Xprime2):(max(Xprime2)-min(Xprime2))/1000:max(Xprime2)];
% yprime_new2 = xfit2_child2(1) .* ( xfit2_child2(3) - (xfit2_child2(3) - 1) .* exp( -xfit2_child2(2) .* X2_primeplot2));
% plot(X1_primeplot2,yprime_new2,'-r','LineWidth',2);
% errorbar(Xprime2,Yprime2,SDprime2,'+');
% xlabel('Exposure Concentration (mg/m^3) X Exposure Hours');
% ylabel('Change in BAL Total Protein (fold of control)');
% str = ['R^2 = ' num2str(1-(resnorm2/SStot2))];
% text(min(Xprime2),max(Yprime2),str,'color','r');
% coef2 = ['A = ', num2str(xfit2_child2(1)),', B = ', num2str(xfit2_child2(2)),', C = ', num2str(xfit2_child2(3))];
% text(mean(Xprime2),min(Yprime2),coef2,'color','r');
% text(mean(Xprime2),mean(Yprime2),eq,'color','r');
% hold off;


% %% REGRESSION TREE MODELS WITH CONSTANT LEAF NODES
% X1array = [ArrayInputs1 X1_nonex];
% X2array = [ArrayInputs2 X2_nonex];
% t1 = classregtree(X1array,Y1_nonex,'method','regression');
% t2 = classregtree(X2array,Y2_nonex,'method','regression');
% [~,~,~,bestlvl1] = test(t1,'crossvalidate',X1array,Y1_nonex);
% [~,~,~,bestlvl2] = test(t2,'crossvalidate',X2array,Y2_nonex);
% tmin1 = prune(t1,'level',bestlvl1);
% tmin2 = prune(t2,'level',bestlvl2);
%% DRAW FORMATTED TREES AND CALCULATE R-SQUARED VALUES
%view(tmin1)
%view(tmin2)






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for i = 1:size(X_expd_totaldose,1);
%     
%     if isnan(X_expd_totaldose(size(X_expd_totaldose,1)-i+1,1)) || isnan(Y_expd_TP(size(X_expd_totaldose,1)-i+1,1));
%         X1_clean(size(X_expd_totaldose,1)-i+1,:) = [];
%         Y1_clean(size(X_expd_totaldose,1)-i+1,:) = [];
%     end
%     
%     if isnan(X_expd_concXhours(size(X_expd_concXhours,1)-i+1,1)) || isnan(Y_expd_TP(size(X_expd_totaldose,1)-i+1,1));
%         X2_clean(size(X_expd_totaldose,1)-i+1,:) = [];
%         Y2_clean(size(X_expd_totaldose,1)-i+1,:) = [];
%     end
%     
% end

% figure(1);
% hold on;
% title('dose-response %change in TP vs. totaldose');
% scatter(X_expd_totaldose,Y_expd_TP,'+');
% %     f1 = fit(X1_clean,Y1_clean,'exp1');
% %     Xfit = [min(X_expd_totaldose):(max(X_expd_totaldose)-min(X_expd_totaldose))/100:max(X_expd_totaldose)];
% %     Yfit = [min(Y_expd_TP):(max(Y_expd_TP)-min(Y_expd_TP))/100:max(Y_expd_TP)];
% %     plot(f1,Xfit,Yfit,'-');
%     [xfit,resnorm1] = lsqcurvefit(@fit_simp,X0,X1_clean,Y1_clean);
%     X1_plot = [min(X1_clean):(max(X1_clean)-min(X1_clean))/1000:max(X1_clean)];
%     %y_new1 = xfit(1) + xfit(2).*exp(-xfit(3).*X1_plot);
%     y_new1 = xfit(1) .* ( xfit(3) - (xfit(3) - 1) .* exp( -xfit(2) .* X1_plot));
%     plot(X1_plot,y_new1,'-r')
% hold off;

% figure(3);
% hold on;
% title('dose-response % change in TP vs. conc.Xhours');
% scatter(X_expd_concXhours,Y_expd_TP,'+');
% %     f2 = fit(X2_clean,Y2_clean,'exp1');
% %     Xfit2 = [min(X_expd_concXhours):(max(X_expd_concXhours)-min(X_expd_concXhours))/100:max(X_expd_concXhours)];
% %     Yfit = [min(Y_expd_TP):(max(Y_expd_TP)-min(Y_expd_TP))/100:max(Y_expd_TP)];
% %     plot(f2,Xfit2,Yfit,'-');
%     [xfit2,resnorm3] = lsqcurvefit(@fit_simp,X0,X2_clean,Y2_clean);
%     X2_plot = [min(X2_clean):(max(X2_clean)-min(X2_clean))/1000:max(X2_clean)];
%     %y_new2 = xfit2(1) + xfit2(2).*exp(-xfit2(3).*X2_plot);
%     y_new2 = xfit2(1) .* ( xfit2(3) - (xfit2(3) - 1) .* exp( -xfit2(2) .* X2_plot));
%     plot(X2_plot,y_new2,'-r')
% hold off;

% figure(3);
% hold on;
% title('dose-response % change in TP vs. conc.Xhours -NONEXPANDED');
% scatter([0 0.1 0.5 1.7 6],[0.05 5.1 12.2 17.8 26.9],'s');
% %     f2 = fit(X2_clean,Y2_clean,'exp1');
% %     Xfit2 = [min(X_expd_concXhours):(max(X_expd_concXhours)-min(X_expd_concXhours))/100:max(X_expd_concXhours)];
% %     Yfit = [min(Y_expd_TP):(max(Y_expd_TP)-min(Y_expd_TP))/100:max(Y_expd_TP)];
% %     plot(f2,Xfit2,Yfit,'-');
% [xfit3,resnorm4] = lsqcurvefit(@fit_simp,X0,[0 0.1 0.5 1.7 6],[0.05 5.1 12.2 17.8 26.9]);
% X3_plot = [0:(6)/1000:6];
% %y_new2 = xfit2(1) + xfit2(2).*exp(-xfit2(3).*X2_plot);
% y_new3 = xfit3(1) .* ( xfit3(3) - (xfit3(3) - 1) .* exp( -xfit3(2) .* X3_plot));
% plot(X3_plot,y_new3,'-r','LineWidth',2);
% errorbar([0 0.1 0.5 1.7 6],[0.05 5.1 12.2 17.8 26.9],[0.02 4.9 2.4 1.2 6.9],'s');
% axis([-0.1 6.5 0 35])
% hold off;
