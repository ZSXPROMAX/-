%% 极大似然参数估计
clear all
close all
% 产生仿真数据
% 产生仿真数据
n = 2;
total = 1000; % 修改为16以与Newton-Raphson法中的序列长度一致
sigma = 0.1; % 噪声变量的均方根
% M 序列作为输入
z1 = 1; z2 = 1; z3 = 1; z4 = 0;
for i = 1:total
    x1 = xor(z3, z4);
    x2 = z1;
    x3 = z2;
    x4 = z3;
    z(i) = z4;
    if z(i) > 0.5
        u(i) = -1;
    else
        u(i) = 1;
    end
    z1 = x1; z2 = x2; z3 = x3; z4 = x4;
end
figure(1);
stem(u, 'filled'), grid on;
title('Input Signal M Sequence');
% 系统输出
y(1) = 0; y(2) = 0;
v = sigma * randn(total, 1); % 噪声
y(1) = 1; y(2) = 0.01;
for k = 3:total
    y(k) = 0.5 * y(k - 1) + 0.2 * y(k - 2) + u(k - 1) + 1.5 * u(k - 2) + v(k) - 0.8 * v(k - 1) + 0.3 * v(k - 2);
end
%初始化
theta0=0.001* ones(6,1); %参数
e1(1)=-0.5-theta0(1); e2(1)=-0.2-theta0(2); %误差初始化
e3(1)=1.0-theta0(3); e4(1)=1.5-theta0(4);
e5(1)=-0.8-theta0(5); e6(1)=0.3-theta0(6);
a_hat(1)=theta0(1); a_hat(2)=theta0(2); %参数分离
b_hat(1)=theta0(3); b_hat(2)=theta0(4);
c_hat(1)=theta0(5); c_hat(2)=theta0(6);
P0=eye(6,6); %矩阵 P 初始化
for i=1:n
    yf(i)=0.1;
    uf(i)=0.1;
    vf(i)=0.1;
    fai0(i,1)=-yf(i);
    fai0(n+i,1)=uf(i);
    fai0(2* n+i,1)=vf(i);
end
e(1)=1.0;
e(2)=1.0;
%递推算法
for i=n+1:total
pusai=[-y(i-1);-y(i-2);u(i-1);u(i-2);e(i-1);e(i-2)];
C=zeros(n* 3,n* 3);
Q=zeros(3* n,1);
Q(1)=-y(i-1);
Q(n+1)=u(i-1);
Q(2* n+1)=e(i-1);
for j=1:n
    C(1,j)=-c_hat(j);
    C(n+1,n+j)=-c_hat(j);
    C(2* n+1,2* n+j)=-c_hat(j);
if j>1
    C(j,j-1)=1.0;
    C(n+j,n+j-1)=1.0;
    C(2* n+j,2* n+j-1)=1.0
    end
