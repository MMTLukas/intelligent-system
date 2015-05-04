% Dataset A
data = importdata('features_A.txt');
data_m = PCA(data);
[ProximityMatrix,DistanceMatrix] = calc_prox_and_distance_matrix(data, data_m);
for i = [1,3,5,10,25,50]
	disp(['NPR-A: ', num2str(compute_NPR(ProximityMatrix, DistanceMatrix, i))]);
end

% Dataset B
data = importdata('features_B.txt');
data_m = PCA(data);
[ProximityMatrix,DistanceMatrix] = calc_prox_and_distance_matrix(data, data_m);
for i = [1,3,5,10,25,50]
	disp(['NPR-B: ', num2str(compute_NPR(ProximityMatrix, DistanceMatrix, i))]);
end

% Dataset C
data = importdata('features_C.txt');
data_m = PCA(data);
[ProximityMatrix,DistanceMatrix] = calc_prox_and_distance_matrix(data, data_m);
for i = [1,3,5,10,25,50]
    disp(['NPR-C: ', num2str(compute_NPR(ProximityMatrix, DistanceMatrix, i))]);
end

