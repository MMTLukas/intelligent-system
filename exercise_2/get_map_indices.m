function [row, col] = get_map_indices(idx, map_width)
    row = floor((idx +  map_width-1)/map_width);
    col = mod(idx,map_width);
    if col == 0
        col = map_width;
    end
end