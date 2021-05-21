function eventRes = chroFunc(nodeID,chroData)

risingEdgs = [];
fallingEdgs = [];

eventsList = [];
% whether at least a signal is empty?
flag = 0;
% extracting Epsilon from the cell array

signalNum = size(chroData);

signals = chroData(1:end,:);
% disp('chroFunc');
% disp(chroData);
% disp(signals);
% disp('events');

% the events to find the simulttaneity

events = signals (1:end,3);

eventsValues = events(:,1);

% disp('eventsValues');
% disp(eventsValues);

for i = 1 : signalNum
    temp = events{i};
  
    if(~isempty(temp))
         eventsList = [eventsList,temp(1)];
    else
        flag = 1;
    end
    
end
if(flag==0)
  disp(eventsList);
  sortedEvents = sort(eventsList);
    if(sortedEvents == eventsList)
        risingEdgs = [risingEdgs,eventsList(length(eventsList))];
        fallingEdgs = [fallingEdgs, -1];
    end
    
end  
  
eventRes = {nodeID,5,risingEdgs,fallingEdgs};
end
