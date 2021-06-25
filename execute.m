% execution of function
clc
clear

% lowpass Butterworth filter 
% 6-th order, nurmalized cutoff frequency 0.4
[b,a] = butter(6, 0.4);
transfer_function(b,a);
