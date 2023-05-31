function plot_TC_amplitude_damping_2()

clear; 
load('data_TC_amplitude_damping.mat');
savefile = 1;

Blue = [0, 0, 1];
Green = [0, 1, 0];
Red = [1,0.3,0];

% set(0,'Units','pixels');
scrsz = get(0,'ScreenSize');
figure('Position',[1 1 0.75*scrsz(3) scrsz(4)]);

for i = 2:length(capacity)
    improvement_capacity(i-1) = capacity(i) - capacity(i-1);
end

for i = 2:length(acc_capacity)
    improvement_acc_capacity(i-1) = acc_capacity(i) - acc_capacity(i-1);
end

box on;
hold on;
plot(acc_iter(2:end), improvement_acc_capacity/log(2), 'b.-', 'LineWidth', 3, 'MarkerSize', 40);
plot(iter(2:end), improvement_capacity/log(2), 'rx-', 'LineWidth', 3, 'MarkerSize', 20);
%plot(iter(1:3*length(acc_iter)), max(rel_capacity)*ones(3*length(acc_iter)), 'k-', 'LineWidth', 1);


%Axis label
xlabel('Number of iterations, $t$', 'FontSize', 40, 'Interpreter', 'latex');
ylabel('Change in estimate (bits), $\Delta T_{\Gamma}^{(t)}$', 'FontSize', 40, 'Interpreter', 'latex');
%Axis style
set(gca, 'FontSize', 30, 'LineWidth', 3);

%v = get(gca,'Position');
%xlim([0.1 40]);
%set(gca,'Position',[v(1)*0.8 v(2)*1.1 v(3) v(4)*0.9])
%set(gca,'XTick',[10^(-1) 10^0 10^1 10^2]);
set(gca,'YTick',[0 0.005 0.010 0.015 0.02 0.025]);
set(gca,'YTickLabel',{'0','0.005', '0.010', '0.015', '0.0020', '0.025'})
%xlim([10^23 10^26]);
%set(gca,'XScale','log','TickLength',[0.02,0.025]);
%set(gca,'YScale','log');
%get(gca,'OuterPosition')
%set(gca,'OuterPosition',[0 0.1 0.9 0.9])

%axis([10^23 0.01 10^26 10]);
 xlim([0 15]); 
 ylim([0 0.025]);

%set(gca,'XTick',[1 10 50 100]);
%set(gca,'YTick',0:2:10);

hl=legend('Adaptive accelerated Blahut-Arimoto','Blahut-Arimoto');
set(hl,'FontSize',30,'Location','Northeast','Interpreter','latex');

%annotation('textbox',[0.40 0.57 0.3 0.15], 'String',{'x10^{5}'},'FontSize',15,'EdgeColor','none');
%annotation('textbox',[0.61 0.40 0.3 0.15], 'String',{'x10^{4}'},'FontSize',15,'EdgeColor','none');

%---------------------
% %Inset
% axes('Position',[.63 .43 .23 .23]);
% box on;
% hold on;
% 
% 
% plot(acc_iter(4:5), improvement_acc_capacity(3:4)/log(2), 'b.-', 'LineWidth', 1, 'MarkerSize', 25);
% 
% %Axis style
% set(gca, 'FontSize', 30, 'LineWidth', 1);

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
    print -dpdf TC_amplitude_damping_2;

    % Restore the previous settings
    set(gcf,'PaperType',prePaperType);
    set(gcf,'PaperUnits',prePaperUnits);
    set(gcf,'Units',preUnits);
    set(gcf,'PaperPosition',prePaperPosition);
    set(gcf,'PaperSize',prePaperSize);    
end
