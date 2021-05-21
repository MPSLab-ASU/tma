function eventRes = eventuallyFunc(nodeID,eventuallyData,lower,upper,startTime,stopTime )


finalRise=-2;
finalFall=-2;

psi = [];

risingEdgs = [];
fallingEdges = [];

a = lower;
b = upper;

psi = eventuallyData(1,:);

disp('E');
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
%     calculating new rising edge

if (b == 1 &&  risFlag == 1 && psiRed(i)==-1 )
        tempRise = -2;
    else
        tempRise = psiRed(i) - b;
    end
    
    if (tempRise >= startTime)
        finalRise = tempRise;
    else
        finalRise = -2;
    end
 
%     tempRise = psiRed(i)-b;
%     if (tempRise>=0)
%         finalRise=tempRise;
%     else
%         finalRise=0;
%     end

%     tempFall = psiFed(i)-a;
%     if (tempFall>=0)
%         finallFall=tempFall;
%     else
%         finallFall=0;
%     end
    
   if(falFlag == 1 && psiFed(i)==-1)
    if (a==1)
       tempFall = -2; 
    else
       tempFall = stopTime - a;
    end
   else
        tempFall = psiFed(i) - a;
   end
   
% Removeing incorrect timestamps

     if (tempRise >= startTime)
        finalRise = tempRise;
    else
        finalRise = -2;
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
    
    
% % % % % % % % % % % % % % % % % % % % % % % % % % %     
    
   if (size(fallingEdges)>0)
       if ((finalRise <= fallingEdges(length(fallingEdges))) || (fallingEdges(length(fallingEdges)) == -1))
           
           if((fallingEdges(length(fallingEdges))<finalFall) || (fallingEdges(length(fallingEdges)) == -1))
           
              fallingEdges(length(fallingEdges)) = finalFall;
           
           end
       else
               
         if((finalRise ~= -2 && finalRise < finalFall) || (finalRise ~= -2 && fallingEdges(length(fallingEdges))==-1))   
             risingEdgs = [risingEdgs,finalRise]; 
         end

         if((finalFall ~= -2 && finalRise<finalFall) || (finalRise ~= -2 && fallingEdges(length(fallingEdges))==-1))
             fallingEdges = [fallingEdges,finalFall]; 
         end
           
       end
   else
        if(finalRise ~= -2 && finalRise < finalFall)   
            risingEdgs = [risingEdgs,finalRise]; 
        
        elseif((finalRise == -2 && finalRise < finalFall))   
            risingEdgs = [risingEdgs,-1]; 
        end

        
         if((finalFall ~= -2 && finalRise < finalFall))
             fallingEdges = [fallingEdges,finalFall]; 
             
         elseif ((finalFall == -2 && finalRise > finalFall))
             fallingEdges = [fallingEdges,-1];
         end
       
       
   end    
      
    
    
    

 finalRise=-2;
 finalFall=-2;
 
end

eventRes = {nodeID,3,risingEdgs,fallingEdges};


end

