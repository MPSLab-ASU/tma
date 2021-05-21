function globRes = globallyFunc(nodeID,globData,lower,upper,startTime,stopTime )

finalRise=-2;
finalFall=-2;

psi = [];
risingEdgs = [];
fallingEdges = [];

a = lower;
b = upper;

psi = globData(1,:);

disp('G');
disp(psi{1,3});
disp(psi{1,4});

risFlag = 0;
falFlag = 0;
psiRed = psi{3};
psiFed = psi{4};

% if the signal starts with a falling edge
if (length(psiRed)>=1)
    if(psiRed(1)==-1)
        risFlag = 1;
    end
end

% if the signal stops with a rising edge
if (length(psiFed)>=1)
    if(psiFed(length(psiFed))==-1)
        falFlag = 1;
    end
end




for i=1 : min(length(psiRed),length(psiFed))
%     Calculating a new rising edge
    
    
    if ((a == 1 )&&  (risFlag == 1) && (psiRed(i) == -1) )
        tempRise = -2;
    else
        tempRise = psiRed(i)-a;
    end
    
    
    if (tempRise >= startTime)
        finalRise = tempRise;
    else
        finalRise = -2;
    end
    
%     calculating a new falling edge

    
    
    if(falFlag == 1 && psiFed(i)==-1)
        tempFall = stopTime - b;
    else
        tempFall = psiFed(i) - b;
    end
    
    if (tempFall >= startTime)
        finalFall = tempFall;
    else
        finalFall = -2;
    end
    
    
    
    if (tempRise<0 && tempFall<0)
        finalRise=-2;
        finalFall=-2;
    end
    
    if (tempRise==tempFall)
        finalRise=-2;
        finalFall=-2;
    end
 
    if(finalRise==-2 && (finalRise<finalFall && psiRed(i)==-1))   
         risingEdgs = [risingEdgs, psiRed(i)]; 
    end
    
 if(finalRise~=-2 && finalRise<finalFall)   
 risingEdgs = [risingEdgs,finalRise]; 
 end
 
 
 
 
 if(finalFall~=-2 && finalRise<finalFall)
 fallingEdges = [fallingEdges,finalFall]; 
 end
 
 finalRise=-2;
 finalFall=-2;
 
end

globRes = {nodeID,3,risingEdgs,fallingEdges};
end
