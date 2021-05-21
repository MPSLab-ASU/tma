function [activeLeaves,startTime,stopTime]  = readSignals (ttlTree, treeLeaves,signalListFile,signalsValueFile)
signalsListFileID = fopen(signalListFile);

signalList = strsplit(string(fgetl(signalsListFileID)));
% disp(signalList(4));

numbersCell = {[],[],[],[]};
% disp(size(numbersCell));





dim = size(treeLeaves,2);
% disp(dim);

signalValue = xlsread(signalsValueFile) ;

t = readtable(signalsValueFile);
[rows, columns] = size(t);

% disp('readSignal Func');
% disp(rows);
% disp(columns);
% disp(signalValue(1,:));

% timestamps in the signal file.
timeList = signalValue(:,1);
startTime = timeList(1);
stopTime = timeList(length(timeList));

% disp('readSignal Func');
% disp(rows);
% disp(columns);
% disp(timeList);


    for i= 1: dim
        
       
  nodeValue = get(ttlTree,treeLeaves(i));
  
  switch nodeValue(1)
       case {'0','1','2','3','4','5','6','7','8','9','.','-','+'}
       tag = 1;
       numbersCell =  [numbersCell;{treeLeaves(i),tag,nodeValue,-1}];
 
%        numbersCell={treeLeaves(i)}
%        tempNode = dlnode(treeLeaves(i),tag,nodeValue);
% 
%         xx = lastNode(activeLeaves);
% %         dispOneNode(xx);
%         
%       activeLeaves = insertAfter(tempNode,xx);
% %           displ(activeLeaves);
      case {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m','Q','W','R','T','Y','I','O','A','H','J','K','Z','X','V','N','M'}
       tag = 2;
       A = find(strcmp(nodeValue,signalList));
        numbersCell =  [numbersCell;{treeLeaves(i),tag,signalValue(:,1),signalValue(:,A)}];
%         signalValue(:,A)
%         plot(signalValue(:,A));
%        tempNode = dlnode(treeLeaves(i),tag,signalValue(:,1),signalValue(:,A));
% 
%        xx = lastNode(activeLeaves);
%       activeLeaves = insertAfter(tempNode,xx);
       
%       case {'U','G','E','L','S','C','F','P','B','#','^','<','>','='}
%        tag = 3;
%        
%        case 'D'
%        tag = 4;
      otherwise
          ;
  end
    


    end 
  
%    disp(numbersCell);

%  disp(numbersCell{2,3});
  

% numbersCell =  [numbersCell{1,:}];
% disp(numbersCell);
% x = signalsCell{:,1};
% disp (x);


numbersCell =  [numbersCell(2:end,:)];
  activeLeaves = numbersCell;

% fileID = fopen('D:\GoogleDrive\ASU\Research\TimeTesting\TTL\Tool\Signals.xlsx');


% 
% signalsFileID = fopen('D:\GoogleDrive\ASU\Research\TimeTesting\TTL\Tool\signals.txt');

% 
% 




% C = textscan(fileID,'%f %f %f %f');
% fclose(fileID);
% whos C
fclose('all');
    end





