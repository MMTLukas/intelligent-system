% set distance function
dist = 'euclidean';

% apply Sammon's mapping
mapping = sammon(data, 2);                       % using DR toolbox function sammon

% compute proximities in input space
P = squareform(pdist(data, dist));
P = P ./ max(max(P));

% compute distances in output space
D = squareform(pdist(mapping, dist));
D = D ./ max(max(D));

% compute_NPR(P, D, 5);