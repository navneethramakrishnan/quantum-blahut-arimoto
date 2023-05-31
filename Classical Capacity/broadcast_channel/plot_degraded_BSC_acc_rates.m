function plot_degraded_BSC_acc_rates()

clear; 
load('degraded_BSC.mat');
savefile = 1;

Blue = [0.3, 0.3, 1];
Green = [0.3, 0.5, 0.3];
Red = [1,0.3,0.3];
Grey = [0.7, 0.7, 0.7];


% set(0,'Units','pixels');
scrsz = get(0,'ScreenSize');
figure('Position',[1 1 0.75*scrsz(3) scrsz(4)]);

box on;
hold on;
plot(acc_iter_y, acc_cy, '.-', 'Color', Blue, 'LineWidth', 3, 'MarkerSize', 10);
plot(acc_iter_z, acc_cz, '+-', 'Color', Red, 'LineWidth', 3, 'MarkerSize', 10);
plot(acc_iter_yz, acc_cyz, '*-', 'Color', Green, 'LineWidth', 3, 'MarkerSize', 10);
%plot(acc_iter_z, acc_cy + acc_cz, 'x-', 'Color', Grey, 'LineWidth', 3, 'MarkerSize', 20);


%Axis label
xlabel('Number of iterations', 'FontSize', 40, 'Interpreter', 'latex');
ylabel('Cost estimate (bits)', 'FontSize', 40, 'Interpreter', 'latex');

%Axis style
set(gca, 'FontSize', 30, 'LineWidth', 3);

%v = get(gca,'Position');
%xlim([0 50]);
ylim([0 0.35]);
%set(gca,'Position',[v(1)*0.8 v(2)*1.1 v(3) v(4)*0.9])
%set(gca,'XTick',[10^(-1) 10^0 10^1 10^2]);
%set(gca,'YTick',[1.32508 1.32512 1.32516 1.32520 1.32524]);
%set(gca,'YTickLabel',{'0.3265','0.3270', '0.3275', '0.3280'})
%xlim([10^23 10^26]);
%set(gca,'XScale','log','TickLength',[0.02,0.025]);
%set(gca,'YScale','log');
%get(gca,'OuterPosition')
%set(gca,'OuterPosition',[0 0.1 0.9 0.9])

%axis([10^23 0.01 10^26 10]);
%xlim([0 50]); 
%ylim([1.32508 1.32524]);

%set(gca,'XTick',[1 10 50 100]);
%set(gca,'YTick',0:2:10);

hl=legend('$C_{Y|X}$','$C_{Z|X}$', '$\tilde{C}_{YZ|X}$', '$C_{Y|X} + C_{Z|X}$');
set(hl,'FontSize', 30, 'Location', 'Northeast', 'Interpreter', 'latex');

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
    print -dpdf degraded_BSC_acc_rates;

    % Restore the previous settings
    set(gcf,'PaperType',prePaperType);
    set(gcf,'PaperUnits',prePaperUnits);
    set(gcf,'Units',preUnits);
    set(gcf,'PaperPosition',prePaperPosition);
    set(gcf,'PaperSize',prePaperSize);    
end