end
fai=C* fai0+Q;
K=P0* fai* inv(fai'* P0* fai+1);
P=[eye(6,6)-K* fai']* P0;
e(i)=y(i)-pusai'* theta0;
theta=theta0+K* e(i);
P0=P;
theta0=theta;
fai0=fai;
    a_hat(1)=theta(1); a_hat(2)=theta(2);
    b_hat(1)=theta(3); b_hat(2)=theta(4);
    c_hat(1)=theta(5); c_hat(2)=theta(6);
    e1(i)=-0.5-a_hat(1); e2(i)=-0.2-a_hat(2);
    e3(i)=1.0-b_hat(1); e4(i)=1.5-b_hat(2);
    e5(i)=-0.8-c_hat(1); e6(i)=0.3-c_hat(2);
end
% 绘制参数估计误差
figure(2);
plot(e1, '-r', 'LineWidth', 2); hold on;
plot(e2, '--g', 'LineWidth', 2); hold on;
plot(e3, ':b', 'LineWidth', 2); hold on;
plot(e4, '-.m', 'LineWidth', 2); hold on;
plot(e5, '-c', 'LineWidth', 2); hold on;
plot(e6, '--k', 'LineWidth', 2);
title('Parameter Estimation Error');
xlabel('times');
ylabel('error');
legend('e1', 'e2', 'e3', 'e4', 'e5', 'e6');
hold off;

% 绘制输出误差
figure(3);
plot(e, '-r', 'LineWidth', 2); % 修改为红色实线
title('Output Error');
xlabel('times');
ylabel('error');
%% Newton-Raphson 法
clear all
close all
clc
randn('seed',100)
sigma=0.1;
v=sigma*randn(1,16); %产生一组 16 个 N(0，1)的高斯分布的随机噪声
n=2;
N=200;
epsilon=0.001;%迭代终止条件
%M 序列产生程序
L=15; %M 序列的周期
y1=1;y2=1;y3=1;y4=0; %四个移位寄存器的输出初始值
for i=1:L
x1=xor(y3,y4);
x2=y1;
x3=y2;
x4=y3;
y(i)=y4;
if y(i)>0.5,u(i)=-1;
else u(i)=1;
end
y1=x1;y2=x2;y3=x3;y4=x4;
end
figure
stem(u),grid on
title('输入信号 M 序列')
%最小二乘辨识程序
z=zeros(1,16); %定义输出观测值的长度
for k=3:16
y(k)=0.5*y(k-1)+0.2*y(k-2)+1.0*u(k-1)+1.5*u(k-2)+1*v(k); %观测值
end
H=[-y(2) -y(1) u(2) u(1) ;-y(3) -y(2) u(3) u(2);-y(4) -y(3) u(4) u(3);
-y(5) -y(4) u(5) u(4);-y(6) -y(5) u(6) u(5);-y(7) -y(6) u(7) u(6);
-y(8) -y(7) u(8) u(7);-y(9) -y(8) u(9) u(8);-y(10) -y(9) u(10) u(9);
-y(11) -y(10) u(11) u(10);-y(12) -y(11) u(12) u(11);
-y(13) -y(12) u(13) u(12);-y(14) -y(13) u(14) u(13);
-y(15) -y(14) u(15) u(14)];
%给出样本观测矩阵
Z=[y(3);y(4);y(5);y(6);y(7);y(8);y(9);y(10);y(11);y(12);y(13);y(14);
y(15);y(16)]
%计算参数
c=inv(H'*H)*H'*Z;
%分离参数
a1=c(1),a2=c(2),b1=c(3),b2=c(4)
24
d1=0.1;d2=0.1;
theta0=[a1 a2 b1 b2 d1 d2]';
v(1)=0;v(2)=0;
vda1(1)=0;vda2(1)=0;vdb1(1)=0;vdb2(1)=0;vdd1(1)=0;vdd2(1)=0; vda1(2)=0;vda2(2)=0;vdb1(2)=0;vdb2(2)=0;vdd1(2)=0;vdd2(2)=0;
j=1;
theta1=zeros(6,1);
vdtheda=zeros(6,1);
while j<501
for i=1:N+2
x1=xor(y3,y4);
x2=y1;
x3=y2;
x4=y3;
y(i)=y4;
if y(i)>0.5,u(i)=-1;
else u(i)=1;
end
y1=x1;y2=x2;y3=x3;y4=x4;
end
y(1)=0;y(2)=0;
v=randn(1,N+3);
y(1)=1;y(2)=0.01;
for k=3:N+2
    y(k)=0.5*y(k-1)+0.2*y(k-2)+1.0*u(k-1)+1.5*u(k-2)+v(k)-0.8*v(k-1)+0.3*v(k-2);
end
Jd=0;Jdd=0;
a1=theta0(1);a2=theta0(2);b1=theta0(3);b2=theta0(4);d1=theta0(5);d2=theta0(6);
for k=3:N+2
    v(k)=y(k)+a1*y(k-1)+a2*y(k-2)-b1*u(k-1)-b2*u(k-2)-d1*v(k-1)-d2*v(k-2);%
    vda1(k)=y(k-1)-d1*vda1(k-1)-d2*vda1(k-2);
    vda2(k)=y(k-2)-d1*vda2(k-1)-d2*vda2(k-2);
    vdb1(k)=-u(k-1)-d1*vdb1(k-1)-d2*vdb1(k-2);
    vdb2(k)=-u(k-2)-d1*vdb2(k-1)-d2*vdb2(k-2);
    vdd1(k)=-v(k-1)-d1*vdd1(k-1)-d2*vdd1(k-2);
    vdd2(k)=-v(k-2)-d1*vdd2(k-1)-d2*vdd2(k-2);
    vdtheda=[vda1(k),vda2(k),vdb1(k),vdb2(k),vdd1(k),vdd2(k)]';
    Jd=Jd+v(k)*vdtheda;%梯度阵
    Jdd=Jdd+vdtheda'*vdtheda;%黑塞矩阵
end
theta1=theta0;
theta0=theta0-inv(Jdd)*Jd;
a1=theta0(1);a2=theta0(2);b1=theta0(3);b2=theta0(4);d1=theta0(5);d2=theta0(6);
e1(j)=a1; e2(j)=a2;
e3(j)=b1; e4(j)=b2;
e5(j)=d1; e6(j)=d2;
e7(j)=-0.5-a1; e8(j)=-0.2-a2;
e9(j)=1.0-b1; e10(j)=1.5-b2;
e11(j)=-0.8-d1; e12(j)=0.3-d2;
j=j+1;
v(1)=v(N+1);v(2)=v(N+2);
vda1(1)=vda1(N+1);vda2(1)=vda2(N+1);vdb1(1)=vdb1(N+1);
vdb2(1)=vdb2(N+1);vdd1(1)=vdd1(N+1);vdd2(1)=vdd2(N+1);
vda1(2)=vda1(N+2);vda2(2)=vda2(N+2);vdb1(2)=vdb1(N+2);
vdb2(2)=vdb2(N+2);vdd1(2)=vdd1(N+2);vdd2(2)=vdd2(N+2);
end
% 绘制Newton-Raphson法的结果
figure(4);
plot(e1, '-r', 'LineWidth', 2); hold on;
plot(e2, '--g', 'LineWidth', 2); hold on;
plot(e3, ':b', 'LineWidth', 2); hold on;
plot(e4, '-.m', 'LineWidth', 2); hold on;
plot(e5, '-c', 'LineWidth', 2); hold on;
plot(e6, '--k', 'LineWidth', 2);
title('Identification Results');
legend('e1', 'e2', 'e3', 'e4', 'e5', 'e6');
hold off;

figure(5);
plot(e7, '-r', 'LineWidth', 2); hold on;
plot(e8, '--g', 'LineWidth', 2); hold on;
plot(e9, ':b', 'LineWidth', 2); hold on;
plot(e10, '-.m', 'LineWidth', 2); hold on;
plot(e11, '-c', 'LineWidth', 2); hold on;
plot(e12, '--k', 'LineWidth', 2);
title('Identification Estimation Error Results');
xlabel('Iteration Number');
ylabel('Estimation Error');
legend('e7', 'e8', 'e9', 'e10', 'e11', 'e12');
hold off;