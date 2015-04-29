DATA=importdata('features_C.txt'); % load features
C=importdata('classes_C.txt'); % load class labels

% INITIALIZING
% each unit (model vector) Mi to represent a randomly selected data item
map_height = 4;
map_width = 6;

training_length = 100;

dataset_height = size(DATA,1);
dataset_width = size(DATA,2);

% matrix with random values between 0 and 1
% height = number of map points
% width = number of features
dim = size(DATA,2);
codebook = rand([map_height*map_width dim]);

% change values of model vectors in relationship to the max and min value
for i = 1:dim,
  inds = find(DATA(:,i)); 
  if isempty(inds)
      MIN = 0;
      MAX = 1; 
  else
      MAX = max(DATA(inds,i)); 
      MIN = min(DATA(inds,i));
  end
  codebook(:,i) = (MAX - MIN) * codebook(:,i) + MIN; 
end

% TRAINING
units_length = size(codebook,1);

for i = 1:units_length
    random_row = randi(size(DATA, 1));
    
    % find best matching unit (BMU)
    distances = zeros(units_length, 1);
    for j = 1:units_length
        distances(j) = pdist2(DATA(random_row,:), codebook(j,:));
    end
    [bmu_distance, bmu_idx] = max(distances);

    % calculate neighbourhood radius(t)
    map_radius = max(map_height, map_width)/2;
    time_constant = training_length/log(map_radius);

    codebook_trained = codebook;

    for j = 1:training_length
        % calculate neighbourhood radius(t)
        % the neighbourhood radius decreases over time from map_radius to 1, which is the BMU
        neighbourhood_radius = map_radius * exp(-j/time_constant);

        % r(t) neighboour - e.g.: pseudo gaussian
        distance = pdist2(codebook(bmu_idx,:),DATA(random_row,:));
        pseudo_gaussian = exp(-(distance)/(neighbourhood_radius^2));

        % learning rate alpha(t)
        learning_rate = 0.1 * exp(-j/time_constant);

        % adapt model vectors of all units  
        codebook_trained(i+1,:) = codebook_trained(i,:) + learning_rate * pseudo_gaussian * (DATA(random_row,:) - codebook(i));
    end;
end;