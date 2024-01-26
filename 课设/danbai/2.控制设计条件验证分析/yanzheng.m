clc;
clear;
A=[0 1 0 0;0 0 -1 0;0 0 0 1;0 0 22 0];
B=[0;1;0;-2];
C=[1 0 0 0];
D=0;
n=size(A,1);
%%%%%%%%%%基于传递函数模型分析稳定性%%%%%%%%%%%
%极点分布
[num,den]=ss2tf(A,B,C,D);
sys=tf(num,den);
figure(1);
pzmap(sys);
title('零极点图');
%nyquist
figure(2);
nyquist(num,den);
grid on;
title('nyquist');
%bode
figure(3)
bode(num,den)
title('bode')
[Gm,Pm,Wcg,Wcp]=margin(num,den)
%根轨迹
figure(4)
rlocus(num,den);
title('根轨迹')
%%%%%%%%%%基于传递函数模型分析性能%%%%%%%%%%%
disp('基于传递函数模型分析性能')
figure(2);
margin(sys);grid on;
[Gm,Pm,Wcg,Wcp]=margin(sys);
magdb=20*log10(Gm);
fprintf('可知幅值裕度为%d,穿越频率为%d,相角裕度为%d,截止频率为%d\n',magdb,Wcg,Pm,Wcp)
%%%%%%%%%%%基于状态空间模型分析系统稳定性%%%%%%%%%%%
%特征值法/李雅普诺夫第一法
eig(A)
%李雅普诺夫第二法
if det(A)==0
'系统不稳定'
else
Q=eye(size(A,1))
P=lyap(A,Q)
det1=det(P(1,1));
det2=det(P(1:2,1:2));
det3=det(P(1:3,1:3));
det4=det(P);
Det=[det1;det2;det3;det4];
if min(Det)>0
'系统稳定'
else
'系统不稳定'
end
end
%%%%%%%%%%分析系统的能观性和能控性%%%%%%%%%
Qc=ctrb(A,B);
rc=rank(Qc);
L=size(A);
if rc==L
    str='系统能控'
else
    str='系统不完全能控'
end
Qo=obsv(A,C);
ro=rank(Qo)
L=size(A);
if ro==L
    str='系统能观'
else
    str='系统不完全能观'
end
disp('约旦标准型判断方法')
J=jordan(A)
[V,J]=jordan(A)
T=inv(V)
[An,Bn,Cn,Dn]=ss2ss(A,B,C,D,T)