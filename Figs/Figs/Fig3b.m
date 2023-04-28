% clear;
% load AbileneAllTrafficViews-15to21.mat F;
% X = F; [T f] = size(X);
% 
% %%% Part of PCA %%%
% X = X - repmat( mean(X,1) , size(X,1) , 1 ); %Then subtract off each dimension across all timesteps.
% C = X'*X;
% [V D] = eig(C); %Columns of V are the e-vectors
% V = fliplr(V);
% normSquare = sum((X*V).^2);
% var = normSquare/sum(normSquare); %Percentage of variances
% 
% r=2; R = V(:,r); %Project EXCLUSIVELY onto Principal Component # r
% X_hat = R*R'*X'; X_state=sum(X_hat.^2,1); %Projections
% %%% END Part of PCA %%%
% 
% save INFOCOM07\Figs\Fig3b.mat;

clear;
load INFOCOM07\Figs\Fig3b.mat;

%(1-0.125-0.125-0.050)/2 equals  0.0.3500
figure;
clf;

subplot('position',[0.150, 0.125+1*(0.3500+0.050), 0.750, (1-0.125-0.125-0.050)/2 ]);
g = semilogy(F(:,79),'k');
set(g, 'LineWidth', 2);
set(gca, 'XTickLabel', []);
set(gca, 'YTick', [10^4 10^5 10^6]);
set(gca, 'FontSize', 16);
ylabel('Number of\newline IP flows');
xlim([601 1800])
ylim([10^3.75 10^6]);

subplot('position',[0.150, 0.125+0*(0.3500+0.050), 0.750, (1-0.125-0.125-0.050)/2 ]);
g = semilogy(X_state, 'k');
set(g, 'LineWidth', 2);
%ylim([0 0.5]);
xlim([601 1800])
ylim([10^0 10^12.5]);
set(gca, 'FontSize', 16);
ylabel('Magnitude of \newline projection');
xlabel('Timestep');

% saveas(gca, 'INFOCOM07\Figs\Fig3b.fig');
% print -depsc INFOCOM07\Figs\Fig3b.eps;
