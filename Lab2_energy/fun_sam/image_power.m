function [p_pixel, p_image, R, G, B] = image_power(I) 

    % Power constants
    wr = 2.13636845e-7;
    w0 = 1.48169521e-6;
    wg = 1.77746705e-7;
    wb = 2.14348309e-7;
    gamma = 0.7755;
    
    % [width, heigth, channels]
    n = size(I);
    
    R = [];
    G = [];
    B = [];
    
    p_pixel = [];
    p_image = 0;
    
     for i = 1:n(1)
        for j = 1:n(2)
             R(i,j) = I(i,j,1);
             G(i,j) = I(i,j,2);
             B(i,j) = I(i,j,3);
             p_pixel(i,j) = wr*(R(i,j).^gamma) + wg*(G(i,j).^gamma) + wb*(B(i,j).^gamma);
         end
     end
     
     %R(1:1:n(1), 1:1:n(2)) = I(1:1:n(1), 1:1:n(2), 1);
     %G(1:1:n(1), 1:1:n(2)) = I(1:1:n(1), 1:1:n(2), 2);
     %B(1:1:n(1), 1:1:n(2)) = I(1:1:n(1), 1:1:n(2), 3);
     %p_pixel(1:1:n(1), 1:1:n(2)) = wr*(R(1:1:n(1), 1:1:n(2))^gamma) + wg*(G(1:1:n(1), 1:1:n(2))^gamma) + wb*(B(1:1:n(1), 1:1:n(2))^gamma);
    
    part = 0;

    for i = 1:n(1)
        for j = 1:n(2)
        part = part + p_pixel(i,j);
        end
    end

    p_image = w0 + part;

end