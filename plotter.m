function plotter(b)

[x,y] = meshgrid(0:5:5000,0:0.6:60);

z = ((b(1)*(b(3) - ((b(3)-1)*exp(-b(2)*x)))) - (b(4)*y));

mesh(x,y,z)

% Defaults
width = 4;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 11;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize

figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
[c,h] = contourf(x,y,z);
clabel(c,h)
xlabel('Dose(\mu-g/kg)');
ylabel('Post Exposure Period (days)');
colorbar('EastOutside');

% Here we preserve the size of the image when we save it.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

% Save the file as PNG
print('improvedSample','-dpng','-r300');
end



