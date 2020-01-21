clear all
close all
clc
format long

% Original version
original_vector_images = [];
original_vector_images_lab = [];
original_vector_power = [];

% Modified version
modified_vector_images = [];
modified_vector_images_lab = [];
modified_vector_power = [];

% Results
vector_eucl_distances = [];
vector_ssim_distances = [];
vector_power_savings = [];

% Reading images
for i = 1:1:15
    
    % Reading images
    original_vector_images{i} = imread("images/img_" + num2str(i) + ".tiff");
    original_vector_images_lab{i} = rgb2lab(original_vector_images{i});
    % figure, imshow(vector_images{i})
    
    % Compute power consumption for each image (in Watt)
    [~, original_vector_power{i}, ~, ~, ~] = image_power(original_vector_images{i});
    
end

collection_color_reduced_images = {};
collection_color_reduced_eucl_distances = {};
collection_color_reduced_ssim_distances = {};
collection_color_reduced_power_savings = {};

collection_hist_equalized_images = {};
collection_hist_equalized_eucl_distances = {};
collection_hist_equalized_ssim_distances = {};
collection_hist_equalized_power_savings = {};

for iterations = 1:10
    
    % Modify images -- Color Manipulation
    eps = [];
    for i = 1:1:15

        img = original_vector_images{i};
        if i == 1
            % figure, imshow(img)
        end

        img = color_reduction(img, iterations*10, iterations*10, iterations*10);
        if i == 1
            % figure, imshow(img)
        end

        modified_vector_images{i} = img;
        modified_vector_images_lab{i} = rgb2lab(modified_vector_images{i});
        [~, modified_vector_power{i}, ~, ~, ~] = image_power(img);

    end 

    % Distortion and Power savings computations
    for i = 1:1:15

        % Compute distortion between original and modified images
        eps{i} = eucl_dist(original_vector_images_lab{i}, modified_vector_images_lab{i});
        vector_eucl_distances{i} = perc_dist(eps{i}, size(original_vector_images_lab{i}), size(modified_vector_images_lab{i}));
        vector_ssim_distances{i} = ssim(modified_vector_images{i}, original_vector_images{i});

        % Compute power reduction between original and modified images
        vector_power_savings{i} = ((original_vector_power{i} - modified_vector_power{i}) / original_vector_power{i}) * 100;

        % PRINT the original alongside the modified image
        % colorReductionComparison(original_vector_images{i}, modified_vector_images{i}, i, iterations);

    end
    
    collection_color_reduced_eucl_distances{iterations} = vector_eucl_distances;
    collection_color_reduced_ssim_distances{iterations} = vector_ssim_distances;
    collection_color_reduced_power_savings{iterations} = vector_power_savings;
    collection_color_reduced_images{iterations} = modified_vector_images;
    
end

% Apply Histogram COLOR equalization
for i = 1:1:15

    HSV_img = rgb2hsv(original_vector_images{i});
    temp = HSV_img(:, :, 3);
    HSV_img_histeq = histeq(temp);
    HSV_mod = HSV_img;
    HSV_mod(:, :, 3) = HSV_img_histeq;
    
    collection_hist_equalized_images{i} = hsv2rgb(HSV_mod);
    collection_hist_equalized_images{i} = im2uint8(collection_hist_equalized_images{i});
    modified_vector_images{i} = im2uint8(collection_hist_equalized_images{i});
    
    % PRINT
    % histEqualizationComparison(original_vector_images{i}, collection_hist_equalized_images{i}, i, 1);
    color_histogram_graph(original_vector_images{i}, collection_hist_equalized_images{i}, i);

    % RGB-2-LAB
    modified_vector_images_lab{i} = rgb2lab(collection_hist_equalized_images{i});
    
    % Compute power reduction between original and modified images
    [~, modified_vector_power{i}, ~, ~, ~] = image_power(collection_hist_equalized_images{i});
    vector_power_savings{i} = ((original_vector_power{i} - modified_vector_power{i}) / original_vector_power{i}) * 100;
    
    % Compute distortion between original and modified images
    eps{i} = eucl_dist(original_vector_images_lab{i}, modified_vector_images_lab{i});
    vector_eucl_distances{i} = perc_dist(eps{i}, size(original_vector_images_lab{i}), size(modified_vector_images_lab{i}));
    vector_ssim_distances{i} = ssim(modified_vector_images{i}, original_vector_images{i});

    collection_hist_equalized_eucl_distances{i} = vector_eucl_distances{i};
    collection_hist_equalized_ssim_distances{i} = vector_ssim_distances{i};
    collection_hist_equalized_power_savings{i} = vector_power_savings{i};
    collection_hist_equalized_images{i} = modified_vector_images{i};

end

% Uncomment to create plots related to energy consumption and image similarity

% PRINT -- Color Reduction: Comparisons (sweep)
% overallEnergySavings(collection_color_reduced_power_savings, {}, {}, 0);
% PRINT -- Color Reduction: SSIM
% imagePercSavingsBar(collection_color_reduced_power_savings, collection_color_reduced_ssim_distances, 0);
% PRINT -- Color Reduction: Euclidean Distance
% imagePercSavingsBar(collection_color_reduced_power_savings, collection_color_reduced_eucl_distances , 1);

% PRINT -- Histogram Equalization: Energy Savings per Image
 overallEnergySavings(collection_hist_equalized_power_savings, collection_hist_equalized_eucl_distances, collection_hist_equalized_ssim_distances, 1);

% TODO: complete this
% imagePercSavingsBar(collection_color_reduced_power_savings, collection_color_reduced_ssim_distances, 2);


