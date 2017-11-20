function demo_2()
%
%

close all;
clc;

%% Parameters Setup

% -- BCH Coding --
n = 255; 
k = 215; 
% -- Conv Coding --
reg_num = 7;
reg_poly = [171 133];
trelen = 100;    % decoding

% -- interleave ---
randnum = 4831;

% -- pulseShapper_filter definition --
nsamp = 4;       % Oversampling rate
filtorder = 40;  % Filter order
rolloff = 0.25;  % Rolloff factor of filter

% -- Channel Setting
S2N = 10;  % signal to noise ration in dB


%% read image

[source,map] = imread('logo.bmp');
[x y] = size (source);


%% Encoding

xenc = convencoder(source,reg_num,reg_poly);
%[xenc ci] = bchencoder(source,n,k);

%% interleaver

inter = randintrlv(xenc,randnum);

%% Modulation

[md mi] = modulation(inter);

%% pulse shapper

ps = pulseshapper(md,nsamp,filtorder,rolloff);

%% channel

%ynoisy = awgn(ps,S2N,'measured');
ynoisy = chn_awgn_burst(ps,S2N);

%% pulse reshapper

rps = pulsereshapper(ynoisy,nsamp,filtorder,rolloff);

%% demodulation

dm = demodulation(rps,mi);

%% deinterleaver
deinter = randdeintrlv(dm,randnum); % Deinterleave.

%% decoding

decode = convdecoder(deinter,reg_num,reg_poly,trelen);
%decode = bchdecoder(dm,ci,n,k);

% plot: compare the input (uint8) of encoder with output (Uint8) of decoder
figure('Name','Input of encoder Vs Output of Decoder (in Unit8)','NumberTitle','off'); 
h1 = stem(decode(1:100),'r'); set(h1,'MarkerFaceColor','red'); 
hold on;

[t1 t2] = size(source);
temp = reshape(source',t1*t2,1);
h2 = stem(temp(1:100),'b'); set(h2,'MarkerFaceColor','b');
xlabel('Frame Sequence');
title('Input of encoder Vs Output of Decoder (in Unit8)');


%% wirte image

recovered_source = reshape(decode',y,x)';
imwrite(uint8(recovered_source),map,'received_logo.bmp');

%% bit error calculation

% Compute BER without coding
[numErrors_Sym_no_code, bitError_Sym_no_code] = biterr(xenc,dm);
disp('bit error rate without error correction coding is: '), disp(bitError_Sym_no_code);

% Compute BER with coding
[numErrors_with_code,bitError_with_code] = biterr(double(source),recovered_source);
disp('bit error rate with error correction coding is: '), disp(bitError_with_code);


