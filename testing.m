function testing(signalAddress,signalListAddress,timingContstraintContent,samplingTime)
disp('testing func');
disp(signalAddress);
disp(timingContstraintContent);

close all
thetime = [];
% ttlFileAddress = 'D:\GoogleDrive\ASU\Research\TimeTesting\TTL\Tool\inputcode1.txt';
% signalListFileAddress = 'D:\GoogleDrive\ASU\Research\TimeTesting\TTL\Tool\signalList.txt';
% signalValueFileAddress = 'D:\GoogleDrive\ASU\Research\TimeTesting\TTL\Tool\Signals.xlsx';

signalListFileAddress = signalListAddress;
signalValueFileAddress = signalAddress;




% [pTree,signalTstamps,startTime,stopTime] = Parse(ttlFileAddress,signalListFileAddress,signalValueFileAddress);

[pTree,signalTstamps,startTime,stopTime] = Parse(timingContstraintContent,signalListFileAddress,signalValueFileAddress);

% How many leaves exist 
signalTstmpBckUp = signalTstamps; 
aliveRows = size(signalTstamps);
aliveNodes = aliveRows(1);


% calculation of the number of nodes 
pTreeNodes = nnodes(pTree);
% getting the number of alive nodes at first to plot all signals properly
firstAliveNodes = aliveNodes;
% Calculating the number of operator nodes.
numberofOperators = pTreeNodes - aliveNodes;



allTimestamps = signalTstamps(:,1);

% The number of plots. At least we should plot one plot and based on number
% of nodes, it is increamented.
plotNum = 1;
% disp(signalTstamps{1,3});
% disp(signalTstamps{1,4});
% disp(signalTstamps{2,3});
% disp(signalTstamps{2,4});

while(allTimestamps{1,1}~=1)

% disp('The First row');
tempRow = signalTstamps(1,:);
currentNodeSiblings = getsiblings(pTree,allTimestamps{1,1});
n = (size(currentNodeSiblings,2));

siblingsIndices = zeros(1,size(currentNodeSiblings,2));

for i=1:size(currentNodeSiblings,2)
   aSibling = currentNodeSiblings(1,i);

   for j=1:size(allTimestamps,1)
        if (aSibling==allTimestamps{j})
            siblingsIndices(i)=j;
        end
   end
   
end
   
if(size(find(siblingsIndices==0),2)== 0)

   currentOperator = getparent(pTree, currentNodeSiblings(1,1));
   operatorContent = get(pTree, currentOperator);
   
   operatorInput=[];
   for i=1:size(siblingsIndices,2)
   operatorInput = [operatorInput;signalTstamps(siblingsIndices(1,i),:)];
   end

   signalTstamps = removerows(signalTstamps,siblingsIndices);

   calculatedTs = callingFunc(currentOperator,operatorContent,operatorInput,startTime,stopTime,pTree,samplingTime);


   
   plotFunc(calculatedTs,startTime,stopTime,numberofOperators,plotNum,pTree,operatorContent,currentOperator);
   plotNum = plotNum + 1;
 
    
   signalTstamps = [signalTstamps;calculatedTs];
  

   else
%        disp('NO');%remove the first row form signalTstamps and add it to its tail  
    signalTstamps = removerows(signalTstamps,1);
    signalTstamps = [signalTstamps;tempRow];
       
end
       aliveRows = size(signalTstamps);
       aliveNodes = aliveRows(1);
       allTimestamps = signalTstamps(:,1);
       
%        preparing the plot for drawing the next one

    
           
end
%%%%%%%%%%%%%%%%%%%%%%%%
% xx=[ones(1,signalTstamps{4}(1)-signalTstamps{3}(1)) zeros(1,signalTstamps{3}(2)-signalTstamps{4}(1)) ones(1,signalTstamps{4}(2)-signalTstamps{3}(2))]
% figure
% plot(xx,'-*')
% axis([0 length(xx) -1 2])
%%%%%%%%%%%%%%%%%%%%%%%
disp('Final Timestamps');

disp(signalTstamps{3});
disp(signalTstamps{4});

end
