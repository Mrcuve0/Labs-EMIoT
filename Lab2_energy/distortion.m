function I_d=distortion(I)
n=size(I);
I_d=I;
for i= 1:n(1)
    for j= 1:n(2)
        I_d(i,j,1)=I(i,j,1)-30;
        I_d(i,j,2)=I(i,j,2)-20;
        I_d(i,j,3)=I(i,j,3)-30;
    end
end

end