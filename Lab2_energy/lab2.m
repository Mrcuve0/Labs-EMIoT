clear all
close all
format long

albero=imread('images/img_6.tiff');
I=imread('images/img_1.tiff');
mymap=[1 0 0; 0 1 0 ;0 0 1];
HIST_IN(:,1) = imhist(I(:,:,1),256); %RED
HIST_IN(:,2) = imhist(I(:,:,2),256); %GREEN
HIST_IN(:,3) = imhist(I(:,:,3),256); %BLUE
figure,bar(HIST_IN);colormap(copper);legend('RED CHANNEL','GREEN CHANNEL','BLUE CHANNEL');title('Before Applying Histogram Equalization');
I=imread('images/img_1.tiff');
figure
imshow(I);
n=size(I);
I2=imread('images/img_2.tiff');
%figure
%imshow(I2);
%figure
%imshow(albero);

[p_pixel,p_image,R,G,B]=function_pow(I); %in Watt 

I_l=rgb2lab(I);
I2_l=rgb2lab(I2);

eps_=dist(I_l,I2_l);
perc_=percdist(eps_,n(1),n(2));

s=ssim(I,I2)*100;
%cut blue
I_d=distortion(I);
figure
imshow(I_d);
[p_mod_pixel,p_mod_im]=function_pow(I_d);
eps_d=dist(I,I_d);
perc=percdist(eps_d,n(1),n(2));

%linear transf
%alpha=5/8;
alpha=1/8;
I_lin=t_lin(I,alpha);
figure
imshow(I_lin)
[p_lin_pixel,p_lin_im]=function_pow(I_lin);


p_sav_blue=power_saving(p_image,p_mod_im);
p_sav_lin=power_saving(p_image,p_lin_im);
figure
subplot(2,2,1),imshow(I);
subplot(2,2,2),imshow(I_d);
subplot(2,2,3),imshow(I_lin);
figure
subplot(2,2,1),imhist(I);
subplot(2,2,2),imhist(I_d);
subplot(2,2,3),imhist(I_lin);
I_heq=histeq(I);
I_d_heq=histeq(I_d);
I_lin_heq=histeq(I_lin);
figure
subplot(2,2,1),imhist(I_heq);
subplot(2,2,2),imhist(I_d_heq);
subplot(2,2,3),imhist(I_lin_heq);
figure
subplot(2,2,1),imshow(I_heq);
subplot(2,2,2),imshow(I_d_heq);
subplot(2,2,3),imshow(I_lin_heq);

[p_heq,p_heq_im]=function_pow(I_heq);
[p_d_heq,p_d_heq_im]=function_pow(I_d_heq);
[p_lin_heq,p_lin_heq_im]=function_pow(I_lin_heq);

p_sav_heq=power_saving(p_image,p_heq_im)
p_sav_lin_heq=power_saving(p_image,p_lin_heq_im)
p_sav_d_heq=power_saving(p_image,p_d_heq_im)


coeff=cubic_function();
I_hsv=rgb2hsv(I);
I_hsv_heq=histeq(I_hsv(:,:,3));
I_hsv(:,:,3)=I_hsv_heq;
I_hsv_heq=hsv2rgb(I_hsv);
figure
imshow(I_hsv_heq);
[p_heq_,p_heq_im_]=function_pow(I_hsv_heq);
p_sav_heq_=power_saving(p_image,p_heq_im_)
I_cub_hsv=t_cub(I_hsv,coeff);
I_cub=hsv2rgb(I_cub_hsv);
figure
imshow(I_cub);
[p_cub,p_cub_im]=function_pow(I_cub);
p_sav_cub=power_saving(p_image,p_cub_im)




