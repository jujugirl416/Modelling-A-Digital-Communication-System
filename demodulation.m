function output = demodulation (inputdata, index)

%
%
M = 16;
%%  %% Demodulation
% Demodulate signal using 16-QAM.
zsym = qamdemod(inputdata,M);

output = zsym(1:index);

%% Match fileter

output = ML(output);

%% Stem Plot of demodulated signal
figure('Name','Output of Demodulator','NumberTitle','on'); 
stem(output(1:40),'filled');
title('Demodulated Signal');
xlabel('Bit indext'); ylabel('');


