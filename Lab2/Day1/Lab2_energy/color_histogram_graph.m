function color_histogram_graph(I, RGB, index)

    HIST_IN = zeros([256 3]);
    HIST_OUT = zeros([256 3]);

    HIST_IN(:,1) = imhist(I(:, :, 1), 256); %RED
    HIST_IN(:,2) = imhist(I(:, :, 2), 256); %GREEN
    HIST_IN(:,3) = imhist(I(:, :, 3), 256); %BLUE

    HIST_OUT(:,1) = imhist(RGB(:, :, 1), 256); %RED
    HIST_OUT(:,2) = imhist(RGB(:, :, 2), 256); %GREEN
    HIST_OUT(:,3) = imhist(RGB(:, :, 3), 256); %BLUE

    mymap = [1 0 0; 0 1 0; 0 0 1];

    figure 
    
    set(gcf,'position',[10, 10, 1000, 800])
    
    subplot(2, 2, 1);
    imshow(I);
    subplot(2, 2, 2);
    hold on
    bar(HIST_IN(:, 1), 'FaceColor', [1 0 0]);
    bar(HIST_IN(:, 2), 'FaceColor', [0 1 0]);
    bar(HIST_IN(:, 3), 'FaceColor', [0 0 1]);
    hold off
    %colormap(mymap);
    legend('Red ch.', 'Green ch.', 'Blue ch.');
    %sgtitle('Before Histogram Equalization','FontWeight','bold', 'FontSize',14);


    subplot(2, 2, 3);
    imshow(RGB);
    subplot(2, 2, 4);
    hold on
    bar(HIST_OUT(:, 1), 'FaceColor', [1 0 0]);
    bar(HIST_OUT(:, 2), 'FaceColor', [0 1 0]);
    bar(HIST_OUT(:, 3), 'FaceColor', [0 0 1]);
    hold off
    %scolormap(mymap);
    legend('Red ch.', 'Green ch.', 'Blue ch.');
    sgtitle('Before and After Histogram Equalization','FontWeight','bold', 'FontSize',14);
    
    saveas(gcf, "./Results/HistEqualization/bmp/hist_equalization_RGB_img_" + int2str(index) + ".bmp");
    saveas(gcf, "./Results/HistEqualization/svg/hist_equalization_RGB_img_" + int2str(index) + ".svg");
end
