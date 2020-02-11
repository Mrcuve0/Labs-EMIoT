clc, close all, clear all

x = []
y = []
figure
for i = 1:5
    load("./Case " + int2str(i) + "/idleValues.txt");
    x{i} = transpose(idleValues)
    y{i} = x{i}
    x{i} = x{i}(1:4999)
    y{i} = y{i}(2:5000)
    hold on
    scatter(x{i}, y{i})
end
hold off

 
