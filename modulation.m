function [output index] = modulation (inputdata)

%
%

%% Setup
% Define parameters.
M = 16; % Size of signal constellation

%% Matrix shapper
len = length(inputdata);

if mod(len,4)~=0
     
     pending = 4 - mod(len,4);
     
     inputdata(len+1:len+pending) = randint(pending,1);
     
else
    
    pending = 0;
     
end
 
index = len;

%% Modulation
% Modulate using 16-QAM.
output = qammod(inputdata,M);

%%Stem plot of Modulated singal upto 40bits
figure('Name','Output of Modulator','NumberTitle','on');
stem(output(1:40),'filled');
title('Modulated signal');
ylabel('Real part');