% Run KRLS %
% clear;
% load AbileneAllTrafficViews-15to21.mat P;
% X = P;
% nu1 = 0.03;
% nu2 = 0.07;
% [Red1 Red2 deltaStore] = KRLS_2(X, nu1, nu2);
% 
% % Run PCA %
% load AbileneAllTrafficViews-15to21.mat P;
% X = P;
% r = 4; %Number of Principal Components
% [alarm_PCA residual_PCA delta_PCA] = PCA(X, r);
% 
% % Run OCNM %
% load AbileneAllTrafficViews-15to21.mat P;
% X = P;
% [T F] = size(X);
% X = X./repmat(sqrt(sum(X.*X,2)+eps),1,size(X,2)); %normalize to unit circle (i.e. divide by norm)
% fraction=0.1;
% mu = 0.98;
% k = 50;
% [h_i, f] = OCNM_ver2(X,mu,k);
% OCNM_threshold = min(f(h_i<0));
% alarm_OCNM = find(h_i<0);
%
% save INFOCOM07\Figs\Fig1.mat

clear;
load INFOCOM07\Figs\Fig1.mat
figure;
clf;

% Generate KRLS (top) panel
%load webpage\KRLSresults.mat;
subplot('position',[0.150,0.725,0.750,0.175]);
v = semilogy([401:T], deltaStore(401:T), 'k');
set(v,'LineWidth',1);
h = ylabel('\delta_t');
l1 = line([401,T], [nu1,nu1]);
set(l1,'Color', 'g');
set(l1,'LineWidth',2);
set(l1,'LineStyle',':');
l2 = line([401,T], [nu2,nu2]);
set(l2,'Color', 'r');
set(l2,'LineWidth',2);
set(l2,'LineStyle','--');
set(h,'FontSize',16);
axis([401 T 0 1]);
set(gca,'FontSize',12);
set(gca,'XTickLabel',[]);
set(gca,'YTick',[10^-2, 10^-1]);
v = text(2040,0.08,'(a)');
set(v,'FontSize',12);


% Generate PCA (second from top) panel
%load webpage\PCAresults.mat;
subplot('position',[0.150,0.525,0.750,0.175]);
v = semilogy([401:T], residual_PCA(401:T), 'k');
set(v,'LineWidth',1);
l1 = line([401,T], [delta_PCA, delta_PCA]);
set(l1,'Color', 'r');
set(l1,'LineWidth',2);
set(l1,'LineStyle','--');
h = ylabel('Magnitude\newline of residual');
set(h,'FontSize',12);
axis([401 T 0 2.5*10^11]);
set(gca,'FontSize',12);
set(gca,'XTickLabel',[]);
set(gca,'YTick',[10^9, 10^11]);
v = text(2040,10^10,'(b)');
set(v,'FontSize',12);

% Generate OCNM (third from top) panel
%load webpage\OCNMresults.mat;
subplot('position',[0.150,0.325,0.750,0.175]);
v = semilogy([401:T], f(401:T), 'k');
set(v,'LineWidth',1);
l1 = line([401,T], [OCNM_threshold, OCNM_threshold]);
set(l1,'Color', 'r');
set(l1,'LineWidth',2);
set(l1,'LineStyle','--');
h = ylabel('Euclidean\newline distance');
set(h,'FontSize',12);
axis([401 T 0.1 1.2]);
set(gca,'FontSize',12);
set(gca,'XTickLabel',[]);
set(gca,'YTick',[0.1,1]);
v = text(2040,0.4,'(c)');
set(v,'FontSize',12);

% Generate anomaly position indicators (botom panel)
subplot('position',[0.150,0.125,0.750,0.175]);
l1 = plot([Red1 Red2], 3*ones(1,size([Red1 Red2],2)),'diamond');
set(l1,'Color', 'b');
set(l1,'LineWidth',2);
hold on;
%l2 = plot(find(residual_PCA>delta_PCA), 2*ones(1,size(find(residual_PCA>delta_PCA),2)),'o');
l2 = plot(alarm_PCA, 2*ones(1,size(alarm_PCA,2)),'o');
set(l2,'Color', 'r');
set(l2,'LineWidth',2);
l3 = plot(alarm_OCNM, 1*ones(1,size(alarm_OCNM,2)),'square');
set(l3,'Color', 'k');
set(l3,'LineWidth',2);
axis([401 T 0.1 1.2]);
set(gca,'FontSize',12);
set(gca,'YLim',[0.5,3.5]);
set(gca,'YTickLabel',[]);
v = text(200,3,'KRLS');
set(v,'FontSize',12);
set(v,'Color', 'b');
v = text(200,2,'PCA');
set(v,'Color', 'r');
set(v,'FontSize',12);
v = text(200,1,'OCNM');
set(v,'Color', 'k');
set(v,'FontSize',12);
xlabel('Timestep');
set(gca,'FontSize',12);
v = text(2040,2,'(d)');
set(v,'FontSize',12);
set(gca,'XTick',[500 750 1000 1250 1500 1750 2000]);
%set(gca,'XTickLabel',[]);

% saveas(gca, 'INFOCOM07\Figs\Fig1.fig');
% print -depsc INFOCOM07\Figs\Fig1.eps;
