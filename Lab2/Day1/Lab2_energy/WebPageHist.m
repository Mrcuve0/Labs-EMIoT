HIST_IN(:,1) = imhist(img(:,:,1),256); %RED
HIST_IN(:,2) = imhist(img(:,:,2),256); %GREEN
HIST_IN(:,3) = imhist(img(:,:,3),256); %BLUE

mymap=[1 0 0; 0.2 1 0; 0 0.2 1];

figure,subplot(1,2,1),b = bar(HIST_IN), b(1).FaceColor = [1 0 0], b(2).FaceColor = [0.3 1 0], b(3).FaceColor = [0 0.3 1]
legend('RED CHANNEL','GREEN CHANNEL','BLUE CHANNEL');title('Before Applying Histogram Equalization');