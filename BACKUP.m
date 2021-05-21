


fileID = fopen('D:\GoogleDrive\ASU\Research\TimeTesting\TTL\Tool\inputcode.txt');

st = fgetl(fileID);


parseTree = tree ;
curNode=1;
parseTree = parseTree.set(curNode, '@');

% newID = nnodes(parseTree);


for i = 1:(length(st)-1);
token = st(i:i);

% tokenExtr(st,i); 


n = nnodes(parseTree);
switch token
    case '('
     
         parseTree = parseTree.addnode(curNode, '@');
         curNode = nnodes(parseTree);
         case '{'
     
         parseTree = parseTree.addnode(curNode, '@');
         curNode = nnodes(parseTree);
         
    case {'U','G','E','L','S','C','F','P','B','D','>','<','=','i','^','!'}
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
        
        if (st(i+1:i+1)=='{')
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

end

disp(parseTree.tostring)