function notRes = notFunc(nodeID,notData)

psi = [];
risingEdgs = [];
fallingEdges = [];
temp = [];
psi = notData(1,:);

psiRed = psi{3};
psiFed = psi{4};

fallingEdges = psiRed;
risingEdgs = psiFed;

if(psiRed(1)==-1)
    fallingEdges = fallingEdges(2:end);
else
    risingEdgs = [-1,risingEdgs];
end

if(psiFed(length(psiFed))==-1)
    risingEdgs = risingEdgs(1:end-1);
else
    fallingEdges = [fallingEdges,-1];
end


notRes = {nodeID,3,risingEdgs,fallingEdges};

end

