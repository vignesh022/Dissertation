function z_plot(X)
% Defaults for this blog post
width = 6;     % Width in inches
height = 5;    % Height in inches
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
hold on
box on
D = X;
hBar = bar(D,'LineWidth',0.4);
set(gca,'XTick',[1 1.5 2 2.5 3 3.5 4]); 
set(gca,'XTick',[1 2 3 4],'XTickLabel', {'Long and Thin' 'Short and Thick' 'Short and Thin' 'Long and Thick'})
ylim([-1 2]);
ylabel('Standardized Potency');
yjob = {'LDH' 'PMN' 'TP' 'MAC' 'TCC'};
legend(yjob,'Location','best','Orientation','horizontal','FontSize',7);

% Save the file as PNG
print('improved_CNT_Z_mod','-dpng','-r300');

end



