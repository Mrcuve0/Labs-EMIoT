function eps = eucl_distance(I_l, I2_l)
    
    % Luminance, a and b of the first image
    L = [];
    a = [];
    b = [];
    
    % Luminance, a and b of the second image
    L2 = [];
    a2 = [];
    b2 = [];
    n = size(I_l);
    m = size(I2_l);

    for i = 1:n(1)
        for j = 1:n(2)
            L(i,j) = I_l(i,j,1);
            a(i,j) = I_l(i,j,2);
            b(i,j) = I_l(i,j,3);
        end
    end

    for i = 1:m(1)
        for j = 1:m(2)
            L2(i,j) = I2_l(i,j,1);
            a2(i,j) = I2_l(i,j,2);
            b2(i,j) = I2_l(i,j,3);
        end
    end

    % Evaluating the distortion by computing the euclidean distance between pixels
    eps = 0;
    for i = 1:n(1)
        for j = 1:n(2)
            eps = eps + sqrt( (L(i,j)-L2(i,j))^2 + (a(i,j)-a2(i,j))^2 + (b(i,j)-b2(i,j))^2 );
        end
    end

end