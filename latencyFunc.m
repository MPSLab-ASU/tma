function eventRes = latencyFunc(nodeID,latencyData)


% finalRise=-2;
% finallFall=-2;

psi1 = [];
psi2 = [];

risingEdgs = [];
fallingEdgs = [];

% a = lower;
% b = upper;

psi1 = latencyData(1,:);
psi2 = latencyData(2,:);


psiRed1 = psi1{3};
psiRed2 = psi2{3};

sig1Event = -2;
sig2Event = -2;

if(~isempty(psiRed1)&&~isempty(psiRed2))
%     sig1Event = psiRed1(1);
%     sig2Event = psiRed2(1);
    
    if (psiRed1(1) == -1)
        if(size(psiRed1)>1)
             sig1Event = psiRed1(2);
        end
        
    else
        sig1Event = psiRed1(1);
      
    end
    
    if (psiRed2(1) == -1)
        if(size(psiRed1)>1)
             sig2Event = psiRed2(2);
        end
        
    else
        sig2Event = psiRed2(1);
      
    end
    
    if(sig1Event~=-2 && sig2Event ~= -2 )
    
        latency = sig2Event - sig1Event;

        risingEdgs = [risingEdgs,psiRed2(1)];
        fallingEdgs = [fallingEdgs,latency];

    end
    

disp('Latency');
disp(latency);
    
         
end
% tag = 5 is dedicated for latency

eventRes = {nodeID,5,risingEdgs,fallingEdgs};


end