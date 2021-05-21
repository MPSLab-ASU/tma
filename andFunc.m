function eventRes = andFunc(nodeID,orData,startTime,stopTime )

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
        psiFed2(length(psiFed2)) = stopTime +1 ;
    end
end

disp('and Func');


disp(psiRed1);
disp(psiFed1);

disp(psiRed2);
disp(psiFed2);


for i = 1 : length(psiRed1)
%     tempRise = psiRed(i)-b;

    for j = 1 : length(psiRed2)
% If we have overlap:

         if(((psiRed1(i)>=psiRed2(j)) && (psiRed1(i)<=psiFed2(j))) || ((psiFed1(i)>=psiRed2(j)) && (psiFed1(i)<=psiFed2(j)))|| ((psiRed2(j)>=psiRed1(i)) && (psiRed2(j)<=psiFed1(i)))|| ((psiFed2(j)>=psiRed1(i)) && (psiFed2(j)<=psiFed1(i))))
           
             
             if(isempty(risingEdgs))
                 risingEdgs =[risingEdgs,max(psiRed1(i),psiRed2(j))];
                 fallingEdgs =[fallingEdgs,min(psiFed1(i),psiFed2(j))];
                 
             else
                 if (max(psiRed1(i),psiRed2(j)) > risingEdgs(length(risingEdgs)))
                        risingEdgs =[risingEdgs,max(psiRed1(i),psiRed2(j))];
                 end
                 
                 if (min(psiFed1(i),psiFed2(j)) > fallingEdgs(length(fallingEdgs)))
                        
                     fallingEdgs =[fallingEdgs,min(psiFed1(i),psiFed2(j))];
                        
%                         
%                  elseif ((psiRed1(i)~=-1)||(psiRed2(j)~=-1))  
%                         fallingEdgs =[fallingEdgs,-1];
                 end
             
             end
             
              
         end
         
         
    
    end

end

if(~isempty(fallingEdgs))
    if(fallingEdgs(length(fallingEdgs)) == (stopTime + 1))
        fallingEdgs(length(fallingEdgs))= -1 ;
    end
end



eventRes = {nodeID,3,risingEdgs,fallingEdgs};

end