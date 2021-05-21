function [lower,upper] = extractInterval( operator )

lowerBand=[];
upperBand=[];
lower = [];
upper = [];
% operator='G[2,10]';

if(size(operator,2)>1)
disp('extract')
disp(operator);
    i=3;
while(operator(i)~=',')    
    lowerBand=[lowerBand ,operator(i)];
    i=i+1;
end

i=i+1;

while(operator(i)~=']')    
    upperBand=[upperBand ,operator(i)];
    i=i+1;
end

% lower and upper should be multiplied by sampling time here to have a
% unique unit for all calculations.

lower = str2double(lowerBand);
upper = str2double(upperBand);
end

end

