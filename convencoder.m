function output = convencoder(inputdata,reg_num,reg_poly)

%
%

%% prompt
disp (' ');
disp (' -------------------------------- ');
disp ('     Conv Encoder is starting ....');
disp (' -------------------------------- ');
disp (' ');

%% decimai2binary conversion

[x y] = size(inputdata);  % e.g. any frame size 
inputdata = reshape(inputdata',1,x*y)';

inputBin = de2bi(inputdata,8);

% size of input binary Matrix
[x y] = size(inputBin);
s=x*y;

% shape to 1 column
inputBin = reshape(inputBin',s,1);

%% Conv Encoding
t = poly2trellis(reg_num,reg_poly); % Define trellis.
output = convenc(inputBin,t,[1 1 0 1]); % Length is (2*len)*2/3.

figure('Name','Output of Encoder (in binary)','NumberTitle','on'); 
h = stem(output(1:100)); set(h,'MarkerFaceColor','red'); 
xlabel('Output Sequence');
title('Encoding Output in Binary');

disp (' Incoding Process has accomplished. ');

% end of function
