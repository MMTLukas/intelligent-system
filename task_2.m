% set distance function
dist = 'euclidean';

data = importdata('features_A.txt');

% apply mapping
pca = PCA(data);

% compute proximities in input space
P = squareform(pdist(data, dist));
P = P ./ max(max(P));

% compute distances in output space
D = squareform(pdist(pca, dist));
D = D ./ max(max(D));

% compute_NPR(P, D, NN);
for i = [1,3,5,10,25,50]
    compute_NPR(P, D, i)
end;