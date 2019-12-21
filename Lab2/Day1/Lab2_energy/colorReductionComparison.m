function colorReductionComparison(original_image, modified_image, index, perc)

        figure
        subplot(1, 2, 1), imshow(original_image)
        subplot(1, 2, 2), imshow(modified_image)
        title("Image #" + int2str(index) + ", Color Reduction of " + int2str(perc*10) + "%");
        
        saveas(gcf, "./Results/ColorReduction/bmp/color_reduction_" + int2str(perc*10) + "perc_img_" + int2str(index) + ".bmp");
        saveas(gcf, "./Results/ColorReduction/svg/color_reduction_" + int2str(perc*10) + "perc_img_" + int2str(index) + ".svg");

end