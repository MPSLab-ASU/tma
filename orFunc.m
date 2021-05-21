function eventRes = orFunc(nodeID,orData,startTime,stopTime )

psi1 = [];
psi2 = [];
% psi = [];

risingEdgs = [];
fallingEdgs = [];

psi1 = orData(1,:);
psi2 = orData(2,:);

psiRed1 = psi1{3};
psiFed1 = psi1{4};
psiRed2 = psi2{3};
psiFed2 = psi2{4};

if(~isempty(psiFed1))
    if(psiFed1(length(psiFed1)) == -1)
        psiFed1(length(psiFed1)) = stopTime + 1 ;
    end
end

if(~isempty(psiFed2))
    if(psiFed2(length(psiFed2)) == -1)
        psiFed2(length(psiFed2)) = stopTime + 1  ;
    end
end

disp('or Func');


disp(psiRed1);
disp(psiFed1);

disp(psiRed2);
disp(psiFed2);


 i = 1;
 j = 1;
 
   while ((i <= length(psiRed1)) && (j <= length(psiRed2)))
%            If there is overlapping  
       if(((psiRed1(i)>=psiRed2(j)) && (psiRed1(i)<=psiFed2(j))) || ((psiFed1(i)>=psiRed2(j)) && (psiFed1(i)<=psiFed2(j)))|| ((psiRed2(j)>=psiRed1(i)) && (psiRed2(j)<=psiFed1(i)))|| ((psiFed2(j)>=psiRed1(i)) && (psiFed2(j)<=psiFed1(i))))
         if(isempty(risingEdgs))
                 risingEdgs =[risingEdgs,min(psiRed1(i),psiRed2(j))];
                 fallingEdgs =[fallingEdgs,max(psiFed1(i),psiFed2(j))];
                 
             else
                 if (min(psiRed1(i),psiRed2(j)) > risingEdgs(length(risingEdgs)))
                        risingEdgs =[risingEdgs,min(psiRed1(i),psiRed2(j))];
                 end
                 
                 if (max(psiFed1(i),psiFed2(j)) > fallingEdgs(length(fallingEdgs)))
                        
                     fallingEdgs =[fallingEdgs,max(psiFed1(i),psiFed2(j))];
                        
                 end
         end
%           there is an overlap and two pulses should be eliminated from
%           each signal

         i = i+1;
         j = j+1; 
       else
         
           if (psiRed1(i)<psiRed2(j))
               risingEdgs = [risingEdgs,psiRed1(i)];
               fallingEdgs = [fallingEdgs,psiFed1(i)];
               i = i+1;
           else
               risingEdgs = [risingEdgs,psiRed2(j)];
               fallingEdgs = [fallingEdgs,psiFed2(j)];
               j = j+1;
           end
           
           
       end
       
   end  
   
   if(i <= length(psiRed1))
       for k = i : length(psiRed1)
             risingEdgs = [risingEdgs,psiRed1(k)];
             fallingEdgs = [fallingEdgs,psiFed1(k)];  
       end
       
   end
   
   if(j <= length(psiRed2))
       for k = j : length(psiRed2)
             risingEdgs = [risingEdgs,psiRed2(k)];
             fallingEdgs = [fallingEdgs,psiFed2(k)];  
       end
       
   end

   
if(~isempty(fallingEdgs))
    if(fallingEdgs(length(fallingEdgs)) == (stopTime + 1))
        fallingEdgs(length(fallingEdgs)) = -1 ;
    end
end



eventRes = {nodeID,3,risingEdgs,fallingEdgs};

end