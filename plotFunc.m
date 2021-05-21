function plotFunc(plottingData,startTime,stopTime,numberofOperators,plotNumber,pTree,operatorContent,currentOperator)

% disp('plotFunc');

tsa = (plottingData{3});
tfa = (plottingData{4});

risingTS = [];
fallingTS = [];

risingTS = plottingData{3};
fallingTS = plottingData{4};
% disp('rising');
% disp(risingTS);
% disp('falling');
% disp(fallingTS);
result = zeros(2, stopTime-startTime+1);
samplingTime = 1;
timeStep = startTime;


for i=1:(stopTime-startTime+1)
    result(1,i)= timeStep;
    timeStep = timeStep + samplingTime;
end
disp('plot');
% disp (plottingData{3});
% disp (plottingData{4});

for i = 1 : length(tsa)
    x = length (result);
    for j=1 : length (result)
    
        if((result(1,j) >= tsa(i) && result(1,j) < tfa(i))|| (result(1,j) >= tsa(i) && tfa(i) == -1) )
            result(2,j) = 1;
        end
        
    end
    

end
% preparing the captions for ">","<" operators. If the operator is one of
% theses two, its operands should be added to the caption.
if((operatorContent==">") || (operatorContent=="<"))
    childs = getchildren(pTree, currentOperator);
%     disp(operatorContent)
%     disp(childs);
    theCaption = strcat(operatorContent,get(pTree, childs(1,2)));
    theCaption = strcat(get(pTree, childs(1,1)), theCaption);
% disp(childs(1,1));

else
 theCaption = operatorContent;   
end


x=result(1,:);
y=result(2,:);

subplot(numberofOperators,1,plotNumber);
plot(x,y);
axis([startTime-1 stopTime+1 -.25 1.25]);
title(theCaption);

if(numberofOperators == plotNumber)
  xlabel('time(second)')  ;
end



end
