% Datasets A-C
data = importdata('features_C.txt');
data_m = PCA(data);
plot_2D(data_m, 'PCA Projection - Dataset C', 'PCA Projection');
disp(['Dimensions: ', num2str(calc_needed_dimensions(data))]);