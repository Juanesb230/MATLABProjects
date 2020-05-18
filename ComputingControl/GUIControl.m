w=0;
while w==0
clc
clear all
close all
%parametros
Ts = 0.1;% incremento del tiempo
t = 0:Ts:50; % tiempo de simulacion
%condciones iniciales
fprintf('Posicion inicial del robot\n');
x=input('Valor en x:');
y=input('Valor en y:');
fi=pi/2;
%variables auxiliares 
ex2 = 0;ex1 = 0;ex = 0;
ey2 = 0;ey1 = 0;ey = 0;fi1 = 0;
efi2 = 0;efi1 = 0;efi = 0;
uy = 0;uy1 = 0;ux = 0;ux1 = 0;ufi = 0;ufi1 = 0;

% kp = 0.8;kd = 0.003;ki = 4;
X = [x;y;fi];
clc
fprintf('Escoja la trayectoria que quiere qu siga el robot\n');
tray_escogida=input('1)Corazon 2)Ocho 3)Cuadrado 4)Circulo 5)Compuesto: ');

clc
fprintf('Escoja el tipo de controlador\n');
tipo_control=input('1)PD 2)PID de dos grados de libertad 3)SMC: ');
%constantes PID
clc
if tipo_control==1
fprintf('Ingrese los valores de las constantes del controlador PD\n');
kp=input('Valor de kp:');
kd=input('Valor de kd:');
% ki=input('Valor de ki:');
end

if tipo_control==2
fprintf('Ingrese los valores del PID\n');
kp=input('Valor de kp:');
kd=input('Valor de kd:');
ki=input('Valor de ki:');
fprintf('Ingrese los valores del PD\n');
kpd=input('Valor de Kpd: ');
kdd=input('Valor de Kdd: ');
end

if tipo_control==3
fprintf('Ingrese los valores de las constantes del controlador PD\n');
lamda0=input('Valor de &0:');
lamda1=input('Valor de &1:');
end
%elegir el correspondiente robot
clc
fprintf('Escoja el robot que quiere q haga la trayectoria\n');
robot=input('1)Avion 2)Cudricoptero: ');
fprintf('Escoja el color del robot\n');
color=input('1)Rojo 2)Azul 3)Magenta 4)Verde: ');

clc
fprintf('La posicion inicial del robot es: [%d,%d]\n',x,y);
if tray_escogida==1
    trayectoria='Corazon';
elseif tray_escogida==2
    trayectoria='Ocho';
elseif tray_escogida==3
    trayectoria='Cuadrado';
elseif tray_escogida==4
    trayectoria='Circulo';
else
    trayectoria='Compuesta';
end
fprintf('La trayectoria escogida fue: %s\n',trayectoria);
if tipo_control==1
    control='PD';
elseif tipo_control==2
    control='PID-D';
elseif tipo_control==3
    control='SMC';
end
fprintf('El controlador escogido fue: %s\n',control);
if tipo_control==1
    fprintf('las constantes del controlador PD fueron kp=%f kd=%f\n',kp,kd);
elseif tipo_control==2
    fprintf('las constantes del controlador PID fueron kp=%f kd=%f ki=%f y del PD kpd=%f kdd=%f\n',kp,kd,ki,kpd,kdd);
elseif tipo_control==3
    fprintf('las constantes del controlador SMC fueron &0=%f &1=%f\n',lamda0,lamda1);
end
if robot==1
    robot_tipo='Avion';
elseif robot==2
    robot_tipo='Cuadricoptero';
end
fprintf('El robot escogido fue: %s\n',robot_tipo);
if color==1
    co='r';
    col='Rojo';
elseif color==2
    co='b';
    col='Azul';
elseif color==3
    co='m';
    col='Magenta';
elseif color==4
    co='g';
    col='Verde';
