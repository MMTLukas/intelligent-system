function [ dimensions ] = calc_needed_dimensions( data )
    % compute covariance matrix
    data_c = cov(data);

    % eigendecomposition of m_covariance
    [~, e_values] = eig(data_c);

    % sort matrix diagonale
    [e_values, ~] = sort(diag(e_values), 'descend');

    % calc value of 90% of the eigenvalues
    sum_values = sum(e_values, 'double');
    ninety_percent = sum_values * 0.9;

    % find the necessary amount of dimensions needed for 90%
    tmp = 0;
    for idx = 1:length(e_values)
        tmp = tmp + e_values(idx);
        if(tmp >= ninety_percent)
            break;
        end;
    end;

    % holds the needed dimension 
    dimensions = idx;
end