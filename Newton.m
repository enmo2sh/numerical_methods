function [y,time,equ, diverge] = Newton(order, xp, yp, xreq)
    tic;
    prevError=100;
    no_of_Errors=0;
    diverge=0;
    digits(6)
    b = zeros();
    b(1) = yp(1);
    equ = 0;
    if order > 0 
        for i = 1 : order
            diff(i,1) = (yp(i) - yp(i+1)) / (xp(i) - xp(i+1));
        end
        for j = 2 : order
            for i = 1 : order+1 - j
                diff(i, j) = (diff(i+1, j-1) - diff(i, j-1))/(xp(i+j)-xp(i));
            end
        end
        for j = 2: order+1
            b(j) = diff(1, j-1);
        end
        y = b(1);
        syms x;
        equ = b(1);
        xm = 1;
        prevr = b(1);
        for k = 2 : order+1
            xm = xm * x - xm * xp(k-1);
            simplify(xm);
            equ = equ + b(k) * xm;
            currentr = subs(equ, xreq);
            e = abs ((currentr - prevr) / currentr) * 100;
            if(e>prevError)
               no_of_Errors= no_of_Errors+1;
           end
           if( no_of_Errors==5)
               diverge=1;
               break;
           end
           prevError=e;
           prevr = currentr;
        end  
    equ = vpa(simplify(equ));
 
    else
        equ = b(1);
    end
    y = subs(equ, xreq);
    time=toc;
end