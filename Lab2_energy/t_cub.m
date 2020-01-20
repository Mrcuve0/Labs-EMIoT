function I_cub=t_cub(I,coeff)
I_cub=zeros(256,256,3);
for i=1:256
    for j=1:256
        %for z=1:3
            I_cub(i,j,3)=coeff(1)*I(i,j,3)^3+coeff(2)*I(i,j,3)^2+coeff(3)*I(i,j,3)+coeff(4);
        %end
    end
end

end