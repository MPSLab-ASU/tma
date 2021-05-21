function eventRes = phaseFunc(nodeID,phaseData)

psi1 = [];
psi2 = [];

phaseTimestamps = [];
phaseValues = [];

phase = -2;
phaseTime = -2;

psi1 = phaseData(1,:);
psi2 = phaseData(2,:);
psi3 = phaseData(3,:);
psi4 = phaseData(4,:);


disp('phase');
disp(phaseData);



psiRed1 = psi1{3};
psiRed2 = psi2{3};

freqEps =1/( str2double(psi3{3}));
phaseEps = psi4{3};



sig1FirstIndx = -2;
sig2FirstIndx = -2;

if(~isempty(psiRed1) && ~isempty(psiRed2))
 
    if (psiRed1(1) == -1)
        if(length(psiRed1) > 2)
             sig1FirstIndx = 2;
        end
        
    elseif(length(psiRed1) >= 2)
        sig1FirstIndx = 1;
      
    end
    
    if (psiRed2(1) == -1)
        if(length(psiRed1) > 2)
             sig2FirstIndx = 2;
        end
        
    elseif(length(psiRed1) >= 2)
        sig2FirstIndx = 1;
      
    end
    
    if(sig1FirstIndx~=-2 && sig2FirstIndx~=-2)
%         the code to find the phase between two signals

i = sig1FirstIndx ;
j = sig2FirstIndx ;

 while(i <= (length(psiRed1)-1) && j <= (length(psiRed2)-1))
     curFreq1 = psiRed1(i+1) - psiRed1(i);
     curFreq2 = psiRed2(j+1) - psiRed2(j);
     
     if((curFreq2 > (curFreq1 - freqEps)) && (curFreq2 < (curFreq1 + freqEps)))
%      if t1 happens
         if(psiRed1(i) <= psiRed2(j))
             if(psiRed2(j)- psiRed1(i)<=curFreq1)
                 phase = psiRed2(j)- psiRed1(i);
                 phaseTime = psiRed1(i);
                 i = i + 1;
                 j = j + 1;
             else
                 i = i + 1;
             end
         else % if t2 happens sooner than t1
             if(psiRed1(i)- psiRed2(j)<=curFreq2)
                 phase = psiRed1(i)- psiRed2(j);
                 phaseTime = psiRed2(j);
                 i = i + 1;
                 j = j + 1;
             else
                 j = j + 1;
             end
             
         end
     else
         if(psiRed1(i) <= psiRed2(j))
            i = i + 1;
         else
             j = j + 1;
         end
         
     end
              
     
     if(phase~=-2)
         phaseTimestamps = [phaseTimestamps,phaseTime];
         phaseValues = [phaseValues,phase];
         
     end
     
     phase = -2;
     phaseTime = -2;
     
     
 end
 
        
    end
    
    disp('phase');
    disp(phaseTimestamps);
    disp(phaseValues);
 end   
    eventRes = {nodeID,5,phaseTimestamps,phaseValues};

end

