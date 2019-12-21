function imagePercSavingsBar(collection_power_savings, collection_distances, mode)

switch mode
    
    % Color Reduction: SSIM
    case 0
        Y_power = [];
        Y_distances = [];

        for i_image = 1:15

            figure
            for i_perc = 1:10

                Y_power(i_perc) = collection_power_savings{i_perc}{i_image};
                Y_distances(i_perc) = collection_distances{i_perc}{i_image} * 100;

            end

            x_axis = linspace(10, 100, 10);

            yyaxis left
            b = bar(x_axis, Y_power);
            % xticks(1:10:100)
            ylabel('Energy Savings -- (%)');

            yyaxis right
            p = plot(x_axis, Y_distances, "-o")
            p.LineWidth = 2;
            % xticks(1:1:10)
            % xlim([1 10])

            title('Energy Savings @ different Color Reductions');
            xlabel('Color Reduction -- (%)');
            ylabel('Similarity -- (%)');

            saveas(gcf, "./Results/ColorReduction/bmp/ImagePercSavingsBar_COLRED_SSIM_img_" + int2str(i_image) + ".bmp");
            saveas(gcf, "./Results/ColorReduction/svg/ImagePercSavingsBar_COLRED_SSIM_img_" + int2str(i_image) + ".svg");
        
        end     
    % Color Reduction: Euclidean Distance    
    case 1
        Y_power = [];
        Y_distances = [];

        for i_image = 1:15

            figure
            for i_perc = 1:10

                Y_power(i_perc) = collection_power_savings{i_perc}{i_image};
                Y_distances(i_perc) = collection_distances{i_perc}{i_image};

            end

            x_axis = linspace(10, 100, 10);

            yyaxis left
            b = bar(x_axis, Y_power);
            % xticks(1:10:100)
            ylabel('Energy Savings -- (%)');

            yyaxis right
            p = plot(x_axis, Y_distances, "-o")
            p.LineWidth = 2;
            % xticks(1:1:10)
            % xlim([1 10])

            title('Energy Savings @ different Color Reductions');
            xlabel('Color Reduction -- (%)');
            ylabel('Euclidean Distance -- (%)');

            saveas(gcf, "./Results/ColorReduction/bmp/ImagePercSavingsBar_COLRED_EUCL_img_" + int2str(i_image) + ".bmp");
            saveas(gcf, "./Results/ColorReduction/svg/ImagePercSavingsBar_COLRED_EUCL_img_" + int2str(i_image) + ".svg");
        
        end 
    
    % Histogram Equalization: SSIM
    case 2
        Y_power = [];
        Y_distances = [];

        for i_image = 1:15

            figure
            for i_perc = 1:10

                Y_power(i_perc) = collection_power_savings{i_perc}{i_image};
                Y_distances(i_perc) = collection_distances{i_perc}{i_image} * 100;

            end

            x_axis = linspace(10, 100, 10);

            yyaxis left
            b = bar(x_axis, Y_power);
            % xticks(1:10:100)
            ylabel('Energy Savings -- (%)');

            yyaxis right
            p = plot(x_axis, Y_distances, "-o")
            p.LineWidth = 2;
            % xticks(1:1:10)
            % xlim([1 10])

            title('Energy Savings w/ Histogram Equalization');
            xlabel('Color Reduction -- (%)');
            ylabel('Similarity -- (%)');

            saveas(gcf, "./Results/HistEqualization/bmp/ImagePercSavingsBar_HIST_SSIM_img_" + int2str(i_image) + ".bmp");
            saveas(gcf, "./Results/HistEqualization/svg/ImagePercSavingsBar_HIST_SSIM_img_" + int2str(i_image) + ".svg");

        end 
        
    otherwise
        
end

end