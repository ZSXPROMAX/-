clc;
clear;
A1=[0 1 0 0;0 0 -1 0;0 0 0 1;0 0 22 0];
B1=[0;1;0;-2];
C1=[1 0 0 0];
n=5;
A=[[A1,[0;0;0;0]];[-C1,0]];
B=[B1;0];
C=[C1,0];
%%%%%%%%%%%%%%%%状态反馈极点配置%%%%%%%%%%%%%%%%%%%%%
Qc=ctrb(A,B);%能控性矩阵
rc=rank(Qc);
if rc==n
     disp('系统能控，可任意进行系统极点配置')
     %设计超调量为20%，调节时间为5s
    syms k wn;%计算阻尼比和频率
    k=solve(exp(-pi*k/sqrt(1-k^2))==0.2,k)
    k=double(k);
    e=max(k)
    wn=solve(3.5/(e*wn)==5,wn);
    wn=double(wn)
    [z,p,k]=tf2zp([1],[1/(wn*wn) 2*max(k)/wn 1]);
    sys1=zpk(z,p,k/wn);
    p%主导极点
    P1=[-10,-10,-10, p(1) ,p(2)];
    K=acker(A,B,P1) 
end
K1=[K(1),K(2),K(3),K(4)];
K2=-K(5);
A2=[[A1-B1*K1,B1*K2];[-C1,0]];
B2=[0;0;0;0;1];
C2=C;
s2=ss(A2,B2,C2,0);
[z,p,k]=ss2zp(A2,B2,C2,0);
G=zpk(z,p,k)
%%%%%画出校正后高阶系统的值%%%%%%%%%
t = 0:0.1:30;
y = step(G, t);
plot(t, y);
C=dcgain(G);%终值
[y,t]=step(G);
[Y,k]=max(y);%取得最大峰值
disp('超调量：')
c=(Y-C)/C%超调量
timeopeak=t(k); %取得最大峰值时间
i=length(t);%从终值开始往前检索
while (y(i)>0.98*C)&(y(i)<1.02*C)
i=i-1;
end
disp('调节时间：')
settingtime=t(i)%计算调节时间（0.02）




