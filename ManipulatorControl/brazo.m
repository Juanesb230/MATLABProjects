function [ manipulador ] = brazo( q0,q1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x00=0;
y00=0;
x01=0.445*cos(q0);
y01=0.445*sin(q0);
x02=0.445*cos(q0)+0.355*cos(q1+q0);
y02=0.445*sin(q0)+0.355*sin(q1+q0);

a1=[x00+0.1*cos(pi/2-q0);y00-0.1*sin(pi/2-q0)];
a2=[x01+0.1*cos(pi/2-q0);y01-0.1*sin(pi/2-q0)];
a3=[x01-0.1*cos(pi/2-q0);y01+0.1*sin(pi/2-q0)];
a4=[x00-0.1*cos(pi/2-q0);y00+0.1*sin(pi/2-q0)];

a11=[x01+0.1*cos(pi/2-(q0+q1));y01-0.1*sin(pi/2-(q0+q1))];
a21=[x02+0.1*cos(pi/2-(q0+q1));y02-0.1*sin(pi/2-(q0+q1))];
a31=[x02-0.1*cos(pi/2-(q0+q1));y02+0.1*sin(pi/2-(q0+q1))];
a41=[x01-0.1*cos(pi/2-(q0+q1));y01+0.1*sin(pi/2-(q0+q1))];
axis equal
xa=[a1(1) a2(1) a3(1) a4(1) a1(1)]; 
ya=[a1(2) a2(2) a3(2) a4(2) a1(2)];

xa1=[a11(1) a21(1) a31(1) a41(1) a11(1)]; 
ya1=[a11(2) a21(2) a31(2) a41(2) a11(2)];
h1=fill(xa,ya,'b'); hold on;
h2=fill(xa1,ya1,'c'); hold on;
manipulador=[h1,h2];

