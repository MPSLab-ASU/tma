function eventRes = dFunc(nodeID,eventuallyData)


% finalRise=-2;
% finallFall=-2;

psi = [];

risingEdgs = [];
fallingEdges = [];

% a = lower;
% b = upper;

psi = eventuallyData(1,:);

psiRed = psi{3};
psiFed = psi{4};
% disp('dFunc');
% disp(psiRed);


for i=1 : min(length(psiRed),length(psiFed))
%     calculating new rising edge


        if (psiRed(i)~=-1)
                finalRise = psiRed(i);
                risingEdgs = [risingEdgs,finalRise];
                fallingEdges = [fallingEdges,finalRise+1];
      
        end
  
end

eventRes = {nodeID,4,risingEdgs,fallingEdges};
disp('dFunc');
disp(risingEdgs);
disp(fallingEdges);

end