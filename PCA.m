function PCA = PCA(data)
    % mean normalized data
    data_m = repmat(mean(data), size(data,1), 1);

    % compute covariance matrix
    data_c = cov(data);

    % eigendecomposition of m_covariance
    [e_matrix, e_values] = eig(data_c);

    % sort matrix diagonale
    [e_values, e_indices] = sort(diag(e_values), 'descend');

    % sort matrix
    e_matrix = e_matrix(:,e_indices);

    PCA = ( data - data_m ) * e_matrix(:,1:2);

    % plot 
    scatter(PCA(:,1), PCA(:,2), 10, 'fill');
    xlabel('PCA Projection 1st');
    ylabel('PCA Projection 2nd');
    title('PCA projection');
    set(gca, 'FontSize', 12);
end