function aic_plot(ldh,pmn,tcc,tp,mac)
% Defaults for this blog post
width = 4.5;     % Width in inches
height = 3.5;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 8;      % Fontsize
lw = 2;      % LineWidth
msz = 8;       % MarkerSize

% The new defaults will not take effect if there are any open figures. To
% use them, we close all figures, and then repeat the first example.
close all;

% The properties we've been using in the figures
set(0,'defaultLineLineWidth',lw);   % set the default line width to lw
set(0,'defaultLineMarkerSize',msz); % set the default line marker size to msz

% Set the default Size for display
defpos = get(0,'defaultFigurePosition');
set(0,'defaultFigurePosition', [defpos(1) defpos(2) width*100, height*100]);
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

% Set the defaults for saving/printing to a file
set(0,'defaultFigureInvertHardcopy','on'); % This is the default anyway
set(0,'defaultFigurePaperUnits','inches'); % This is the default anyway
defsize = get(gcf, 'PaperSize');
left = (defsize(1)- width)/2;
bottom = (defsize(2)- height)/2;
defsize = [left, bottom, width, height];
set(0, 'defaultFigurePaperPosition', defsize);

figure(1); clf;
hold on;
box on;
xlim([0 11]);
ylim([0 950]);
%yticks([100 200 300 400 500 600 700 800 900 1000]);
plot(ldh(:,1),ldh(:,5),'-o');
plot(pmn(:,1),pmn(:,5),'-+');
plot(tcc(:,1),tcc(:,5),'-s');
plot(mac(:,1),mac(:,5),'-*');
plot(tp(:,1),tp(:,5),'-x');
set(gca, 'YAxisLocation','right');
xlabel('No. of Clusters');
ylabel('Penalized AIC');
yjob = {'LDH' 'PMN' 'TCC' 'MAC' 'TP'};
legend(yjob,'Location','northeast','FontSize',7);

% Save the file as PNG
print('improved_CNT_Aic','-dpng','-r300');

end



