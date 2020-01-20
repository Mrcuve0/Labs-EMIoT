clear all
close all
clc
format long

if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

img_index = 1;

% Image manipulation
img_8bit_dec = imresize(imread("../images/img_" + num2str(img_index) + ".tiff"), [128, 128]);

% Apply color reduction 8bit
img_8bit_dec = color_reduction(img_8bit_dec, 10, 10, 10);

% Shift from a 8 bit representation to a 6 bit representation
img_6bit_bin_R = dec2bin(bitshift(img_8bit_dec(:,:,1), -2));
img_6bit_bin_G = dec2bin(bitshift(img_8bit_dec(:,:,2), -2));
img_6bit_bin_B = dec2bin(bitshift(img_8bit_dec(:,:,3), -2));

% Apply color reduction 6bit
% img_6bit_dec = bitshift(img_8bit_dec(:,:,:), -2);
% img_6bit_dec = color_reduction(img_6bit_dec, 10, 10, 10);
% img_6bit_bin_R = dec2bin(img_6bit_dec(:, :, 1));
% img_6bit_bin_G = dec2bin(img_6bit_dec(:, :, 2));
% img_6bit_bin_B = dec2bin(img_6bit_dec(:, :, 3));


file = serial('COM3', 'BaudRate', 115200);
fopen(file);

pause(4);

send_image(file, img_6bit_bin_R, img_6bit_bin_G, img_6bit_bin_B)

fclose(file);