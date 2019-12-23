function send_data()
I8=imread('images/img_1.tiff');
I6=I8./4;
I6_r= imresize(I6,[128,128]);
R=I6_r(:,:,1);
G=I6_r(:,:,2);
B=I6_r(:,:,3);
I6_r(:,:,1)=B;
I6_r(:,:,2)=G;
I6_r(:,:,3)=R;

s=serial('/dev/tty.usbmodem14501','BaudRate',115200);
file=fopen('./sticazzi.txt','w');

fopen(s);
pause(1);
y=dec2bin(I6_r);
fwrite(s,['0','1',y(1,:)],'uint8'); %new image
n=size(y);
for i=2:n
fwrite(s,['0','0',y(i,:)],'uint8');
end

fclose(s);
end