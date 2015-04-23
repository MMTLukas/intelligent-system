function [ ] = plot_shepard( P, D  )
    P_vec=reshape(P, numel(P), 1);
    D_vec=reshape(D, numel(D), 1);

    scatter(P_vec, D_vec, 5, 'filled');
    set(gca,'FontSize', 12);
    xlabel('Proximities');
    ylabel('Distances');
    title('Shepard plot');
    line;
end

