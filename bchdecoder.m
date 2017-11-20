function [output cnumerr] = bchdecoder (inputdata,flag_index,n,k)

%
% inputdata: marix with any dimention
% flag_idex: recover the original matrix

%% default value for BCH Decoding
%n = 15;
%k = 5;

%% prompt
disp (' ');
disp (' -------------------------------- ');
disp ('     Decoder is starting ....');
disp (' -------------------------------- ');
disp (' ');


%% Decoding

[x y] = size(inputdata);  % e.g. frame size = 1x200

inputdata = reshape(inputdata',n,x*y/n)';


%-------decode-----
[decoded,cnumerr] = bchdec(gf(inputdata), n, k);

[a b] = size(decoded);  % size of decoded matrix

decoded = reshape(decoded',a*b,1);

%keyboard;

%% recover the original matrix

output_temp = decoded(1:flag_index,1); % original matrix with binary format

%---------------------------------------------------------------------
[c d] = size(output_temp);
output_temp = (reshape(output_temp',8,c*d/8))';  % shape the matrix

output_temp = double(output_temp.x);
output = bi2de(output_temp);
%output = bi2de(fliplr(output_temp));

% plot
%figure('Name','Output of Decoder (in Unit8)','NumberTitle','off'); 
%h = stem(output(1:100),'r'); set(h,'MarkerFaceColor','red'); 
%xlabel('Output Sequence');
%title('Decoding Output in Unit8');

disp (' Decoding Process has accomplished. ');

%% end of function
%imMatrix_unit8 = uint8(imMatrix);    
    
    
    
    
    
    