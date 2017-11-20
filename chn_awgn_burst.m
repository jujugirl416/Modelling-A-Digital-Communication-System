% Writes octect stream to file

function yNoisy = chn_awgn_burst(yTx, EsNo)

yNoisyAWGN = awgn(yTx,EsNo,'measured');

check=isreal(yNoisyAWGN);
if (check == 0)
yNoisyAWGNburst = yNoisyAWGN;
yNoisyAWGNburst(10:39) = [1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i 1 + 1i];
yNoisy = yNoisyAWGNburst;

else 
yNoisyAWGNburst = yNoisyAWGN;
yNoisyAWGNburst(10:39) = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ];
yNoisy = yNoisyAWGNburst;

end 
%end of function

