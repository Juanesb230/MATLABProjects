function [x,y,fi]=modelo(xo,yo,fio,uref,wref,Ts)    

iter = 50;
X = [xo;yo;fio];
for i=1:iter
        fx = [cos(fio) 0;sin(fio) 0;0 1];        
        X_p = fx*[uref;wref];
        X = X+X_p*Ts/iter;
        x = X(1); y = X(2); fi = X(3);
end;