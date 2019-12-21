function overallEnergySavings(collection_power_savings, mode)

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
                title('Energy Savings with different Color Reduction intensity');
                xlabel('Image #');
                ylabel('Energy Savings w.r.t. Original Image -- (%)');
                % legend(int2str(iterations*10) + "%")
                hold off

            end

            legend("10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%");

            saveas(gcf, "./Results/ColorReduction/bmp/EnergySavingsPerImage.bmp");
            saveas(gcf, "./Results/ColorReduction/svg/EnergySavingsPerImage.svg");

        case 1
            x_axis = linspace(1, 15, 15);
            Y = [];
            for i = 1:15
                Y(i) = collection_power_savings{i};
            end

            figure
            bar(x_axis, Y)
            xticks(1:1:15)
            yticks(-200:20:40)
            % xlim([1 15])
            title('Energy Savings with Histogram Equalization');
            xlabel('Image #');
            ylabel('Energy Savings w.r.t. Original Image -- (%)');
            % legend(int2str(iterations*10) + "%")
            
            saveas(gcf, "./Results/HistEqualization/bmp/EnergySavingsPerImage.bmp");
            saveas(gcf, "./Results/HistEqualization/svg/EnergySavingsPerImage.svg");
        
        otherwise

    end
    
end