% set distance function
dist = 'euclidean';

data = importdata('features_C.txt');

% apply mapping
data_m = sammon(data, 2);

% DISTANCE MATRICES

% compute proximities in input space
P = squareform(pdist(data, dist));
P = P ./ max(max(P));

% compute distances in output space
D = squareform(pdist(data_m, dist));
D = D ./ max(max(D));

% COMPUTE ERROR ESTIMATES

% S-stress
sstress = sum(sum(P.^2-D.^2).^2);
disp(['S-Stress: ', num2str(sstress)]),

% Kruskal's stress
kstress_tmp = (P-D).^2 ./ P.^2;
idx_notNaN = find(~isnan(kstress_tmp));             % identify NaN's (caused by div-by-0)
kstress = sum(sum(kstress_tmp(idx_notNaN)));        % compute Kruskal's stress on numeric values only
disp(['Kruskal''s stress: ', num2str(kstress)]),

% Multiscale loss
msloss_tmp = (log(P)-log(D)).^2;
idx_notNaN = find(~isnan(msloss_tmp));             % identify NaN's caused by log(0)=-Inf
msloss = sum(sum(msloss_tmp(idx_notNaN)));         % compute multiscale loss on numeric values only
disp(['Multiscale loss: ', num2str(msloss)]),

% NPR 

for i = [1,3,5,10,25,50]
    compute_NPR(P, D, i)
end;

% PLOT

scatter(data_m(:,1), data_m(:,2), 10, 'fill');
xlabel('PCA Projection 1st');
ylabel('PCA Projection 2nd');
title('PCA projection');
set(gca, 'FontSize', 12);

% SHEPHARD'S PLOT

% concert to vector representation
P_vec=reshape(P, numel(P), 1);
D_vec=reshape(D, numel(D), 1);

scatter(P_vec, D_vec, 5, 'filled');
set(gca,'FontSize', 26);
xlabel('Proximities');
ylabel('Distances');
title('Shepherd plot');
line;
