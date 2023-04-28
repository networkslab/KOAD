%%% Cannot simply use KRLS function call, as we need the "dotProd" internal variable. %%%

% clear
%%% Run KRLS1dSpace_ver8, with X=P, nu1=0.03, nu2=0.07, and (IMPORTANT) d=0.5
% save INFOCOM07\Figs\Fig2.mat;

% load INFOCOM07\Figs\Fig2.mat;


%(1-0.125-0.125-0.0250-0.0250)/3 equals  0.2333

figure;
clf;
hold off;
% Plot normal Dictionary element
subplot('position',[0.150, 0.125+2*(0.2333+0.025), 0.750, (1-0.125-0.125-0.0250-0.0250)/3]);
g = plot(dotProd(:,5), 'k'); %Normal
axis([801 T 0.7 1]);
set(g, 'LineWidth', 1);
hold on;
g = plot([1:T], 0.9*ones(1,T), 'r--'); %Show the d=0.9 threshold level
set(g, 'LineWidth', 2);
set(gca, 'FontSize', 14);
set(gca, 'XGrid', 'On');
set(gca, 'XTick', [1000 1250 1500 1750 2000]);
set(gca, 'XTickLabel', []);
set(gca, 'YTick', [0.8 0.9 1]);
set(gca, 'XMinorTick', 'On');
%xlabel('Timestep');
ylabel('Kernel\newline value');

% Plot obsolete Dictionary element
hold on;
subplot('position',[0.150, 0.125+1*(0.2333+0.025), 0.750, (1-0.125-0.125-0.0250-0.0250)/3]);
g = plot(dotProd(:,18), 'k'); %Obsolete
axis([801 T 0.7 1]);
set(g, 'LineWidth', 1);
hold on;
g = plot([1:T], 0.9*ones(1,T), 'r--'); %Show the d=0.9 threshold level
set(g, 'LineWidth', 2);
set(gca, 'FontSize', 14);
set(gca, 'XGrid', 'On');
set(gca, 'XTick', [1000 1250 1500 1750 2000]);
set(gca, 'XTickLabel', []);
set(gca, 'YTick', [0.8 0.9 1]);
set(gca, 'XMinorTick', 'On');
%xlabel('Timestep');
ylabel('Kernel\newline value');

% Plot anomalous Dictionary element
hold on;
subplot('position',[0.150, 0.125+0*(0.2333+0.025), 0.750, (1-0.125-0.125-0.0250-0.0250)/3]);
g = plot(dotProd(:,26), 'k'); %Anomalous, corr. to Red2 at t=1270
axis([801 T 0.7 1]);
set(g, 'LineWidth', 1);
hold on;
g = plot([1:T], 0.9*ones(1,T), 'r--'); %Show the d=0.9 threshold level
set(g, 'LineWidth', 2);
set(gca, 'FontSize', 14);
set(gca, 'XGrid', 'On');
set(gca, 'XTick', [1000 1250 1500 1750 2000]);
%set(gca, 'XTickLabel', []);
set(gca, 'YTick', [0.8 0.9 1]);
set(gca, 'XMinorTick', 'On');
xlabel('Timestep');
ylabel('Kernel\newline value');

% saveas(gca, 'INFOCOM07\Figs\Fig2.fig');
% print -depsc INFOCOM07\Figs\Fig2.eps;
