function coeff=cubic_function()
y=[0,90,130,140,255];
x=[0,90,200,230,255];
xq=0:0.3:255;
figure
plot(x,y);
%sp=spline(x,y,xq);
%figure
%plot(xq,sp);
p=polyfit(x,y,3);
p_v=polyval(p,xq);
figure
plot(xq,p_v);
coeff=p;
end