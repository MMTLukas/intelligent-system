X=importdata('features_C.txt'); % load features
C=importdata('classes_C.txt'); % load class labels

for perplexity=[5, 20]
    % compute mapping via t-SNE using given perplexity
    D_tsne = tsne(X, [], 2, [], perplexity);
    % visualize projection and class labels in a scatter plot
    figure;
    gscatter(D_tsne(:,1), D_tsne(:,2), C);
    title(['t-SNE with perplexity ' num2str(perplexity)]);
    % display legend with class names
    legend('country', 'folk', 'jazz', 'blues', 'rnbsoul', ...
        'heavymetalhardrock', 'alternativerockindie', 'punk', ...
        'raphiphop', 'electronica', 'reggae', 'rocknroll',    'pop', ...
        'classical');
end;