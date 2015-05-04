function [ ProximityMatrix, DistanceMatrix ] = calc_prox_and_distance_matrix( data, data_m )
    % set distance function
    dist = 'euclidean';

    % compute proximities in input space
    ProximityMatrix = squareform(pdist(data, dist));
    ProximityMatrix = ProximityMatrix ./ max(max(ProximityMatrix));

    % compute distances in output space
    DistanceMatrix = squareform(pdist(data_m, dist));
    DistanceMatrix = DistanceMatrix ./ max(max(DistanceMatrix));
end

