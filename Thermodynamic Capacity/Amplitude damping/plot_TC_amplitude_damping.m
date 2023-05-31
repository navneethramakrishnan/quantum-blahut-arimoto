function plot_TC_amplitude_damping()

clear; 
load('data_TC_amplitude_damping.mat');
savefile = 1;

Blue = [0, 0, 1];
Green = [0, 1, 0];
Red = [1,0.3,0];

% set(0,'Units','pixels');
scrsz = get(0,'ScreenSize');
figure('Position',[1 1 0.75*scrsz(3) scrsz(4)]);

box on;
hold on;
plot(acc_iter, acc_capacity/log(2), 'b.-', 'LineWidth', 3, 'MarkerSize', 40);
plot(iter, capacity/log(2), 'rx-', 'LineWidth', 3, 'MarkerSize', 20);

%Axis label
xlabel('Number of iterations, $t$', 'FontSize', 40, 'Interpreter', 'latex');
ylabel('Thermodynamic capacity estimate (bits), $T_{\Gamma}^{(t)}$', 'FontSize', 40, 'Interpreter', 'latex');

%Axis style
set(gca, 'FontSize', 30, 'LineWidth', 3);

%v = get(gca,'Position');
xlim([0 15]);
%set(gca,'Position',[v(1)*0.8 v(2)*1.1 v(3) v(4)*0.9])
%set(gca,'XTick',[10^(-1) 10^0 10^1 10^2]);
%set(gca,'YTick',[10^(-3) 10^(-2) 10^-1 10^0]);
%set(gca,'XTickLabel',{'0.065','0.68', '1', '1.5'})
%xlim([10^23 10^26]);
%set(gca,'XScale','log','TickLength',[0.02,0.025]);
%set(gca,'YScale','log');
%get(gca,'OuterPosition')
%set(gca,'OuterPosition',[0 0.1 0.9 0.9])

%axis([10^23 0.01 10^26 10]);
%xlim([0 50]); 
% ylim([0.23 0.245]);

%set(gca,'XTick',[1 10 50 100]);
%set(gca,'YTick',0:2:10);

hl=legend('Adaptive accelerated Blahut-Arimoto', 'Blahut-Arimoto');
set(hl,'FontSize',30,'Location','Southeast','Interpreter','latex');

%annotation('textbox',[0.40 0.57 0.3 0.15], 'String',{'x10^{5}'},'FontSize',15,'EdgeColor','none');
%annotation('textbox',[0.61 0.40 0.3 0.15], 'String',{'x10^{4}'},'FontSize',15,'EdgeColor','none');

%---------------------
% %Inset
%axes('Position',[.24 .63 .23 .23]);
%box on;
%hold on;
% 

%plot(insetB, MR_inset_h*10^4, 'Color', Green, 'LineWidth', 3);
%plot(insetB, MR_inset_ih, 'r', 'LineWidth', 3);
%plot(Ando_inset(:,1), Ando_inset(:,2), 'm.' , 'MarkerSize', 20);
%plot(Ando_inset(:,1), Ando_inset(:,2), 'm' , 'LineWidth', 3);


% %Plot line
% plot(x, y, 'k--', 'LineWidth', 2);
% 
% for j = 1:2, plot(nstar, invmu{j}, style{j}, 'LineWidth', 2); end
% 
% text(30, 1.55,  '$d = 0.3$ nm', 'Color', 'blue', 'FontSize', 16, 'Interpreter', 'latex');
% text(30.3, 2.22, '$d = 1$ nm'  , 'Color', 'red' , 'FontSize', 16, 'Interpreter', 'latex');
% 
% Axis label
%xlabel('$B(T)$', 'FontSize', 20, 'Interpreter', 'latex');
%ylabel('MR', 'FontSize', 20, 'Interpreter', 'latex');
%ylabel('$n^{*}/n_{i}$', 'FontSize', 20, 'Interpreter', 'latex');

%axis([10^23 0.01 10^26 10]);
%xlim([10^23.1 3*10^26]); 
%xlim([0 0.1]);


% %Axis style
%set(gca, 'FontSize', 15, 'LineWidth', 3);
%set(gca,'XTick',[0 0.05 0.1]);
%set(gca,'XTickLabel',{'0','0.05','0.1'})
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
    print -dpdf TC_amplitude_damping;

    % Restore the previous settings
    set(gcf,'PaperType',prePaperType);
    set(gcf,'PaperUnits',prePaperUnits);
    set(gcf,'Units',preUnits);
    set(gcf,'PaperPosition',prePaperPosition);
    set(gcf,'PaperSize',prePaperSize);    
end
