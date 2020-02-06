function HSV_img_reduced = luminance_reduction(HSV_img, alpha)
    reduction = alpha / 100;
    HSV_img_reduced = HSV_img;
    HSV_img_reduced(:, :, 3) = HSV_img(:, :, 3) - reduction;
end