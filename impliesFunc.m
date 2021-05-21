function eventRes = impliesFunc(nodeID,implData,startTime,stopTime)
%IMPLIESFUNC Summary of this function goes here
%   Detailed explanation goes here


psi1 = [];
psi2 = [];

risingEdgs = [];
fallingEdges = [];


impCell = {[],[],[],[]};

psi1 = implData(1,:);
psi2 = implData(2,:);

% P implies Q = notP or (P and Q)
notP = notFunc(nodeID,psi1);
andPQ = andFunc(nodeID,implData,startTime,stopTime);

 impCell =  [notP;andPQ];
 

orRes = orFunc(nodeID,impCell,startTime,stopTime);
eventRes = {nodeID,3,orRes{3},orRes{4}};


end

