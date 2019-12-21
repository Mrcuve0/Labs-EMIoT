function histEqualizationComparison(original_image, hist_equalized_image, index, mode)

    switch mode

        case 0
            figure 
            subplot(2, 2, 1);
            imshow(original_image);
            title("Grayscale (RGB) Histogram Equalization");
            subplot(2, 2, 2);
            imhist(original_image, 64);

            subplot(2, 2, 3)
            imshow(hist_equalized_image)
            subplot(2, 2, 4)
            imhist(hist_equalized_image, 64)

            saveas(gcf, "./Results/HistEqualization/bmp/hist_equalization_GRAYSCALE_img_" + int2str(index) + ".bmp");
            saveas(gcf, "./Results/HistEqualization/svg/hist_equalization_GRAYSCALE_img_" + int2str(index) + ".svg");

        case 1
            figure 
            subplot(2, 2, 1);
            imshow(original_image);
            title("Luminance (HSV) Histogram Equalization");
            subplot(2, 2, 2);
            imhist(original_image, 64);

            subplot(2, 2, 3)
            imshow(hist_equalized_image)
            subplot(2, 2, 4)
            imhist(hist_equalized_image, 64)

            saveas(gcf, "./Results/HistEqualization/bmp/hist_equalization_COLOR_img_" + int2str(index) + ".bmp");
            saveas(gcf, "./Results/HistEqualization/svg/hist_equalization_COLOR_img_" + int2str(index) + ".svg");

        otherwise
    end
    
end