end
fprintf('El color del robot es: %s\n',col);
for k=1:length(t)
%generacion de trayectorias    
    if tray_escogida==1
        cv = 2;
        xd = 12/2*sin(t(k)/(cv))-4/2*sin(3*t(k)/(cv)); %2*t(k);  
        yd = 13/2*cos(t(k)/(cv))-5/2*cos(2*t(k)/(cv))-2/2*cos(3*t(k)/(cv))-0.5*cos(4*t(k)/(cv));   
    elseif tray_escogida==2
        cv = 2;
        xd = 6*sin(t(k)/(0.5*cv))+0.5; %2*t(k);  
        yd = 6*cos(t(k)/(cv))+0.5;
    elseif tray_escogida==3
        if t(k)<=12
            xd=-6+t(k);
            yd=6;
        elseif t(k)<=24
            xd=6;
            yd=12-t(k)+6;
        elseif t(k)<=36
            xd=24+6-t(k);
            yd=-6;
        elseif t(k)<=48
            xd=-6;
            yd=-6+t(k)-36;
        end  
    elseif tray_escogida==4       
        cv = 2;
        xd = 6*sin(t(k)/(cv))+0.5; %2*t(k);  
        yd = 6*cos(t(k)/(cv))+0.5; 
    else
        if t(k)<= 8
            xd=-6+(t(k))/2;
            yd=2+4*sin(xd*pi);
        elseif t(k)<=16
            xd=-6+t(k)/2;
            yd=xd+4;
        elseif t(k)<=20
            xd=t(k)-14;
            yd=6;
        elseif t(k)<=24
            xd=6;
            yd=-t(k)+26;
        elseif t(k)<=28
            xd=-t(k)+30;
            yd=2;
        elseif t(k)<=32
            xd=2;
            yd=-t(k)+30;
        elseif t(k)<=36
            xd=t(k)-30;
            yd=-2;
        else
            t1=-1.05*(t(k)-50);
            xd=-1.538495349711068+6+(cos(t1)+t1/6*sin(t1));
            yd=-2.153028578286276-2+(sin(t1)-t1/6*cos(t1));
        end
    end

    %errores
    ex(k) = xd-x;
    ey(k) = yd-y;
    fid = atan2(ey(k),ex(k));
    %efi(k)=fid-fi;
    %controlador
    
    %posiciones
    x_po(k)=x;
    y_po(k)=y;
    ux1 = ux; uy1 = uy; ufi1 = ufi;
    %PD
    if tipo_control==1
        ux1 = ux; uy1 = uy; ufi1 = ufi;
        if k==1
        ux=ux1+ex(k)*((kp*Ts+kd)/Ts);
        uy=uy1+ey(k)*((kp*Ts+kd)/Ts);
        uref = 0;
        end

        if k>=2
        ux=ux1+ex(k)*((kp*Ts+kd)/Ts)-ex(k-1)*(kd/Ts);
        uy=uy1+ey(k)*((kp*Ts+kd)/Ts)-ey(k-1)*(kd/Ts);
        xp = (ux-ux1)/Ts;
        yp = (uy-uy1)/Ts;
        uref = (xp*xp+yp*yp)^0.5;
        end
    end
    
    %PID de dos grados de libertad
    if tipo_control==2
        ux1 = ux; uy1 = uy; ufi1 = ufi;
        if k==1
        ux = ux1+ex(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts));
        uy = uy1+ey(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts));
        ux3=((kpd*Ts+kdd)/Ts)*x_po(k);
        uy3=((kpd*Ts+kdd)/Ts)*y_po(k);
        ux=ux-ux3;
        uy=uy-uy3;
        uref = 0;
        end

        if k==2
        ux = ux1+ex(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ex(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts));
        uy = uy1+ey(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ey(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts));
        ux3=((kpd*Ts+kdd)/Ts)*x_po(k)-(kdd/Ts)*x_po(k-1);
        uy3=((kpd*Ts+kdd)/Ts)*y_po(k)-(kdd/Ts)*y_po(k-1);
        ux=ux-ux3;
        uy=uy-uy3;
        uref=0;
        end

        if k>=3
        ux = ux1+ex(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ex(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts)+ex(k-2)*kd/Ts);
        uy = uy1+ey(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ey(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts)+ey(k-2)*kd/Ts);
        ux3=((kpd*Ts+kdd)/Ts)*x_po(k)-(kdd/Ts)*x_po(k-1);
        uy3=((kpd*Ts+kdd)/Ts)*y_po(k)-(kdd/Ts)*y_po(k-1);
        ux=ux-ux3;
        uy=uy-uy3;
        xp = (ux-ux1)/Ts;
        yp = (uy-uy1)/Ts;
        uref = (xp*xp+yp*yp)^0.5;
        end
    end 
    
    if tipo_control==3
        ux1 = ux; uy1 = uy; ufi1 = ufi;
        kp=lamda1;
        ki=lamda0/lamda1;
        kd=-1/lamda1;
        KD=0.51*(lamda1/lamda0)^0.76;
        delta=0.68+0.12*KD*lamda1;
        
        if k==1
        ux = ux1+ex(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts));
        uy = uy1+ey(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts));
        ux=x_po(k)+lamda0*ex(k)/3+KD*sign(ux)/(abs(ux)+delta);
        uy=y_po(k)+lamda0*ey(k)/3+KD*sign(uy)/(abs(uy)+delta);
        uref=0;
        end
        
        if k==2
        ux = ux1+ex(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ex(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts));
        uy = uy1+ey(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ey(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts));
        ux=x_po(k)+lamda0*ex(k)/3+KD*sign(ux)/(abs(ux)+delta);
        uy=y_po(k)+lamda0*ey(k)/3+KD*sign(uy)/(abs(uy)+delta);
        uref=0;
        end
        
        if k>=3
        ux = ux1+ex(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ex(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts)+ex(k-2)*kd/Ts);
        uy = uy1+ey(k)*((2*kp*Ts+2*kd+ki*Ts*Ts)/(2*Ts))+ey(k-1)*((ki*Ts*Ts-2*kp*Ts-4*kd)/(2*Ts)+ey(k-2)*kd/Ts);
        ux=x_po(k)+lamda0*ex(k)/3+KD*sign(ux)/(abs(ux)+delta);
        uy=y_po(k)+lamda0*ey(k)/3+KD*sign(uy)/(abs(uy)+delta);
        xp = (ux-ux1)/Ts;
        yp = (uy-uy1)/Ts;
        uref = (xp*xp+yp*yp)^0.5;
        end
    end
    wref = (fid-fi)/Ts;
 
    %datos
    xdato(k) = x;
    ydato(k) = y;
    fidato(k) = fi;
    xddato(k) = xd;
    yddato(k) = yd;
    
    [x,y,fi] = modelo(x,y,fi,uref,wref,Ts);

end;

%**video sin obstaculo**
fig = figure();
% fig2=figure();
tkint = 2;%incremento de la simulacion
kk = 1;
for k = 1:tkint:length(t)
    if robot==1
     avion(xdato(k),ydato(k),fidato(k),0.3,co);
    elseif robot==2
     cuadricoptero(xdato(k),ydato(k),fidato(k),0.3,co);
    end
    plot(xdato(1:k),ydato(1:k),':k'); hold on; 
    plot(xdato(k),ydato(k),'ko');
    plot(xddato(1:k),yddato(1:k),':r');
    plot(xddato(k),yddato(k),'.r');
    hold off;
end

res=input('�Quiere volver a simular? (y/n): ','s');
    if res=='n'
        clc
        close all
        clear all
        w=1;
    else
        w=0;
    end
end
    