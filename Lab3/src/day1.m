close all, clc

% Day1 %

% Loading Irradiance values over one month (Input of PV Cell) (W/m²)
load('./gmonth.mat');
load('./gmonths.mat');

% Digitized curves (from PVCell Datasheet), 
% Voltage(V) v. Current(mA) @ different irradiance levels (W/m²)
PVDS1000 = importdata('./../Day1/PVModule/PVDS_1000.txt');
PVDS1000(:, 2) = PVDS1000(:, 2) / 1000;
PVDS750 = importdata('./../Day1/PVModule/PVDS_750.txt');
PVDS750(:, 2) = PVDS750(:, 2) / 1000;
PVDS500 = importdata('./../Day1/PVModule/PVDS_500.txt');
PVDS500(:, 2) = PVDS500(:, 2) / 1000;
PVDS250 = importdata('./../Day1/PVModule/PVDS_250.txt');
PVDS250(:, 2) = PVDS250(:, 2) / 1000;

% Building the power curves
for i=1:38
    powerCurve_PVDS1000(i) = PVDS1000(i, 1) * PVDS1000(i, 2);
end

for i=1:29
    powerCurve_PVDS750(i) = PVDS750(i, 1) * PVDS750(i, 2);
end

for i=1:31
    powerCurve_PVDS500(i) = PVDS500(i, 1) * PVDS500(i, 2);
end

for i=1:25
    powerCurve_PVDS250(i) = PVDS250(i, 1) * PVDS250(i, 2);
end

% Extrapolating the MPP for each curve
% Computing the Voltage and Current @ each MPP
MPP_PVDS1000 = max(powerCurve_PVDS1000);
index_V1000 = find(powerCurve_PVDS1000==MPP_PVDS1000);
V1000 = PVDS1000(index_V1000, 1);
I1000 = MPP_PVDS1000 / V1000;

MPP_PVDS750 = max(powerCurve_PVDS750);
index_V750 = find(powerCurve_PVDS750==MPP_PVDS750);
V750 = PVDS750(index_V750, 1);
I750 = MPP_PVDS750 / V750;

MPP_PVDS500 = max(powerCurve_PVDS500);
index_V500 = find(powerCurve_PVDS500==MPP_PVDS500);
V500 = PVDS500(index_V500, 1);
I500 = MPP_PVDS500 / V500;

MPP_PVDS250 = max(powerCurve_PVDS250);
index_V250 = find(powerCurve_PVDS250==MPP_PVDS250);
V250 = PVDS250(index_V250, 1);
I250 = MPP_PVDS250 / V250;

% Storing the V/I coordinates of each MPP
% Data feeded to the LUT of the PV Cell (Simulink-side)
% If the valeus are note exatly the ones of the LUT, the actual value is
% interpolated from the points avialable
G = [250; 500; 750; 1000];
V = [V250; V500; V750; V1000];
I = [I250; I500; I750; I1000];



% Day2 %

% Digitized curve (from Datasheet of PVCell DC-DC Converter), 
% Input Voltage(V) v. Efficiency(%)
PVDCDC_Efficiency = importdata('./../Day2/DCDC_PVModule_Converter/PVDCDC_Efficiency.txt');
PVDCDC_Efficiency_x= PVDCDC_Efficiency(:, 1);           % Input Voltage (V)
PVDCDC_Efficiency_y= PVDCDC_Efficiency(:, 2) / 100;     % Efficiency (%)

% Digitized curve (from Datasheet of Battery DC-DC Converter), 
% Load Current (mA) v. Efficiency(%)
BDCDC_Efficiency = importdata('./../Day2/DCDC_Battery_Converter/BDCDC_Efficiency.txt');
BDCDC_Efficiency_x = BDCDC_Efficiency(:, 1) / 1000;     % Current (mA) 
BDCDC_Efficiency_y = BDCDC_Efficiency(:, 2) / 100;      % Efficiency (%)

