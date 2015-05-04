function NPR = compute_NPR(P, D, NN)
    [~, P_Ni] = find_nn(P, NN);
    [~, D_Ni] = find_nn(D, NN);
    
    hits = 0;
    for i=1:size(P_Ni,1)
        for j = 1:size(P_Ni,2)
            for k = 1:size(P_Ni,2)
                if P_Ni(i, j) == D_Ni(i, k)
                    hits = hits + 1;
                end
            end
        end
    end
    
    NPR = hits / (length(P) * NN);
end