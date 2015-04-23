function [ sstress, kstress, msloss ] = calc_error_estimations( P, D )
    % S-stress
    sstress = sum(sum(P.^2-D.^2).^2);

    % Kruskal's stress
    kstress_tmp = (P-D).^2 ./ P.^2;
    idx_notNaN = find(~isnan(kstress_tmp));             % identify NaN's (caused by div-by-0)
    kstress = sum(sum(kstress_tmp(idx_notNaN)));        % compute Kruskal's stress on numeric values only

    % Multiscale loss
    msloss_tmp = (log(P)-log(D)).^2;
    idx_notNaN = find(~isnan(msloss_tmp));             % identify NaN's caused by log(0)=-Inf
    msloss = sum(sum(msloss_tmp(idx_notNaN)));         % compute multiscale loss on numeric values only
end

