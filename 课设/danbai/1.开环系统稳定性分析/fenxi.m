clc;
clear;
A=[0 1 0 0;0 0 -1 0;0 0 0 1;0 0 22 0];
B=[0;1;0;-2];
C=[1 0 0 0];
n=size(A,1);
%%
%%%%%%%%%%%%%特征值法判断稳定性%%%%%%%%%%%%%%%%%%%%%%%%%
lembda=eig(A)
if real(lembda(1))<0 && real(lembda(2))<0 && real(lembda(3))<0&&real(lembda(4))<0
    str='特征值法：系统稳定'
else
    str='特征值法：系统不稳定'
end
%%
%给P，求Q
%    Q = eye(size(A,1));
%     P = lyap(A,Q);
%     det1 = det(P(1,1));
%     det2 = det(P(1:2,1:2));
%     det3 = det(P(1:3,1:3));
%     det4 = det(P);
%     Det = [det1;det2;det3;det4];
P1=eye(size(A,1));
Q=-P1*A-A'*P1;

det1=det(Q(1,1));
det2=det(Q(1:2,1:2));
det3=det(Q(1:3,1:3));
det4=det(Q);

Det=[det1;det2;det3;det4];

if min(Det)>0
    str='李雅普诺夫法（直接法）：系统稳定'
else 
    str='李雅普诺夫法（直接法）：系统不稳定'
end
%%
%%%%%%%%%%%%%线性不等式：P>0,A'*P+P*A<0%%%%%%%%%%%%%%%%%
P2=sdpvar(4,4,'symmetric');%给出待求矩阵
Fcond=[P2>=0,A'*P2+P2*A<=0];%列出所有待求LMI//有问题

ops=sdpsettings('verbose',0,'solver','sedumi');%设置求解环境
diagnostics=solvesdp(Fcond,[],ops);%迭代求解
[m,p]=checkset(Fcond);
tmin=min(m);

if tmin>0
    disp('线性矩阵不等式：系统稳定')%结论输出
else 
    disp('线性矩阵不等式：系统不稳定')%结论输出
end