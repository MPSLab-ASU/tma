function freqToTS(opID, theTree,samplingTime)
% disp("Freq")
% disp(opID);
    nodeParent = getparent(theTree,opID);
    operatorSubTree = theTree.subtree(nodeParent);
%     
    theNodes = nnodes(operatorSubTree);
    s = '';
    totalLStr = '';
    disp(operatorSubTree.tostring);
     
    for i=1:theNodes
        disp(i)
        disp(operatorSubTree.get(i));
    end
%         lStr =  operatorSubTree.get(12);
%       
%         
%         
%         l = str2double( lStr );
%         toleranceString = operatorSubTree.get(11);
%         toleranceValue  = str2double( toleranceString );
%         
%        
%         
%         if (operatorSubTree.get(1) == '<')
%             totalL = ((l - toleranceValue)/samplingTime) + 1;
%             totalLStr =  string(totalL);
%         end
%            
% %       
%          if (operatorSubTree.get(1) == '>')
%             totalL = ((l + toleranceValue)/samplingTime) - 1;
%             totalLStr =  string(totalL);
%            
%          end
%     
%         s = strcat('T','(',operatorSubTree.get(9),operatorSubTree.get(8),operatorSubTree.get(10),')','-'...
%             ,'T','(',operatorSubTree.get(5),operatorSubTree.get(4),operatorSubTree.get(6),')',operatorSubTree.get(1),totalLStr);
%         
%         fileID = fopen('convertedConstraints.txt','a');
%         fprintf(fileID,s);
%         fprintf(fileID,newline);
%         fclose(fileID);
   
    
end