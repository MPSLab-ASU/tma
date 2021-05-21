function opRes  = callingFunc (parentID,operatorCnt,inputDat,startTime,stopTime,theTree,samplingTime)
% disp(operatorCnt);
sortedInput = sortrows(inputDat,1);
% disp(sortedInput);

switch operatorCnt(1,1)
    case '>'
%         disp('the operator is >');
        opRes = greaterFunc(parentID,sortedInput);
        
    case '<'
%         disp('the operator is <');
        opRes = lessFunc(parentID,sortedInput); 
        
    case '!'    
% %        disp('the operator is !');
        opRes = notFunc(parentID,sortedInput);
     
        
    case '|'
%         disp('the operator is ^');
    opRes = orFunc(parentID,sortedInput,startTime,stopTime); 
        
    case '^'
%         disp('the operator is ^');
        opRes = andFunc(parentID,sortedInput,startTime,stopTime);    

    case '#'
%         disp('the operator is implies');
        opRes = impliesFunc(parentID,sortedInput,startTime,stopTime);
        
    case 'G'
%         disp('the operator is G');
        [intLow,intUpp]= extractInterval(operatorCnt);
        
        opRes = globallyFunc(parentID,sortedInput,intLow,intUpp,startTime,stopTime);   
    case 'E'    
%         disp('the operator is E');
        [intLow,intUpp]= extractInterval(operatorCnt);

        opRes = eventuallyFunc(parentID,sortedInput,intLow,intUpp,startTime,stopTime);    

    case 'U'  
        [intLow,intUpp]= extractInterval(operatorCnt);
        opRes = untilFunc(parentID,sortedInput,intLow,intUpp,startTime,stopTime);
        
    case 'D'  
%         [intLow,intUpp]= extractInterval(operatorCnt);
        opRes = dFunc(parentID,sortedInput);   

        
    case 'L'  
%         [intLow,intUpp]= extractInterval(operatorCnt);
        opRes = latencyFunc(parentID,sortedInput);
        latencyToTS(parentID, theTree,samplingTime);
        
    case 'F'  
%         [intLow,intUpp]= extractInterval(operatorCnt);
        opRes = freqFunc(parentID,sortedInput);
        freqToTS (parentID,theTree,samplingTime);
    case 'P'  
%         [intLow,intUpp]= extractInterval(operatorCnt);
        opRes = phaseFunc(parentID,sortedInput);   
    case 'S'  
%         [intLow,intUpp]= extractInterval(operatorCnt);
        opRes = simFunc(parentID,sortedInput); 
    case 'C'  
%         [intLow,intUpp]= extractInterval(operatorCnt);
        opRes = chroFunc(parentID,sortedInput); 
        
end
%     plotFunc(opRes,startTime,stopTime);



end
