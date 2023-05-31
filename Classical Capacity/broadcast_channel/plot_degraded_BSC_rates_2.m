function plot_degraded_BSC_rates_2()

clear; 
load('degraded_BSC.mat');
savefile = 1;

Blue = [0, 0, 1];
Green = [0, 1, 0];
Red = [1,0.3,0];

% set(0,'Units','pixels');
scrsz = get(0,'ScreenSize');
figure('Position',[1 1 0.75*scrsz(3) scrsz(4)]);

for i = 2:length(cy)
    improvement_cy(i-1) = cy(i) - cy(i-1);
end

for i = 2:length(cz)
    improvement_cz(i-1) = cz(i) - cz(i-1);
end

for i = 2:length(cyz)
    improvement_cyz(i-1) = cyz(i) - cyz(i-1);
end


box on;
hold on;
plot(iter_z(2:end), improvement_cy/log(2), 'b.-', 'LineWidth', 3, 'MarkerSize', 10);
plot(iter_z(2:end), improvement_cz/log(2), 'r+-', 'LineWidth', 3, 'MarkerSize', 10);
plot(iter_z(2:end), improvement_cyz/log(2), 'g*-', 'LineWidth', 3, 'MarkerSize', 10);


%Axis label
xlabel('Number of iterations, $t$', 'FontSize', 30, 'Interpreter', 'latex');
ylabel('Change in estimate (bits)', 'FontSize', 30, 'Interpreter', 'latex');

%Axis style
set(gca, 'FontSize', 30, 'LineWidth', 3);

%v = get(gca,'Position');
xlim([0 50]);
%set(gca,'Position',[v(1)*0.8 v(2)*1.1 v(3) v(4)*0.9])
%set(gca,'XTick',[10^(-1) 10^0 10^1 10^2]);
%set(gca,'YTick',[0 0.002 0.004 0.006 0.008 0.010]);
%set(gca,'YTickLabel',{'0','0.002', '0.004', '0.006', '0.008', '0.010'})
%xlim([10^23 10^26]);
%set(gca,'XScale','log','TickLength',[0.02,0.025]);
%set(gca,'YScale','log');
%get(gca,'OuterPosition')
%set(gca,'OuterPosition',[0 0.1 0.9 0.9])

%axis([10^23 0.01 10^26 10]);
% xlim([1 15]); 
% ylim([-0.001 0.010]);

%set(gca,'XTick',[1 10 50 100]);
%set(gca,'YTick',0:2:10);

hl=legend('$C_{Y|X}$','$C_{Z|X}$', '$\tilde{C}_{YZ|X}$');
set(hl,'FontSize', 30, 'Location', 'Northeast', 'Interpreter', 'latex');

% %---------------------

%Save pdf
if savefile
    % Backup previous settings
    prePaperType = get(gcf,'PaperType');
    prePaperUnits = get(gcf,'PaperUnits');
    preUnits = get(gcf,'Units');
    prePaperPosition = get(gcf,'PaperPosition');
    prePaperSize = get(gcf,'PaperSize');
    
    % Make changing paper type possible
    set(gcf,'PaperType','<custom>');

    % Set units to all be the same
    set(gcf,'PaperUnits','inches');
    set(gcf,'Units','inches');
    
    % Set the page size and position to match the figure's dimensions
    paperPosition = get(gcf,'PaperPosition');
    position = get(gcf,'Position');
    set(gcf,'PaperPosition',[0,0,position(3:4)]);
    set(gcf,'PaperSize',position(3:4));

    % Save the pdf
    print -dpdf degraded_BSC_2;

    % Restore the previous settings
    set(gcf,'PaperType',prePaperType);
    set(gcf,'PaperUnits',prePaperUnits);
    set(gcf,'Units',preUnits);
    set(gcf,'PaperPosition',prePaperPosition);
    set(gcf,'PaperSize',prePaperSize);    
end
