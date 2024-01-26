clc
clear
%绘制系统相应曲线
A=[0   1   0   1   1   0;
   1   0   0   0   0   0;
   0   1   0   0   0   0;
   0   0   1   0   0   0;
   0   0   0   1   0   0;
   0   0   0   0   1   0];
B=[2;0;0;0;0;0];C=[0 0 0 0.5 0.5 0];D=0;
%单位阶跃响应
step(A,B,C,D)
% 零状态响应
x0=[0;0;0;0;0;0];
t=0:0.01:10;
u=ones(1,size(t,6));
lsim(A,B,C,D,u,t,x0)
% %计算状态转移矩阵
% syms s t
% eAt1=expm(A*t)
% %绘制零输入响应
% x0=[1;1;1;1;1;1];
% Time=0:0.1:10;
% xTime=[];
% for t=Time
%     eAt1=expm(A*t);
%     xt=eAt1*x0;
%     xTime=[xTime xt];
% end
% plot(Time,xTime)
