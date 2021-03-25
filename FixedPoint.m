function [result,time,iter,xr,ea,diverge] = FixedPoint(x0,iter_max,es,g)
%FIXEDPOINT Summary of this function goes here
%   Detailed explanation goes here
    xr=x0; 
    iter=1;
    ea =0;
    result=[];
    diverge=0;
    time=0;
    tic;
    syms x;
    Dg(x)=diff(g(x));
    if(Dg(x0)>1)
        diverge=1;
        return;
    end
    while (iter<=iter_max)
        xr_old =xr;
        xr = double(g(xr_old)); % g(x) has to be supplied
        if (xr ~= 0)
            ea = abs((xr-xr_old) / xr) * 100;
        result(iter,1)=iter;
        result(iter,2)=double(xr);
        result(iter,3)=double(ea);
        if(ea<es)
            time=toc;
            return;
        end
        end
        iter=iter+1;
    end
time=toc;
end