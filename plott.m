function plott(X)
% Defaults
width = 6.5;     % Width in inches
height = 5;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 11;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize

figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
box on
D = X;
hBar = bar(D,'LineWidth',0.4);
set(gca,'XTick',[1 1.5 2 2.5 3 3.5 4]); 
set(gca,'XTick',[1 2 3 4],'XTickLabel', {'A' 'B' 'C' 'D'})
ylabel('Log-values of Potency');
yjob = {'LDH' 'PMN' 'TP' 'MAC' 'TCC'};
legend(yjob,'Location','north','FontSize',7);

% Here we preserve the size of the image when we save it.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

% Save the file as PNG
print('improved_CNT_LogBar_new','-dpng','-r300');

end



