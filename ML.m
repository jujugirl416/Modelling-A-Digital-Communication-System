function output = ML (input)
%
% Maximun likelylood derminiation
% input: 1 coloum vector e.g. 100*1

ref = 1;

l = length(input);

for i = 1 : l
    
    if input(i) >= ref
        
        input(i) = 1;
    
    else 
        
        input(i) = 0;
        
    end
    
end

output = input;

% end of function