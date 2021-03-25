function [time,v,s] = LagrangeInterpolating(t,polynomialOrder,samplePoints,values)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic;
digits(5)
n=length(samplePoints);
z=0;
  for i=1:n
    if(t<samplePoints(i))
        z=i-1;
        break;
    end
  end
  MinIndex =0;
  MaxIndex =0;
  if(mod(polynomialOrder,2)==0)
      if((z-floor((polynomialOrder/2)))<=0)
          MinIndex=1;
          MaxIndex=z+floor((polynomialOrder/2))+((floor((polynomialOrder/2))-z)+1);
      elseif((z+floor((polynomialOrder/2)))>n)
           MinIndex =(z-floor((polynomialOrder/2)))-(floor((polynomialOrder/2))-(n-z));
           MaxIndex =n;  
             
      else
          MinIndex=z-floor((polynomialOrder/2));
          MaxIndex=z+floor((polynomialOrder/2));
      end
  else
      if((z-floor((polynomialOrder/2)))<=0)
          MinIndex=1;
          MaxIndex=z+(polynomialOrder-floor((polynomialOrder/2)))+((floor((polynomialOrder/2))-z)+1);
      elseif((z+(polynomialOrder-floor((polynomialOrder/2))))>n)
           MinIndex =(z-floor((polynomialOrder/2)))-((polynomialOrder-floor((polynomialOrder/2)))-(n-z));
           MaxIndex =n;  
             
      else
       MinIndex=z- floor((polynomialOrder/2));
       MaxIndex=z+(polynomialOrder-floor((polynomialOrder/2)));
      end
  end
  w=1;
  for i=MinIndex:MaxIndex
      X(w)=samplePoints(i);
      Y(w)=values(i);
      w=w+1;
  end
  syms x;
  s=0;
  v=0;
  for i=1: polynomialOrder+1
      l=1;
      r=1;
      for j=1: polynomialOrder+1
          if(j~=i)
              l=l*((x-X(j))/(X(i)-X(j)));
              r=r*((t-X(j))/(X(i)-X(j)));
          end
      end
      s=s+ Y(i)*l;
      v=v+ Y(i)*r;
  end
  s = vpa(simplify(s));
  time=toc;
  fprintf('%s',s);
end