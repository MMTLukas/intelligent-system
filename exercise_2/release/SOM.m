function [ codebook ] = SOM( DATA, map_height, map_width, training_length, threshold )
    % ---------------------------------------------------------------------
    % INITIALIZING
    % each unit (model vector) m_i to represent 
    % a randomly selected data item
    units_length = map_height * map_width;
    [dataset_height dataset_width] = size(DATA);

    % matrix with random values between 0 and 1
    % height = number of map points
    % width = number of features
    % example: [4*6 1244] = [24 1244] = 24 rows and 1244 columns
    codebook = rand([units_length dataset_width]);

    % change values of model vectors in relationship to the max and min value
    for i = 1:units_length,
      random_row = DATA(randi(dataset_height),:);
      MAX = max(random_row); 
      MIN = min(random_row);
      codebook(i,:) = (MAX - MIN) * codebook(i,:) + MIN; 
    end
    % ---------------------------------------------------------------------
    
    % ---------------------------------------------------------------------
    % TRAINING
    % init voronoi set with 
    voronoi_sets = zeros(units_length, dataset_height);

    for t = 1:training_length

        % ----------------------------------------------------------------
        % BMU - Find best matching unit
        % select a random row from the input matrix
        % and compare it with every row in the codebook
        % to find the best matching unit
        random_row_idx = randi(dataset_height);
        distances = zeros(units_length, 1);
        for j = 1:units_length
            distances(j) = pdist2(DATA(random_row_idx,:), codebook(j,:));
        end
        % min distance means max similarity
        [bmu_distance, bmu_idx] = min(distances);
        % ----------------------------------------------------------------
        
        map_radius = max(map_height, map_width)/2;
        time_constant = training_length/log(map_radius);

        for j = 1:units_length
            % calc distance to the bmu for every map unit 
            % TODO: comment what we do here
            [bmu_row, bmu_col] = get_map_indices(bmu_idx, map_width);
            [unit_row, unit_col] = get_map_indices(j, map_width);
            map_distance_ij = pdist2([bmu_row, bmu_col], [unit_row, unit_col]);

            % calculate neighbourhood radius(t)
            % the neighbourhood radius decreases over time 
            % from map_radius to 1, which is the BMU
            %neighbourhood_radius = map_radius * exp(-t/time_constant);
            neighbourhood_radius = map_radius * exp(-t/time_constant);

            % r(t) neighboour - e.g.: pseudo gaussian
            pseudo_gaussian = exp(-(map_distance_ij^2)/(neighbourhood_radius^2));

            % learning rate alpha(t)
            % start at 1 and decrease
            learning_rate = 1 * exp(-t/training_length);

            % adapt model vectors of all units
            euclidian_diff = DATA(random_row_idx,:) - codebook(j,:);
            adapt_model_vector = learning_rate * pseudo_gaussian * euclidian_diff;
            codebook(j,:) = codebook(j,:) + adapt_model_vector;
        end;

        % ----------------------------------------------------------------
        % MEAN QUANTIZATION ERROR (MQE) for SOM

        % create voronoi set
        % write each dataset idx to its bmu idx 
        col_idx = find(voronoi_sets(bmu_idx,:)==0, 1);
        voronoi_sets(bmu_idx,col_idx) = random_row_idx;

        MMQE = 0;
        idx = 0;
        MQE = zeros(units_length,1);
        for u = 1:units_length
            for k = 1:length(voronoi_sets(u, :))
                 idx = voronoi_sets(u,k);
                 if idx == 0
                     break;
                 end

                 MQE(u) = MQE(u) + norm((DATA(idx,:) - codebook(u,:)),2);
            end;
            vi_norm = norm(voronoi_sets(u,:));

            % only add when there is at least one entry in the voronoi set
            if vi_norm ~= 0
                MQE(u) = MQE(u)/vi_norm;
                MMQE = MMQE + vi_norm/units_length*MQE(u);
            end;
        end;
        % ----------------------------------------------------------------

        if MMQE > threshold
            disp('Threshold reached!');
            break;
        end;
    end;
end

