function I_d = color_reduction(I, perc_reduction_R, perc_reduction_G, perc_reduction_B)
    % Reduces each channel according to the 3 percentages of reduction
    % given for each channel
    
    I = single_color_reduction(I, perc_reduction_R, 1);
    I = single_color_reduction(I, perc_reduction_G, 2);
    I = single_color_reduction(I, perc_reduction_B, 3);
    
    I_d = I;

end