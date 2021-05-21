function lessRes  = lessFunc(nodeID,lessData)



analogSgl = [];
timeArr = [];
tmpTs = [];
lessRes = [];
risingEdgs = [];
fallingEdges = [];
res = {};

sit = -1;

risIsEmpty = 0;
falIsEmpty = 0;


firstRow = lessData(1,:);
secondRow = lessData(2,:);


  if(firstRow{1} < secondRow{1})
        
        signalRow = lessData(1,:);
        valueRow = lessData(2,:);
    else
        signalRow = lessData(2,:);
        valueRow = lessData(1,:);
        
    end
    




thrshdVlu = valueRow{3};
thrshdVlu= str2double(thrshdVlu);



timeArr = signalRow{3};
analogSgl = signalRow{4};


if(signalRow{2}==2)
    timeArr = timeArr.';
    analogSgl = analogSgl.';
    
end


timStp = length(timeArr);
% disp(timStp);

if(~isempty(analogSgl))
    
    
% for i=1:timStp - 1
%     if (analogSgl(i)>=thrshdVlu && analogSgl(i+1)<thrshdVlu)
%         risingEdgs = [risingEdgs,timeArr(i)];
%         
%     end
%     if (analogSgl(i)<=thrshdVlu && analogSgl(i+1)>thrshdVlu)
%         fallingEdges = [fallingEdges,timeArr(i)];
%        
%     end
%  
% end

for i=1 : timStp
    if(i==1)
        if(analogSgl(i)<thrshdVlu)
            sit = 1;
        else 
            sit = 0;
        end
    else
         if(analogSgl(i)<thrshdVlu && sit == 0)
            risingEdgs = [risingEdgs,timeArr(i)]; 
            sit = 1;
         elseif(analogSgl(i)>thrshdVlu && sit == 1)
             fallingEdges = [fallingEdges,timeArr(i)];
             sit = 0;
         end
         
    end
    
end


if (isempty(risingEdgs))
    risIsEmpty = 1;
else 
    risIsEmpty = 0;
end

if(isempty(fallingEdges)) 
    falIsEmpty = 1;
else
    falIsEmpty = 0;
end

% If there is no edge and the signal is always greater than threshold
if (risIsEmpty == 1 && falIsEmpty == 1)
    if (analogSgl(1)<=thrshdVlu)
        risingEdgs = [-1,risingEdgs];
        fallingEdges = [fallingEdges,-1];
    else
   % If the signal is always less than threshold both rising and falling edegs reamin empty
    end
% Else if rising is not empty but falling is empty
elseif(risIsEmpty == 0 && falIsEmpty == 1)
% we add a vritual falling at the end of falling
    fallingEdges = [fallingEdges,-1];
% If rising is empty but falling is not empty, It means the signal remains
% 1 until stoptime.

elseif (risIsEmpty == 1 && falIsEmpty == 0)
% we should add a virtual rising 
    risingEdgs = [-1,risingEdgs];
% If none of them are empty 
else
%     
%     if(fallingEdges(1)<risingEdgs(1))
%          risingEdgs = [-1,risingEdgs];
%     end
%     if(fallingEdges(length(fallingEdges))<risingEdgs(length(risingEdgs)))
%          fallingEdges = [fallingEdges,-1];
%     end

if(~isempty(fallingEdges))
         if(fallingEdges(1)<risingEdgs(1))
             risingEdgs = [-1,risingEdgs];
         end
         
         if(fallingEdges(length(fallingEdges))<risingEdgs(length(risingEdgs)))
            fallingEdges = [fallingEdges,-1];
         end
        
    end
end


end


lessRes = {nodeID,3,risingEdgs,fallingEdges};



end