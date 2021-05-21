function eventRes = freqFunc(nodeID,freqData)

psi = [];


freqTimestamps = [];
freqValues = [];

startIndex = -2;

psi = freqData(1,:);



psiRed = psi{3};
psiFed = psi{4};


       if(~isempty(psiRed))
           if(psiRed(1)==-1)
                
               if(length(psiRed)>1)
                    startIndex = 2;
                   
                   
               end
           else
               startIndex = 1;
           end
           
       end

       if(startIndex ~= -2)
           for i = startIndex : (length(psiRed)-1)
           
               freqValues = [freqValues,1/(psiRed(i+1) - psiRed(i))];
               freqTimestamps = [freqTimestamps,psiRed(i)]; 
               
           end
           
       end
       
disp('Freq');
disp(freqValues);
disp(freqTimestamps);





eventRes = {nodeID,5,freqTimestamps,freqValues};

end