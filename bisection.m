function [result,time,iter,xr,ea] = bisection(f,xl, xu, es, imax)
tic; result=zeros; time=0; iter=0; xr=0; ea=0;
  %thError=log10((xu-xl)*(1/es))/log10(2);
  %thError = ceil(thError);
  if (f(xl))*(f(xu))>0 % if guesses do not bracket, exit
      return
  end
  xro=0;
  if (ischar(imax))
  for i=1:1:str2num(imax)
        iter=i;
      result(i,1) = i;
      result(i,2) = xl;
      result(i,3) = xu;
     
      xr=(xu+xl)/2; % compute the midpoint xr
      result(i,4) = xr;
     
      ea = abs((xr-xro)/xr); % approx. relative error
      result(i,5) = ea;
      % f(xr)
      test= (f(xl)) * (f(xr)); % compute f(xl)*f(xr)
      if (test < 0) 
          xu=xr;
      else
          xl=xr;
      end
      if (test == 0) 
          ea=0;
      end
      if (ea < es) 
          break;
      end
      xro=xr;
  end
  else
      
   for i=1:1:imax
        iter=i;
      result(i,1) = i;
      result(i,2) = xl;
      result(i,3) = xu;
     
      xr=(xu+xl)/2; % compute the midpoint xr
      result(i,4) = xr;
     
      ea = abs((xr-xro)/xr); % approx. relative error
      result(i,5) = ea;
      % f(xr)
      test= (f(xl)) * (f(xr)); % compute f(xl)*f(xr)
      if (test < 0) 
          xu=xr;
      else
          xl=xr;
      end
      if (test == 0) 
          ea=0;
      end
      if (ea < es) 
          break;
      end
      xro=xr;
  end
  end
time=toc;
end