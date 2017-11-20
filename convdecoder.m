function output = convdecoder(inputdata,reg_num,reg_poly,trelen)

%
%

%% prompt
disp (' ');
disp (' -------------------------------- ');
disp ('     Conv Decoder is starting ....');
disp (' -------------------------------- ');
disp (' ');


%% Decoding

[x y] = size(inputdata);  % e.g. frame size = 1x200

% shape matrix
inputdata = reshape(inputdata',1,x*y)';
inputdata = -2*inputdata+1; % Transmit -1s and 1s.

% add noise
%inputdata = awgn(inputdata,8,'measured',1234); % Add noise.
inputdata = awgn(inputdata,5); % Add noise.

t = poly2trellis(reg_num,reg_poly); % Define trellis.
output_temp = vitdec(inputdata,t,trelen,'trunc','unquant', [1 1 0 1]); % Decode.


%% binary 2 Decimal
[c d] = size(output_temp);

output_temp = (reshape(output_temp',8,c*d/8))';  % shape the matrix
output = bi2de(output_temp);

% plot
%figure('Name','Output of Decoder (in Unit8)','NumberTitle','off'); 
%h = stem(output(1:100),'r'); set(h,'MarkerFaceColor','red'); 
%xlabel('Output Sequence');
%title('Decoding Output in Unit8');

disp (' Decoding Process has accomplished. ');
% end of function