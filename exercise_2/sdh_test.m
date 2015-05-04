X=importdata('features_C.txt'); % load features
C=importdata('classes_C.txt'); % load class labels
L=importdata('labels.txt'); % load class labels

% Initialisieren
% X = datenstruktur, [] = größe, lattice = rechtecke oder hexagon map 
sMap = som_randinit(X,'msize',[4 6],'shape','sheet','lattice','rect');
% sMap.codebook = model vectoren

% Training
% 'gaussian' = neighbourhood function, 100 = anzahl der epochen, anzahl der
% adaptierungsprozessen, 
sMap = som_batchtrain(sMap, X,'neigh','gaussian','trainlen', 100);

% sData = som_data_struct(X,'name','IS1-data','labels', cellstr(num2str(C)));
sData = som_data_struct(X,'name','IS1-data','labels', L);
% sMap = som_autolabel(sMap,sData, 'freq');
sMap = som_autolabel(sMap,sData);

% Display
som_show(sMap, 'empty', '','footnote', '','bar', 'none');
som_show_add('label', sMap.labels,'textsize', 7,'textcolor', 'k');

% interp.ntimes = anzahl der interpolierungen, spread = anzahl der mapunits
S = sdh_calculate(sData, sMap,'interp.ntimes', 4,'spread',1);

sdh_visualize(S, 'labels', sMap.labels,'sofn', 0,'fontcolor', ...
    'k','fontsize', 10);

colormap(jet);