% import data
DATA=importdata('features_C.txt');

% define parameters for the som algorithm
map_height = 4;
map_width = 6;
training_length = 50;
threshold = 100;

% SOM trains an map of unit according to the given data
% the results is matrix, which haves map_height*map_width rows
% and the dimensions of the dataset
codebook = SOM(DATA, map_height, map_width, training_length, threshold); 
