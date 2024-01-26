%%
clc;
clear;

Kp = 1;
K1 = 1;
J1 = 1;
Kb = 1;
J2 = 1;
Kn = 1;

G1 = tf(K1, [Kp, K1]);       % 传递函数分子为K1，分母为Kp*s + K1
G2 = tf([Kp, K1], [1,0]);        % 传递函数分子为Kp*s + K1，分母为1
G3 = tf(1, [J1,0]);          % 传递函数分子为1，分母为J1*s
G4 = tf(Kb, [J2, 0, 0]);     % 传递函数分子为Kb，分母为J2*s^2
G5 = tf(Kn,[1,0]);           % 传递函数分子为Kn，分母为s

sys1 = feedback(G3,G5,-1)   %G3和G5的负反馈
sys2 = series(G2,sys1)      %G2和sys1的串联
sys3 = feedback(sys2,1,-1)  
sys4 = series(G1,sys3)
sys5 = series(sys4,G4)
sys6 = feedback(sys5,1,-1)

num = sys6.num{1};               %提取sys6分子系数
den = sys6.den{1};               %提取sys6分母系数

[A1,B1,C1,D1]=tf2ss(num,den);    %输出系统状态空间模型

fprintf(' 系数矩阵A:\n');
disp(A1);

fprintf(' 输入矩阵B:\n');
disp(B1);

fprintf(' 输出矩阵C:\n');
disp(C1);


%%.m文件不能跟.slx文件同一个名字

