DATA=importdata('features_C.txt'); % load features
C=importdata('classes_C.txt'); % load class labels

% INITIALIZING
% each unit (model vector) Mi to represent a randomly selected data item
map_height = 4;
map_width = 6;
units_length = map_height * map_width;

training_length = 100*units_length;

dataset_height = size(DATA,1);
dataset_width = size(DATA,2);

% matrix with random values between 0 and 1
% height = number of map points
% width = number of features
% example: [4*6 1244] = [24 1244] = 24 rows and 1244 columns
codebook = rand([units_length dataset_width]);

% change values of model vectors in relationship to the max and min value
for i = 1:units_length,
  MAX = max(DATA(randi(dataset_height),:)); 
  MIN = min(DATA(randi(dataset_height),:));
  codebook(i,:) = (MAX - MIN) * codebook(i,:) + MIN; 
end

% TRAINING

% TODO: maybe use sMap.codebook later for training tests
codebook_trained = codebook;
for i = 1:training_length
    
    % find best matching unit (BMU)
    % select a random row from the input matrix
    % and compare it with every row in the codebook
    % to find the best matching unit
    random_row = randi(dataset_height);
    distances = zeros(units_length, 1);
    for j = 1:units_length
        distances(j) = pdist2(DATA(random_row,:), codebook_trained(j,:));
    end
    % min distance means max similarity
    [bmu_distance, bmu_idx] = min(distances);

    % calculate neighbourhood radius(t)
    map_radius = max(map_height, map_width)/2;
    time_constant = training_length/log(map_radius);

    for j = 1:units_length
        % calc distance to the bmu for every map unit 
        map_distance_ij = pdist2(codebook_trained(bmu_idx, :), codebook_trained(j,:));
        
        % calculate neighbourhood radius(t)
        % the neighbourhood radius decreases over time from map_radius to 1, which is the BMU
        neighbourhood_radius = map_radius * exp(-j/time_constant);

        % r(t) neighboour - e.g.: pseudo gaussian
        pseudo_gaussian = exp(-(map_distance_ij^2)/(neighbourhood_radius^2));

        % learning rate alpha(t)
        % start at 1 and decrease
        learning_rate = 1 * exp(-j/training_length);

        % adapt model vectors of all units
        codebook_trained(j,:) = codebook_trained(j,:) + learning_rate * pseudo_gaussian * (DATA(random_row,:) - codebook_trained(j,:));
    end;
end;