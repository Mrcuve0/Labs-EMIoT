clc, close all, clear all
load("idleValues.txt");

% x1 = linspace(1, 5000, 5000);
x = transpose(idleValues);
y = x
x = x(1: 4999);
y = y(2: 5000);

[fitresult, gof] = createFit(x, y);

