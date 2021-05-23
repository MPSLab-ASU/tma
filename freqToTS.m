function freqToTS(opID, theTree,samplingTime)
% disp("Freq")
% disp(opID);
    nodeParent = getparent(theTree,opID);
    operatorSubTree = theTree.subtree(nodeParent);
%     
    theNodes = nnodes(operatorSubTree);
    s = '';
    totalFStr = '';
    disp(operatorSubTree.tostring);
     
%     for i=1:theNodes
%         disp(i)
%         disp(operatorSubTree.get(i));
%     end
        fStr =  operatorSubTree.get(8);
%         
        f = str2double( fStr );
        toleranceString = operatorSubTree.get(7);
        toleranceValue  = str2double( toleranceString );
        
        if (operatorSubTree.get(1) == '<')
            totalF = (1/samplingTime*(f+toleranceValue)) + 1;
            totalFStr =  string(totalF);
        end
           
         if (operatorSubTree.get(1) == '>')
            totalF = (1/samplingTime*(f-toleranceValue)) - 1;
            totalFStr =  string(totalF);
           
         end
    
        s = strcat('T2','(',operatorSubTree.get(5),operatorSubTree.get(4),operatorSubTree.get(6),')','-'...
            ,'T1','(',operatorSubTree.get(5),operatorSubTree.get(4),operatorSubTree.get(6),')',operatorSubTree.get(1),totalFStr);
        
        fileID = fopen('convertedConstraints.txt','a');
        fprintf(fileID,s);
        fprintf(fileID,newline);
        fclose(fileID);
   
    
end