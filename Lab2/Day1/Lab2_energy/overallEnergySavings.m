function overallEnergySavings(collection_power_savings, eucl, ssim, mode)

    switch mode
        case 0
            Y = [];
            x_axis = linspace(1, 15, 15);
            figure

            for iterations = 1:10

                for i = 1:15
                    Y(i) = collection_power_savings{iterations}{i};
                end
                
                hold on
                plot(x_axis, Y, '-o', 'DisplayName', int2str(iterations*10) + "%")
                xticks(1:1:15)
                xlim([1 15])
                title('Energy Savings w/ different Color Reduction intensity');
                xlabel('Image #');
                ylabel('Energy Savings w.r.t. Original Image -- (%)');
                lgd = legend;
                lgd.Title.String = "Color Reduction %";
                % legend(int2str(iterations*10) + "%")
                hold off

            end

            legend("10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%");

            saveas(gcf, "./Results/ColorReduction/bmp/EnergySavingsPerImage.bmp");
            saveas(gcf, "./Results/ColorReduction/svg/EnergySavingsPerImage.svg");

        case 1
            x_axis = linspace(1, 15, 15);
            Y = [];
            Y_1 = [];
            Y_2 = [];
            for i = 1:15
                Y(i) = collection_power_savings{i};
                Y_1(i) = ssim{i}*100;
                Y_2(i) = eucl{i};
            end

            figure
            
            set(gcf,'position',[10, 10, 1800, 800])
            sgtitle('Histogram Equalization: Energy Savings and Similarity', 'FontWeight','bold', 'FontSize',14);
            
            subplot(1, 3, 1);
            bar(x_axis, Y)
            xticks(1:1:15)
            yticks(-160:10:100)
            % xlim([1 15])
            ylim([-160 100])
            
            xlabel('Image #');
            ylabel('Energy Savings w.r.t. Original Image -- (%)');
            % legend(int2str(iterations*10) + "%")
            
            %yyaxis left
            subplot(1, 3, 2);
            bar(x_axis, Y_1)
            yticks(0:10:100)
            ylim([0 100])
            xlabel('Image #');
            ylabel('Ssim (similarity) -- (%)');
            
            subplot(1, 3, 3);
            bar(x_axis, Y_2)
            yticks(0:5:100)
            ylim([0 100])
            xlabel('Image #');
            ylabel('Euclidean distance (diversity) -- (%)');
            
            saveas(gcf, "./Results/HistEqualization/bmp/EnergySavingsPerImage.bmp");
            saveas(gcf, "./Results/HistEqualization/svg/EnergySavingsPerImage.svg");
        
        otherwise

    end
    
end