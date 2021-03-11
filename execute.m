% execution of function
clc
clear

[b,a] = cheby2(20, 0.2, 0.6);
transfer_function(b,a);
