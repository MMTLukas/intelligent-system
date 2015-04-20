sum_values = sum(e_values, 'double');
ninety_percent = sum_values * 0.9;

tmp = 0;
for idx = 1:length(e_values)
    tmp = tmp + e_values(idx);
    if(tmp >= ninety_percent)
        break;
    end;
end;