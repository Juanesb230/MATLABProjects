function [ robout1 ] = avion( x,y,phi,k,c )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

R = [cos(phi) -sin(phi);sin(phi) cos(phi)];
T = [x;y];
%% Avion
% Esta en el eje de coordenadas x0=0, y=0;
%%
% Cuerpo
a1=k*[1;2];
a2=k*[2;1];
a3=k*[2;-1];
a4=k*[1;-2];
a5=k*[-3;-2];
a6=k*[-4;-7];
a7=k*[-6;-7];
a8=k*[-7;-2];
a9=k*[-11;-2];
a10=k*[-12;-3];
a11=k*[-12;3];
a12=k*[-11;2];
a13=k*[-7;2];
a14=k*[-6;7];
a15=k*[-4;7];
a16=k*[-3;2];
% Parabrisas del avion
b1=k*[0;1];
b2=k*[-1;1];
b3=k*[-2;0];
b4=k*[-1;-1];
b5=k*[0;-1];
b6=k*[1;0];

%% Ejes rotados y trasladados
a1=(R*a1)+T;
a2=(R*a2)+T;
a3=(R*a3)+T;
a4=(R*a4)+T;
a5=(R*a5)+T;
a6=(R*a6)+T;
a7=(R*a7)+T;
a8=(R*a8)+T;
a9=(R*a9)+T;
a10=(R*a10)+T;
a11=(R*a11)+T;
a12=(R*a12)+T;
a13=(R*a13)+T;
a14=(R*a14)+T;
a15=(R*a15)+T;
a16=(R*a16)+T;

b1=(R*b1)+T;
b2=(R*b2)+T;
b3=(R*b3)+T;
b4=(R*b4)+T;
b5=(R*b5)+T;
b6=(R*b6)+T;

axis equal
%% Pintar9
xa=[a1(1) a2(1) a3(1) a4(1) a5(1) a6(1) a7(1) a8(1) a9(1) a10(1) a11(1) a12(1) a13(1) a14(1) a15(1) a16(1) a1(1)];
ya=[a1(2) a2(2) a3(2) a4(2) a5(2) a6(2) a7(2) a8(2) a9(2) a10(2) a11(2) a12(2) a13(2) a14(2) a15(2) a16(2) a1(2)];

xb=[b1(1) b2(1) b3(1) b4(1) b5(1) b6(1) b1(1)];
yb=[b1(2) b2(2) b3(2) b4(2) b5(2) b6(2) b1(2)];


h1=fill(xa,ya,c); hold on;
h2=fill(xb,yb,'c'); hold on;

robout1=[h1 h2];

