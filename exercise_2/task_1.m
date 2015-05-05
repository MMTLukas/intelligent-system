X=importdata('features_C.txt'); % load features
C=importdata('classes_C.txt'); % load class labels

for perplexity=[5,20,40,80]
    % compute mapping via SNE using given perplexity
    D_sne = sne(X, 2, perplexity);
    % visualize projection and class labels in a scatter plot
    figure;
    gscatter(D_sne(:,1), D_sne(:,2), C);
    title(['SNE with perplexity ' num2str(perplexity)]);
    % display legend with class names
    % legend('country', 'folk', 'jazz', 'blues', 'rnbsoul', ...
    %     'heavymetalhardrock', 'alternativerockindie', 'punk', ...
    %     'raphiphop', 'electronica', 'reggae', 'rocknroll',    'pop', ...
    %     'classical');
end;