% clear
% load AbileneAllTrafficViews-15to21.mat;
% X = F;
% [T f] = size(X);
% nu1 = 0.03; nu2 = 0.07;
% [Red1 Red2 deltaStore] = KRLS_2(X, nu1, nu2);
% 
% save INFOCOM07\Figs\Fig3a.mat;

clear;
load INFOCOM07\Figs\Fig3a.mat;

%(1-0.125-0.125-0.050)/2 equals  0.0.3500
figure;
clf;

subplot('position',[0.150, 0.125+1*(0.3500+0.050), 0.750, (1-0.125-0.125-0.050)/2 ]);
g = plot(X(:,101), 'k');
set(g, 'LineWidth', 2);
set(gca, 'XTickLabel', []);
%set(gca, 'YTick', [10^3 10^4 10^5]);
set(gca, 'FontSize', 16);
ylabel('Number of\newline IP flows');
ylim([0 2.5*10^4]);
xlim([801 1200])

subplot('position',[0.150, 0.125+0*(0.3500+0.050), 0.750, (1-0.125-0.125-0.050)/2 ]);
g = plot(deltaStore, 'k');
set(g, 'LineWidth', 2);
hold on;
g = plot([1:T], nu2*ones(1,T), 'r--');
set(g, 'LineWidth', 2);
ylim([0 0.5]);
set(gca, 'YTick', [0.1 0.3 0.5]);
xlim([801 1200]);
h1 = ylabel('\delta');
set(h1, 'FontSize', 20);
h2 = xlabel('Timestep');
set(h2, 'FontSize', 16);
set(gca, 'FontSize', 16);

% saveas(gca, 'INFOCOM07\Figs\Fig3a.fig');
% print -depsc INFOCOM07\Figs\Fig3a.eps;
