function [output flag_index] = bchencoder (inputdata,n,k)
%
%  input: matrix with byte matrix; it is should be a n x 1 array
%  flag: index for binary marix only !

%% default value for BCH Coding
 % n = 15;
 % k = 5;


%% prompt
disp (' ');
disp (' -------------------------------- ');
disp ('     Encoder is starting ....');
disp (' -------------------------------- ');
disp (' ');

%usercmd = input('if u want to change press Y, otherwise press Anykey ', 's');
%TF = strcmpi(usercmd, 'y');

%if TF == 1
%    
%    n = input(' Please input the value of n:  ');
%    k = input(' Please input the value of k:  ');
   
%end

%% decimai2binary conversion

[x y] = size(inputdata);  % e.g. any frame size
inputdata = reshape(inputdata',1,x*y)';

inputBin = de2bi(inputdata,8);

% size of input binary Matrix
[x y] = size(inputBin);
t=x*y;

% shape to 1 column
inputBin = reshape(inputBin',t,1);

%keyboard;

%% flag index
flag_index = t;

% decide how many block will be encode & how many pending is needed
if t > k
   
   if  mod(t,k)~= 0
       pending = k - mod (t,k);
   else
       pending = 0;
   end 

else
    pending = k - x;
end

%% add pending

inputBin(t+1:t+pending,1) = randint(pending,1);


%% encode
%keyboard;

inputBin2 = (reshape(inputBin,k,(t+pending)/k))';

%keyboard;

output_gf = bchenc(gf(inputBin2),n,k);

output = double(output_gf.x);

[t1 t2] = size(output);
output = reshape(output',t1*t2,1);

figure('Name','Output of Encoder (in binary)','NumberTitle','on'); 
h = stem(output(1:100)); set(h,'MarkerFaceColor','red'); 
xlabel('Output Sequence');
title('Encoding Output in Binary');

disp (' Incoding Process has accomplished. ');

%% end of function








