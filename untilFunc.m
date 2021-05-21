function eventRes = untilFunc(nodeID,untilData,lower,upper,startTime,stopTime )

finalRise=-2;
finallFall=-2;

psi1 = [];
psi2 = [];
% psi = [];

risingEdgs = [];
fallingEdges = [];

a = lower;
b = upper;

if(untilData{1,1}<untilData{2,1})
    psi1 = untilData(1,:);
    psi2 = untilData(2,:);
else
    psi1 = untilData(2,:);
    psi2 = untilData(1,:);   

end


risFlag1 = 0;
falFlag1 = 0;


risFlag2 = 0;
falFlag2 = 0;


psiRed1 = psi1{3};
psiFed1 = psi1{4};
psiRed2 = psi2{3};
psiFed2 = psi2{4};


% if the signal1 starts with a falling edge
if (length(psiRed1)>=1)
    if(psiRed1(1)==-1)
        risFlag1 = 1;
    end
end

% if the signal1 stops with a rising edge
if (length(psiFed1)>=1)
    if(psiFed1(length(psiFed1))==-1)
        falFlag1 = 1;
    end
end

% if the signal1 starts with a falling edge
if (length(psiRed2)>=1)
    if(psiRed2(1)==-1)
        risFlag2 = 1;
    end
end

% if the signal1 stops with a rising edge
if (length(psiFed2)>=1)
    if(psiFed2(length(psiFed2))==-1)
        falFlag2 = 1;
    end
end


if(~isempty(psiFed1))
    if(psiFed1(length(psiFed1)) == -1)
        psiFed1(length(psiFed1)) = stopTime + 1  ;
    end
end

if(~isempty(psiFed2))
    if(psiFed2(length(psiFed2)) == -1)
        psiFed2(length(psiFed2)) = stopTime + 1 ;
    end
end



for i = 1 : length(psiRed1)
%     tempRise = psiRed(i)-b;

for j = 1 : length(psiRed2)
% If we have overlap:

%     if(((psiRed1(i)>=psiRed2(j))&&(psiFed2(j) == -1|| psiRed1(i)<=psiFed2(j))) || (((psiFed1(i)>=psiRed2(j)) || psiFed1(i)==-1) && (psiFed1(i)<=psiFed2(j))))
    if(((psiRed1(i)>=psiRed2(j)) && (psiRed1(i)<=psiFed2(j))) || ((psiFed1(i)>=psiRed2(j)) && (psiFed1(i)<=psiFed2(j)))|| ((psiRed2(j)>=psiRed1(i)) && (psiRed2(j)<=psiFed1(i)))|| ((psiFed2(j)>=psiRed1(i)) && (psiFed2(j)<=psiFed1(i))))
      
             
             tempRise = max (psiRed1(i), (psiRed2(j) - b));
             
             if((psiFed1(i) == (stopTime +1)) && (psiFed2(j) == (stopTime + 1)))
                 tempFall = stopTime - a;
            
             else
                 
                 tempFall = (min (psiFed1(i), psiFed2(j))) - a;
             
              end
        
              
        


             
%        if ( psiFed1(i) ~= -1 &&  psiFed2(j) ~= -1)    
%         
%         
%         
%         tempFall = (min (psiFed1(i), psiFed2(j))) - a;
%         
%        elseif(psiFed1(i) == -1 &&  psiFed2(j) ~= -1)
%            
% %            tempRise = max (psiRed1(i), (psiRed2(j) - b));
%            tempFall = (min (stopTime, psiFed2(j))) - a;
%            
%        elseif(psiFed1(i) ~= -1 && psiFed2(j) == -1)
%            
% %            tempRise = max (psiRed1(i), (psiRed2(j) - b));
%            tempFall = (min (psiFed1(i), stopTime)) - a;    
%        
%        elseif(psiFed1(i) == -1 && psiFed2(j) == -1 )
%            
% %            tempRise = max (psiRed1(i), (psiRed2(j) - b));
%            tempFall = stopTime - a;    
%                
%       
%        end

%  Removing wrong timestamps   
    
    if (tempRise >= startTime)
        finalRise = tempRise;
    else
        finalRise = -2;
    end
    
    

    
    
    if (tempFall >= startTime)
        finallFall = tempFall;
    else
        finallFall = -2;
    end

    
    if (tempRise<0 && tempFall<0)
        finalRise = -2;
        finallFall = -2;
    end
    
    
    if (tempRise == tempFall)
        finalRise = -2;
        finallFall = -2;
    end
    
    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
    
%    if (size(fallingEdges)>0)
%        if(finalRise<=fallingEdges(length(fallingEdges)))
%            if((fallingEdges(length(fallingEdges))<finallFall))
%            
%            fallingEdges(length(fallingEdges)) = finallFall;
%            
%            end
%        else
%                
%          if(finalRise~=-1 && finalRise<finallFall)   
%          risingEdgs = [risingEdgs,finalRise]; 
%          end
% 
%          if(finallFall~=-1 && finalRise<finallFall)
%          fallingEdges = [fallingEdges,finallFall]; 
%          end
%            
%        end
%    else
%         if(finalRise~=-1 && finalRise<finallFall)   
%          risingEdgs = [risingEdgs,finalRise]; 
%         end
%          
% 
%          if(finallFall~=-1 && finalRise<finallFall)
%              fallingEdges = [fallingEdges,finallFall]; 
%          end
%        
%        
%    end    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       
    
if (size(fallingEdges)>0)
       if ((finalRise <= fallingEdges(length(fallingEdges))) || (fallingEdges(length(fallingEdges)) == -1))
           
           if((fallingEdges(length(fallingEdges))<finallFall) || (fallingEdges(length(fallingEdges)) == -1))
           
              fallingEdges(length(fallingEdges)) = finallFall;
           
           end
       else
               
         if((finalRise ~= -2 && finalRise < finallFall) || (finalRise ~= -2 && fallingEdges(length(fallingEdges))==-1))   
             risingEdgs = [risingEdgs,finalRise]; 
         end

         if((finallFall ~= -2 && finalRise<finallFall) || (finalRise ~= -2 && fallingEdges(length(fallingEdges))==-1))
             fallingEdges = [fallingEdges,finallFall]; 
         end
           
       end
   else
        if(finalRise ~= -2 && finalRise < finallFall)   
            risingEdgs = [risingEdgs,finalRise]; 
        
        elseif((finalRise == -2 && finalRise < finallFall))   
            risingEdgs = [risingEdgs,-1]; 
        end

        
         if((finallFall ~= -2 && finalRise < finallFall))
             fallingEdges = [fallingEdges,finallFall]; 
             
         elseif ((finallFall == -2 && finalRise > finallFall))
             fallingEdges = [fallingEdges,-1];
         end
       
       
   end    
      
 finalRise=-1;
 finallFall=-1;
    end
 
 
end
end

if(~isempty(psiFed1))
             if(psiFed1(length(psiFed1)) == (stopTime + 1))
                 psiFed1(length(psiFed1)) = -1;
             end
    
        end


        if(~isempty(psiFed2))
          if(psiFed2(length(psiFed2)) == (stopTime + 1))
               psiFed2(length(psiFed2)) = -1 ;
          end
        end
eventRes = {nodeID,3,risingEdgs,fallingEdges};


end

