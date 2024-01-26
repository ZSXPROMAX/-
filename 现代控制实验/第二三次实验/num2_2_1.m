close all;
clear all;
num1=[5];
den1=[1 1];
sys1=tf(num1,den1);
num2=[1];
den2=[1 2];
sys2=tf(num2,den2);
num3=[1];
den3=[1 0];
sys3=tf(num3,den3);
sys4=series(sys1,sys2);
sys5=series(sys4,sys3);
num4=[1];
den4=[1];
sys6=tf(num4,den4);
sys7=feedback(sys5,sys6,-1)

num=sys7.num{1};
den=sys7.den{1};
[A,B,C,D]=tf2ss(num,den)
fprintf('系数矩阵A: \n');
disp(A);
%YALMIP法
P=sdpvar(3,3,'symmetric');%P是3*3对称矩阵
Fcond=[P>0,A'*P+P*A<0];
ops=sdpsettings('verbose',0,'solver','sedumi');%verbose=0表示不显示详细信息，即静默模式;'solver','sedumi'指定了用于求解优化问题的求解器,SEDUMI是一种常用于求解半定规划问题的求解器。
diagnostics=solvesdp(Fcond,[],ops);%迭代求解
[m,p]=checkset(Fcond)%m即Fcond里的两个参数，都要大于0才稳定
tmin=min(m)
if tmin>0
    disp('系统稳定')
else
    disp('系统不稳定')
end
%直接法(或者用特征值全大于0也能判断正定)
Q=eye(size(A,1));
P=lyap(A,Q);
det1=det(P(1,1));
det2=det(P(1:2,1:2));
det3=det(P);
Det=[det1;det2;det3];
if min(Det)>0
    disp('系统稳定')
else
    disp('系统不稳定')
end
A_eig=eig(A)   %间接法
if all(real(A_eig)< 0)
    disp('系统稳定');
else
    disp('系统不稳定');
end
