clc;
clear;
A=[0 1 0 0;0 0 -1 0;0 0 0 1;0 0 22 0];
B=[0;1;0;-2];
C=[1 0 0 0];
n=4;
Qc=ctrb(A,B);%能控性矩阵
rc=rank(Qc);
if rc==n
     disp('系统能控，可任意进行系统极点配置')
     P1=[-1,-2,-3,-4];
    K=-acker(A,B,P1)
end
