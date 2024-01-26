
%建模部分作业一
clc
clear

Kb=input('Kb=');
J1=input('J1=');
Kp=input('Kp=');
K1=input('K1=');
Kn=input('Kn=');
J2=input('J2=');

num1=Kb;
den1=[J2,0,0];
num2=1;
den2=[J1,0];
num3=[Kp,K1];
den3=[1,0];
num4=K1;
den4=[Kp,K1];
num5=Kn;
den5=[1,0];

syslinshi=tf(num2,den2);

syslinshi1=tf(num5,den5);
sysf1=feedback(syslinshi,syslinshi1,-1);
syslinshi2=tf(num3,den3);
syslinshi3=syslinshi2*sysf1;
sysf2=feedback(syslinshi3,-1);
syslinshi4=tf(num4,den4);
syslinshi5=tf(num1,den1);
syslinshi6=syslinshi5*sysf2*syslinshi4;
systf=feedback(syslinshi6,-1)
sysss=ss(systf)
