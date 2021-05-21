function [tok,newPos] = tokenExtr(inpTok,pos)

switch inpTok(pos:pos)
    
    case {'(','{',')','}','/','\','>','<','!','=','^',',','D',';','|'}
        tok = inpTok(pos:pos);
        newPos = pos +1;
    case {'U','G','E','L','S','C','F','P','B','#'}
        if(inpTok(pos+1:pos+1)=='[')
            k = strfind(inpTok,']');
            i=1;
            while (i<=length(k) && (k(i)<(pos+1)) )
               i=i+1;    
            end    
           tok = inpTok(pos:k(i));
           newPos = k(i) +1;
           
        else  
            
            tok = inpTok(pos:pos);
            newPos = pos +1;
        end    
    case {'0','1','2','3','4','5','6','7','8','9','.','-','+'}
        i = pos;
%         curChar = inpTok(i:i);
        while(inpTok(i:i)~=',' && inpTok(i:i)~=')' && inpTok(i:i)~=';')
            
            i=i+1;
%             curChar = inpTok(i:i);
        end
      tok = inpTok(pos:i-1);
      newPos = i;
      case {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m','Q','W','R','T','Y','I','O','A','H','J','K','Z','X','V','N','M'}
          
          i = pos;
%         curChar = inpTok(i:i);
        while(inpTok(i:i)~='<' && inpTok(i:i)~='>' && inpTok(i:i)~=',')
               
            i=i+1;
         
        end
      tok = inpTok(pos:i-1);
      newPos = i;
      
    otherwise
end    


end