function [result,time,numOfIter,xr,ea]=falsePosition(func,xl,xu,imax,es)
tic;  ea=0; time=0;
a=zeros; b=zeros; ya=zeros; yb=zeros;  result=zeros;e=zeros;
a(1)=xl; b(1)=xu; ya(1)=func(a(1));  yb(1)=func(b(1));
if (ya(1)*yb(1)>0)
    disp('Wrong bracket');
    return;
end
x=zeros;  y=zeros;
if (ischar(imax))
for i=1:str2num(imax)
    x(i)=((a(i)*yb(i))-(ya(i)*b(i)))/(yb(i)-ya(i));
    y(i)=func(x(i));
    if i>1
        e(i-1)=abs(x(i)-x(i-1));
    end
    if (y(i)==0.0)
        ea=abs(x(i)-x(i-1));
        disp('root found');
        break;
    elseif (y(i)*ya(i)<0)
        a(i+1)=a(i); ya(i+1)=ya(i);
        b(i+1)=x(i); yb(i+1)=y(i);
    else
        a(i+1)=x(i); ya(i+1)=y(i);
        b(i+1)=b(i); yb(i+1)=yb(i);
    end
    if((i>1) && (abs(x(i)-x(i-1))<es))
        ea=abs(x(i)-x(i-1));
        break;
    end
end

else
    for i=1:imax
    x(i)=((a(i)*yb(i))-(ya(i)*b(i)))/(yb(i)-ya(i));
    y(i)=func(x(i));
    if i>1
        e(i-1)=abs(x(i)-x(i-1));
    end
    if ((y(i)==0.0)&&(i>1))
        ea=abs(x(i)-x(i-1));
        disp('root found');
        break;
    elseif (y(i)*ya(i)<0)
        a(i+1)=a(i); ya(i+1)=ya(i);
        b(i+1)=x(i); yb(i+1)=y(i);
    else
        a(i+1)=x(i); ya(i+1)=y(i);
        b(i+1)=b(i); yb(i+1)=yb(i);
    end
    if((i>1) && (abs(x(i)-x(i-1))<es))
        ea=abs(x(i)-x(i-1));
        break;
    end
    end
end
numOfIter=i;
if(numOfIter>=imax)
    disp('root is not found');
else
    for j=1:length(x)
        xr=b(j);
        result(j,1)=j;
        result(j,2)=a(j);
        result(j,3)=b(j);
        result(j,4)=x(j);
        result(j,5)=y(j);
        if(j>1)
            result(j,6)=e(j-1);
        end
    end
end
time=toc;
end