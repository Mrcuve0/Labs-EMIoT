clear all
close all
format long



I_l = rgb2lab(I);
I2_l = rgb2lab(I2);

% Compute distortion between original and modified images

eps = eucl_dist(I_l, I2_l);
perc = perc_dist(eps, n(1), n(2));

s = ssim(I,I2)*100;

I_d = distortion(I);
figure
imshow(I_d);
