% function [parseTree,activeLeaves,startTime,stopTime]  = Parse (ttlFile,signalListFile,signalsValueFile)

function [parseTree,activeLeaves,startTime,stopTime]  = Parse (ttlStatement,signalListFile,signalsValueFile)

% ttlFileID = fopen(ttlFile);
% 
% ttlStatement = fgetl(ttlFileID);


% parseTree = null;
parseTree = tree ;
flag = 0;
% curNode=1;
% parseTree = parseTree.set(curNode, '@');

% newID = nnodes(parseTree);
oldI = 1;

while(oldI < length(ttlStatement))
% token = st(i:i);

% tokenExtr(st,i); 

[token,newI] = tokenExtr (ttlStatement,oldI) ;
    
%     disp(token);
    
% n = nnodes(parseTree);
% 
%  o = token(1);
switch token(1)
   
    case '('
        
if(flag==0)
% parseTree = tree ;
curNode=1;
parseTree = parseTree.set(curNode, '@');
flag = 1;
else
        
%      if(curNode>1)
         parseTree = parseTree.addnode(curNode, '@');
         curNode = nnodes(parseTree);
%      end
end   
         case '{'
     
         parseTree = parseTree.addnode(curNode, '@');
         curNode = nnodes(parseTree);
         
    case {'U','G','E','L','S','C','F','P','B','D','>','<','=','#','^','!','|'}
        m = get(parseTree, curNode);
        if (m=='@')
            parseTree = parseTree.set(curNode, token);
        else
            curNode = getparent(parseTree,curNode);
            while (get(parseTree,curNode)~='@')
                curNode = getparent(parseTree,curNode);
            end    
            parseTree = parseTree.set(curNode, token);
               
        end  
%     curNode=curNode+1;
    case ','
        
        if (ttlStatement(oldI+1:oldI+1)=='{')
         curNode = getparent(parseTree,curNode);   
         parseTree = parseTree.addnode(curNode, '@');  
         curNode = nnodes(parseTree);
        else
         curNode = getparent(parseTree,curNode);   
        end
%      curNode=curNode+1;
     case ')'
       
         curNode = getparent(parseTree,curNode);   
     case '}'
       
         curNode = getparent(parseTree,curNode);   
%          parseTree = parseTree.addnode(curNode, 'D');
         parseTree = parseTree.set(curNode, 'D');
         
    case '/'  
%          curNode = getparent(parseTree,curNode);  
         parseTree = parseTree.set(curNode, '>');
    case '\'  
%          curNode = getparent(parseTree,curNode);   
          parseTree = parseTree.set(curNode, '<');     
    otherwise
         parseTree = parseTree.addnode(curNode, token);  
         curNode = nnodes(parseTree);
         
end
oldI = newI;
% disp(parseTree.tostring);
end

leaves = findleaves(parseTree);
% disp(leaves);
[activeLeaves,startTime,stopTime] = readSignals(parseTree,leaves,signalListFile,signalsValueFile);

% x = activeLeaves{2,4};
% disp(x(21));

% disp(activeLeaves);


%  dispOneNode(activeLeaves);
disp(parseTree.tostring);
% disp(getsiblings(parseTree,7));

% test(parseTree);
end


