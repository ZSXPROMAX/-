%%
% 定义连续时间传递函数
num = [0.6 -9.8]; % 分子系数
den = [1 2.5 3.3]; % 分母系数
G_s = tf(num, den); % 创建传递函数

% 设定采样时间
T = 0.1; % 假设采样周期为0.1秒

% 使用后向差分法进行离散化
G_z = c2d(G_s, T, 'tustin');

% 显示离散时间传递函数
disp(G_z);

% 如果需要，将离散时间传递函数转换为差分方程的系数
[num_d, den_d] = tfdata(G_z, 'v'); % 提取离散时间传递函数的系数
a = -den_d(2:end); % 注意MATLAB返回的分母包含了z^0的系数，我们需要取反和移除它
b = num_d(2:end); % 分子的系数也需要调整，移除z^0的系数

% 输出差分方程的系数
disp('差分方程的系数 a:');
disp(a);
disp('差分方程的系数 b:');
disp(b);

%% 递推最小二乘法
clear all
clc
randn('seed',100) ;
v=sqrt(0.1)*rand(1,60);%产生一组60个N（0,0.1）的高斯分布的随机噪声，若N(0,0.5)则写为v=sqrt(0.5)*rand(1,16)
%M序列产生程序
L=60;%M序列的周期
y1=1;y2=1;y3=1;y4=0;%四个移位寄存器的输出初始值
for i=1:L;
x1=xor(y3,y4);
x2=y1;
x3=y2;
x4=y3;
y(i)=y4;
if y(i)>0.5,u(i)=-5;%M序列幅值为5
else u(i)=5;
end
y1=x1;y2=x2;y3=x3;y4=x4;
end
figure(1);
stem(u),grid on
title('输入信号M序列')
%递推最小二乘辨识程序
z(2)=0;z(1)=0;
%观测值由理想输出值加噪声
for k=3:60;%循环变量从3到60
  z(k)=1.75*z(k-1)-0.7794*z(k-2)-0.0432*u(k-1)-0.0481*u(k-2)+0.1*v(k)+0.4*v(k-1)+0.3*v(k-2);%观测值，此处为白噪声
