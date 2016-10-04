clear all;close all;clc

% pos=15:10:150+15;
% vel=10:19:295;
% Cd=0:5:20;
% Gd=0:20:200;
% Gs=0:20:200;
%
pos=-75:50:75;
vel=10:40:290;
Cd=0:5:20;
Gd=0:40:200;
Gs=0:40:200;

total_trial_numbers=length(pos)*length(vel)*length(Cd)*length(Gd)*length(Gs)
realizations=2;
total_trial_time=total_trial_numbers*3*realizations/60


