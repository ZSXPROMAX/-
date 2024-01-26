clc;
clear;
A=[0 1 0 0;0 0 -1 0;0 0 0 1;0 0 22 0];
B=[0;1;0;-2];
C=[1 0 0 0];
n=size(A,1);
Qo=obsv(A,C);
Qc=ctrb(A,B);%能控性矩阵
rc=rank(Qc);
if rc==n
     disp('系统能控，可任意进行系统极点配置')
     P1=[-1,-2,-3,-4];
    K=-acker(A,B,P1)
end
if rank(Qo)==n
    disp('系统能观，可任意配置观测器系统极点')
    P2=[-1,-2,-3,-4];%观测器系统极点
    A1=A';
    B1=C';
    K=(acker(A1,B1,P2));
    G=K'
end
    