end
c0=[0.001 0.001 0.001 0.001]';
p0=10^3*eye(4,4);
E=0.000000005;%相对误差
c=[c0,zeros(4,59)];%被辨识参数矩阵的初始值及大小
e=zeros(4,60);%相对误差的初始值及大小
lamt=1;
for k=3:60;
    h1=[-z(k-1),-z(k-2),u(k-1),u(k-2)]';
    k1=p0*h1*inv(h1'*p0*h1+1*lamt);%求出k的值
    new=z(k)-h1'*c0;
    c1=c0+k1*new;%求被辨识参数c

    p1=1/lamt*(eye(4)-k1*h1')*p0;
    e1=(c1-c0)./c0;%求参数当前值与上一次的值的差值
    e(:,k)=e1;%把当前相对变化的列向量加入误差矩阵的最后一列
    c(:,k)=c1;%把辨识参数c列向量加入辨识参数矩阵的最后一列
    c0=c1;%新获得的参数作为下一次递推的旧参数
    p0=p1;
    if norm(e1)<=E
        break;%若参数收敛满足要求，中止计算
    end
end
%分离参数
a1=c(1,:)
a2=c(2,:)
b1=c(3,:)
b2=c(4,:)
ea1=e(1,:);ea2=e(2,:);eb1=e(3,:);eb2=e(4,:);

figure(2);
i = 1:60;
plot(i, -a1, '-kp', i, -a2, '--bo', i, b1, '-.rs', i, b2, ':m.');
xlim([0 20])
legend('a1', 'a2', 'b1', 'b2');
title('递推最小二乘辨识');


figure(3);
plot(i, ea1, '-kp', i, ea2, '--bo', i, eb1, '-.rs', i, eb2, ':m.');
xlim([0 20])
legend('ea1', 'ea2', 'eb1', 'eb2');
title('辨识精度');

%% 增广递推最小二乘辨识法
clear all
clc
% M序列，噪声信号产生及其显示程序
L=60;% 四位移位寄存器产生的M序列的周期
y1=1;y2=1;y3=1;y4=0; %四个移位寄存器的输出初始值
for i=1:L;
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
figure(1)
stem(u),grid on%画出M序列输入信号
title('输入信号M序列')
randn('seed',100)
v=sqrt(0.1)*randn(1,60);%产生一个N（0，0.1）的随机噪声
%增广最小二乘辨识
z(2)=0;z(1)=0;
theat0=[0.001 0.001  0.001  0.001  0.001  0.001  0.001]';
p0=10^4*eye(7,7);%初始状态p0
theat=[theat0,zeros(7,59)];%被辨析参数矩阵的初始值及大小
for k=3:60;
    z(k)=1.75*z(k-1)-0.7794*z(k-2)-0.0432*u(k-1)-0.0481*u(k-2)+0.1*v(k)-0.4*v(k-1)+0.3*v(k-2)
    h1=[-z(k-1),-z(k-2),u(k-1),u(k-2),v(k),v(k-1),v(k-2)]';
    x=h1'*p0*h1+1;
    x1=inv(x);
    k1=p0*h1*x1;%k
    d1=z(k)-h1'*theat0;
    theat1=theat0+k1*d1;%辨析参数c
    theat0=theat1;%给下次用
    theat(:,k)=theat1;%把辨析参数c列加入辨析参数矩阵
    p1=p0-k1*k1'*[h1'*p0*h1+1];%find p(k)
    p0=p1;%给下一次用
end%循环结束
%分离变量
a1=theat(1,:)
a2=theat(2,:)
b1=theat(3,:)
b2=theat(4,:)
c1=theat(5,:)
c2=theat(6,:)
c3=theat(7,:)
i=1:60;
figure(2);
plot(i,z);
xlim([0 20])
title('输出观测值');
figure(3);
plot(i,-a1,'-rp',i,-a2,'--bo',i,b1,'-.ks',i,b2,':y.',i,c1,'-g+',i,-c2,'--c*',i,c3,'-.mp')%画出各个被辨析参数
legend('a1', 'a2', 'b1', 'b2','c1','c2','c3');
xlim([0 20])
title('增广最小二乘辨析算法')%标题
%% 极大似然参数估计
clear all
close all
% 产生仿真数据
% 产生仿真数据
n = 2;
total = 1000; % 修改为1000以与Newton-Raphson法中的序列长度一致
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
     y(k) = 1.7503 * y(k - 1) -0.7794 * y(k - 2) -0.0432*u(k - 1) -0.0481 * u(k - 2) + 0.1*v(k) +0.4 * v(k - 1) + 0.3 * v(k - 2);
end
%初始化
theta0=0.001* ones(6,1); %参数
e1(1)=1.7503-theta0(1); e2(1)=-0.7794-theta0(2); %误差初始化
e3(1)=-0.0432-theta0(3); e4(1)=-0.0481-theta0(4);
e5(1)=0.1-theta0(5); e6(1)=0.4-theta0(6);
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
    e1(i)=1.7503-a_hat(1); e2(i)=-0.7794-a_hat(2);
    e3(i)=-0.0432-b_hat(1); e4(i)=-0.0481-b_hat(2);
    e5(i)=0.1-c_hat(1); e6(i)=0.4-c_hat(2);
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
 y(k) = 1.7503 * y(k - 1) -0.7794 * y(k - 2) -0.0432*u(k - 1) -0.0481 * u(k - 2) + 0.1*v(k) +0.4 * v(k - 1) + 0.3 * v(k - 2);end
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
    y(k) = 1.7503 * y(k - 1) -0.7794 * y(k - 2) -0.0432*u(k - 1) -0.0481 * u(k - 2) + 0.1*v(k) +0.4 * v(k - 1) + 0.3 * v(k - 2);
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
e7(j)=1.7503-a1; e8(j)=-0.7794-a2;
e9(j)=-0.0432-b1; e10(j)=-0.0481-b2;
e11(j)=0.1-d1; e12(j)=0.4-d2;
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