function output = pulsereshapper (inputdata,nsamp,filtorder,rolloff)

%
%
%% Setup
% Define parameters.
%nsamp = 4; % Oversampling rate

%% Filter Definition
% Define filter-related parameters.
%filtorder = 40; % Filter order
delay = filtorder/(nsamp*2); % Group delay (# of input samples)
%rolloff = 0.25; % Rolloff factor of filter

% Create a square root raised cosine filter.
rrcfilter = rcosine(1,nsamp,'fir/sqrt',rolloff,delay);

% Plot impulse response.
%figure; impz(rrcfilter,1);

%% Received Signal
% Filter received signal using square root raised cosine filter.
output = rcosflt(inputdata,1,nsamp,'Fs/filter',rrcfilter);
output = downsample(output,nsamp); % Downsample.
output = output(2*delay+1:end-2*delay); % Account for delay.signal.

