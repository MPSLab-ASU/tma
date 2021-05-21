function eventRes = simFunc(nodeID,simData)

risingEdgs = [];
fallingEdgs = [];

eventsList = [];
% whether at least a signal is empty?
flag = 0;
% extracting Epsilon from the cell array

parameterNum = size(simData);

% The number of signals is 1 less than the parameters since the last
% parameter is Epsilon value

signalNum = parameterNum(1) - 1 ;

eps = str2double(simData (parameterNum(1),3));

% extracting the signals

signals = simData(1:end-1,:);

% the events to find the simulttaneity

events = signals (1:end,3);

eventsValues = events(:,1);

% disp('simFunc');
% disp(simData);
% disp(signals);
% disp('events');

for i = 1 : signalNum
    temp = events{i};
    disp(events{i});
    if(~isempty(temp))
         eventsList = [eventsList,temp(1)];
    else
        flag = 1;
    end
    
end
if (flag==0)
        minTs = min (eventsList);
        if (minTs == -1)
             m = sort (eventsList);
             minTs = m(2);
        end

        maxTs = max (eventsList);
        if (maxTs == -1)
            n = sort (eventsList);
            maxTs = m(2);
        end

if (minTs >=0 && maxTs >= 0)
    if(maxTs - minTs <= eps)
        risingEdgs = [risingEdgs,maxTs];
        fallingEdgs = [fallingEdgs, -1];
    end
    
end

end


disp(eventsList);
% disp(parameterNum(1));
disp(eps);

eventRes = {nodeID,5,risingEdgs,fallingEdgs};

end
