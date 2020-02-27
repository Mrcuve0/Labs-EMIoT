load('gmonth.mat')

% sensor activation durantion 
air_time = 30; 
methane_time = 30; 
temp_time = 6; 
mic_time = 12; 
transmit_time = 24; 
mc_time = 6; 

% activation delay
% setting 1: parallel exec - 586229 sec
% air_delay = 0; 
% methane_delay = 0; 
% temp_delay = 0; 
% mic_delay = 0;
% mc_delay = 30; 
% transmit_delay = mc_delay + mc_time;

% setting 2: serial exec - 588361 sec
% air_delay = 0; % first to execute
% methane_delay = air_time; % second to execute
% temp_delay = methane_delay + methane_time; % third to execute
% mic_delay = temp_delay + temp_time; % fourth to execute
% mc_delay = mic_delay + mic_time; % fifth to execute
% transmit_delay = mc_delay + mc_time; % sixth to execute

% setting 3: 588360 sec
% air_delay = 0; % first to execute
% methane_delay = air_time; % second to execute
% temp_delay = air_time+mic_time; % third to execute
% mic_delay = air_time; % fourth to execute
% mc_delay = air_time + methane_time; % fifth to execute
% transmit_delay = mc_delay + mc_time; % sixth to execute

% setting 4: 588291 sec
methane_delay = 0; % first to execute
air_delay = methane_time; % second to execute
temp_delay = methane_time-mic_time-temp_time; % third to execute
mic_delay = methane_time-mic_time; % fourth to execute
mc_delay = air_time + air_time; % fifth to execute
transmit_delay = mc_delay + mc_time; % sixth to execute

% period
% setting 1: 120 (2 minutes)
% setting 2: 60*10 (10 minutes)
period = 60*2; 

% pulse width: % of period when sensor is active
air_pulse = (air_time * 100)/period; 
methane_pulse = (methane_time * 100)/period; 
temp_pulse = (temp_time *100)/period; 
mic_pulse = (mic_time * 100)/period; 
mc_pulse = (mc_time*100)/period; 
transmit_pulse = (transmit_time * 100)/period; 

% simulation length
% max simulation length = 1 month (30 days)
length = 30*24*60*60; 


