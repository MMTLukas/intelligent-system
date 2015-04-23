% DATASET C

data = importdata('features_C.txt');

%% Calculations for sammon
data_m = sammon(data, 2);

% Distance matrices
[P, D] = calc_prox_and_distance_matrix(data, data_m);

% Compute error estimations
[sstress, kstress, msloss] = calc_error_estimations(P, D);
disp(['S-Stress: ', num2str(sstress)]);
disp(['Kruskal''s stress: ', num2str(kstress)]);
disp(['Multiscale loss: ', num2str(msloss)]);

% Compute neighbour preservation ratio
for i = [1,3,5,10,25,50]
    disp(['NPR: ', num2str(compute_NPR(P, D, i))]);
end;

% plot mapped dataset
plot_2D(data_m, 'PCA Projection - Dataset C', 'PCA Projection');

% Shephard's plot
plot_shepard(P, D);

%% Calculations for pca
data_m = pca(data);

% Distance matrices
[P, D] = calc_prox_and_distance_matrix(data, data_m);

% Compute error estimations
[sstress, kstress, msloss] = calc_error_estimations(P, D);
disp(['S-Stress: ', num2str(sstress)]);
disp(['Kruskal''s stress: ', num2str(kstress)]);
disp(['Multiscale loss: ', num2str(msloss)]);

% Compute neighbour preservation ratio
for i = [1,3,5,10,25,50]
    disp(['NPR: ', num2str(compute_NPR(P, D, i))]);
end;

% Shephard's plot
plot_shepard(P, D);
