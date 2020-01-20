function I_d = single_color_reduction(I, perc_reduction, channel)

    n = size(I);
    I_d = I;
    
    % reduction => 255 : 100 = x : perc_reduction
    reduction = (perc_reduction * 255) / 100;  
    for i = 1:n(1)
        for j = 1:n(2)
            I_d(i, j, channel) = I(i, j, channel) - reduction;
        end
    end

end