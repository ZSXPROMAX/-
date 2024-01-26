clc
clear
%%%%%%%%非线性系统线性化%%%%%%%%%%%%%%%%%%%
%非线性系统模型在feixianxing_3.slx文件中
x0=[0;0;1;0];
u0=[1];
[x,u,y,dx]=trim('feixianxing_3',x0,u0)
[A,B,C,D]=linmod('feixianxing_3',x,u)