% (a*u) / (b+u*c) [a = 57.43, b = 0.001383, c = 63.21]
% f(x) = a*x^b+c 
a = -0.0003709; b = -0.6666; c = 0.9168;
% f(x) = p1*x^9 + p2*x^8 + p3*x^7 + p4*x^6 + p5*x^5 + p6*x^4 + p7*x^3 + p8*x^2 + p9*x + p10
% p1 =   4.624e+11;
% p2 =  -2.623e+11;
% p3 =   6.262e+10;
% p4 =  -8.176e+09;
% p5 =   6.341e+08;
% p6 =  -2.968e+07;
% p7 =   8.119e+05;
% p8 =  -1.189e+04;
% p9 =  77.73;
% p10 = 0.7373;
% f(x) = a*exp(b*x) + c*exp(d*x)
% a =       0.886;
% b =      0.3885;
% c =     -0.5706;
% d =  -1.496e+04;


% Digitized Curve 1C (from Datasheet of Battery),
% SoC (0-100%) v. Battery Voltage(V)
Battery1C = importdata('./../Day3/Curve1C.mat');
Battery1C_Interpolated_y = interp1(Battery1C(:, 1), Battery1C(:, 2), linspace(0, 1, 11));
Battery1C_Interpolated(:, 1) = linspace(0, 1, 11);
Battery1C_Interpolated(:, 2) = Battery1C_Interpolated_y;
Battery1C_Interpolated(1, 2) = Battery1C(1, 2);
Battery1C_Interpolated(11, 2) = Battery1C(58, 2);

% Digitized Curve 0.5C (from Datasheet of Battery),
% SoC (0-100%) v. Battery Voltage(V)
Battery05C = importdata('./../Day3/Curve05C.mat');
Battery05C_Interpolated_y = interp1(Battery05C(:, 1), Battery05C(:, 2), linspace(0, 1, 11));
Battery05C_Interpolated(:, 1) = linspace(0, 1, 11);
Battery05C_Interpolated(:, 2) = Battery05C_Interpolated_y;
Battery05C_Interpolated(11, 2) = Battery05C(52, 2);

figure 
plot(Battery05C_Interpolated(:, 1), Battery05C_Interpolated(:, 2), '-o');
hold on
grid on
plot(Battery1C_Interpolated(:, 1), Battery1C_Interpolated(:, 2), '-o');
legend('1C', '0.5C')
hold off


% Computing Voc and R
Icurve_1 = 1 * 3.2;
Icurve_2 = 0.5 * 3.2;
x = Battery05C_Interpolated(:, 1);
R = (Battery05C_Interpolated(:, 2) - Battery1C_Interpolated(:, 2)) ./ (Icurve_1 - Icurve_2);
Voc = Battery1C_Interpolated(:, 2) + R*Icurve_1;

figure 
plot(Battery05C_Interpolated(:, 1), Voc, '-o');
hold on
grid on
plot(Battery1C_Interpolated(:, 1), R, '-o');
legend('Voc', 'R')
hold off

% R v. SoC fitting
% f(u) = p1_R*u^6 + p2_R*u^5 + p3_R*u^4 + p4_R*u^3 + p5_R*u^2 + p6_R*u + p7_R
p1_R = -37.18;
p2_R = 124;
p3_R = -160.6;
p4_R = 101.6;
p5_R = -31.99;
p6_R = 4.333;
p7_R = 0.05867;

% p1_R =      -21.58;
% p2_R =       73.16;
% p3_R =      -95.65;
% p4_R =       60.52;
% p5_R =      -18.79;
% p6_R =       2.341;
% p7_R =      0.1635;

% Voc v. SoC fitting
% f(u) = p1_Voc*u^6 + p2_Voc*u^5 + p3_Voc*u^4 + p4_Voc*u^3 + p5_Voc*u^2 + p6_Voc*u + p7_Voc
p1_Voc = -143.1;
p2_Voc = 502.3;
p3_Voc = -690.2;
p4_Voc = 470.6;
p5_Voc = -164.9;
p6_Voc = 29;
p7_Voc = 0.2083;

% p1_Voc =      -34.46;
% p2_Voc =       143.3;
% p3_Voc =      -225.6;
% p4_Voc =       173.6;
% p5_Voc =       -68.2;
% p6_Voc =       14.24;
% p7_Voc =      0.9932;


