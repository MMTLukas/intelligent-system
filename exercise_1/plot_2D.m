function [ ] = plot_2D( data, plotTitle, axesTitle )
    scatter(data(:,1), data(:,2), 5, 'fill');
    xlabel(strcat(axesTitle, ' 1st'));
    ylabel(strcat(axesTitle, ' 2nd'));
    title(plotTitle);
    set(gca, 'FontSize', 12);
end

