function [value,max,es,g] = GetInputs(method,flag,A,counter)
    value=[];g='';max=0;es=0;
    if(flag==0)
    if(strcmp(method,'NewtonRaphson')||strcmp(method, 'FixedPoint'))
         prompt = {'Enter the maximum no. of iterations ','Enter the Epsilon "es" :','Enter the initial value:'};
        dlgtitle = 'The NewtonRaphson Method';
        Janel=inputdlg(prompt,dlgtitle,[1 40]); 
        if(size(Janel)>0)
            if(strcmp(Janel(3), ''))
                 msgbox('initial value should be supplied');
                 return ;
             else
                 value(1) =str2double(char(Janel(3)));
                 if(isnan(value(1)))
                      msgbox('initial value should be only digits');
                      value=[];
                      return;
                 end
            end
        else
            return;
        end
    elseif(strcmp(method,'Bisection')||strcmp(method,'FalsePosition'))
         prompt = {'Enter the maximum no. of iterations ','Enter the Epsilon "es" :','Enter the lower bound:','Enter the upper bound:'};
        dlgtitle = 'The Bracket Method';
        Janel=inputdlg(prompt,dlgtitle,[1 40]);
        if(size(Janel)>0)
            if(strcmp(Janel(3), '')||strcmp(Janel(4), ''))
                 msgbox('Lower and Upper bounds should be supplied');
                 return ;
             else
                 value(1) = str2double(char(Janel(3)));
                  value(2)=str2double(char(Janel(4)));
                  if(isnan(value(1))||isnan(value(2)))
                      msgbox('Lower & upper values should be only digits');
                      value=[];
                      return;
                 end
            end 
        else
            return;
        end;
    else
        prompt = {'Enter the maximum no. of iterations ','Enter the Epsilon "es" :','Enter the XP:','Enter the XC:'};
        dlgtitle = 'The Secant Method';
        Janel=inputdlg(prompt,dlgtitle,[1 40]);
        if(size(Janel)>0)
            if(strcmp(Janel(3), '')||strcmp(Janel(4), ''))
                 msgbox('XP and XC bounds should be supplied');
                return ;
             else
                 value(1) =str2double(char(Janel(3)));
                  value(2)=str2double(char(Janel(4)));
                  if(isnan(value(1))||isnan(value(2)))
                      msgbox('XP & XC values should be only digits');
                      value=[];
                      return;
                 end
            end  
        else
            return;
        end
    end
     max=str2double(char(Janel(1)));
        es=str2double(char(Janel(2))); 
        if(strcmp(Janel(1), ''))
            max=50;
        end
        if(strcmp(Janel(2), ''))
            es=0.0001;
        end
        if(isnan(max)||isnan(es))
              msgbox('max iterations & es should be only digits');
              value=[];
              return;
        end
        
    else              %reading from file
        
        if(strcmp(method, 'FixedPoint')||strcmp(method,'NewtonRaphson'))
             if(strcmp(A(2), ''))
                 msgbox( 'initial value should be supplied');
                 return ;
             else
                 value(1) =str2double(char(A(2)));
                 if(isnan(value(1)))
                      msgbox('initial value should be only digits');
                      value=[];
                      return;
                 end
             end
        elseif(strcmp(method,'Bisection')||strcmp(method,'FalsePosition'))
            if(counter==5&&(strcmp(A(2), '')||strcmp(A(5), '')))
                 msgbox('Lower and Upper bounds should be supplied');
                 return ;
            elseif(counter==3&&(strcmp(A(2), '')||strcmp(A(3), '')))
                msgbox('Lower and Upper bounds should be supplied');
                return ;
             else
                 value(1) = str2double(char(A(2)));
                   if (counter==5)
                  value(2)=str2double(char(A(5)));
                 else
                     value(2)=str2double(char(A(3)));
                   end
                   if(isnan(value(1))||isnan(value(2)))
                      msgbox('Lower & upper values should be only digits');
                      value=[];
                      return;
                   end
            end 
         
        else
            if(counter==5&&(strcmp(A(2), '')||strcmp(A(5), '')))
                 msgbox('XP and XC bounds should be supplied');
                return ;
            elseif(counter==3&&(strcmp(A(2), '')||strcmp(A(3), '')))
                msgbox('XP and XC bounds should be supplied');
                return ;
             else
                 value(1) =str2double(char(A(2)));
                 if (counter==5)
                  value(2)=str2double(char(A(5)));
                 else
                     value(2)=str2double(char(A(3)));
                 end
                  if(isnan(value(1))||isnan(value(2)))
                      msgbox('XP & XC values should be only digits');
                      value=[];
                      return;
                 end
            end  
        end
        if(counter<=3)
            max=50;
             es=0.0001;
        else
            max=str2double(A(3));
        es=str2double(char(A(4))); 
        end
        if(isnan(max)||isnan(es))
              msgbox('max iterations & es should be only digits');
              value=[];
              return;
        end
    end
end
