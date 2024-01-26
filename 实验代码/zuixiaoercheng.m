%% 一般最小二乘法
randn('seed',100)
v= sqrt(0.1)*rand(1,60);%产生一组16个N（0,0.1）的高斯分布的随机噪声，若N(0,0.5)
%则写为v=sqrt(0.5)*rand(1,16)
% M序列的周期
L=15;% M序列的周期
y1=1;y2=1;y3=1;y4=0; %四个移位寄存器的输出初始值
for i=1:L;
    x1=xor(y3,y4);
 x2=y1;
 x3=y2;
    x4=y3;
    y(i)=y4;
    if y(i)>0.5,u(i)=-5;
    else u(i)=5;
    end
    y1=x1;y2=x2;y3=x3;y4=x4;
end
figure
stem(u),grid on
title('输入信号M序列')
% 最小二乘辨识系统
z=zeros(1,16); % 定义输出观测值的长度
for k=3:16
z(k)=-1.6*z(k-1)-0.7*z(k-2)+u(k-1)+0.4*u(k-2)+v(k);%观测值为白噪声所以直接加v(k)即可
end
figure(2)
plot([1:16],z)
title('输出观测值')
figure(3)
i = 1:60;
plot(i, a1, '-kp', i, a2, '--bo', i, b1, '-.rs', i, b2, ':m.');
xlim([0 20])
legend('a1', 'a2', 'b1', 'b2');
title('递推最小二乘辨识');
% 给样本系数矩阵
H=[-z(2) -z(1) u(2) u(1);-z(3) -z(2) u(3) u(2);-z(4) -z(3) u(4) u(3);-z(5) -z(4) u(5) u(4);-z(6) -z(5) u(6) u(5);-z(7) -z(6) u(7) u(6);
    -z(8) -z(7) u(8) u(7);-z(9) -z(8) u(9) u(8);-z(10) -z(9) u(10) u(9);-z(11) -z(10) u(11) u(10);-z(12) -z(11) u(12) u(11);
    -z(13) -z(12) u(13) u(12);-z(14) -z(13) u(14) u(13);-z(15) -z(14) u(15) u(14)];
%给样本观测矩阵
Z=[z(3);z(4);z(5);z(6);z(7);z(8);z(9);z(10);z(11);z(12);z(13);z(14);z(15);z(16)]
% 计算参数
c=inv(H'*H)*H'*Z;
% 分离参数
a1=c(1),a2=c(2),b1=c(3),b2=c(4)
%% 递推最小二乘法
clear all
clc
randn('seed',100) ;
v=sqrt(0.5)*rand(1,60);%产生一组60个N（0,0.1）的高斯分布的随机噪声，若N(0,0.5)则写为v=sqrt(0.5)*rand(1,16)
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
  z(k)=-1.5*z(k-1)-0.7*z(k-2)+u(k-1)+0.4*u(k-2)+1 *v(k);%观测值，此处为白噪声
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
plot(i, a1, '-kp', i, a2, '--bo', i, b1, '-.rs', i, b2, ':m.');
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
    z(k)=-1.5*z(k-1)-0.7*z(k-2)+u(k-1)+0.5*u(k-2)+1.2*v(k)-v(k-1)+0.2*v(k-2)
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
figure(2)
plot([1:60],z)
title('输出观测值')
figure(3);
plot(i,a1,'-rp',i,a2,'--bo',i,b1,'-.ks',i,b2,':y.',i,c1,'-g+',i,c2,'--c*',i,c3,'-.mp')%画出各个被辨析参数
legend('a1', 'a2', 'b1', 'b2','c1','c2','c3');
xlim([0 20])
title('增广最小二乘辨析算法')%标题
%%
clc;
clear;
% 给定的时间和水位高度数据
t = [0, 10, 20, 40, 60, 80, 100, 150, 200, 300, Inf];
h = [0, 9.5, 18, 33, 45, 55, 63, 78, 86, 95, 98];
% 稳态值
h_steady = 98;
% 计算标幺值
h_normal = h / h_steady;
% 阶跃输入的标幺值
step_input_normal = 9.8 / h_steady;
% 绘制标幺值曲线
figure;
plot(t, h_normal, 'b-', 'LineWidth', 2);
hold on;
line([t(1), t(end)], [step_input_normal, step_input_normal], 'Color', 'red', 'LineStyle', '--');
xlabel('时间 (s)');
ylabel('水位标幺值');
title('水位阶跃响应标幺值曲线');
legend('标幺响应', '阶跃输入标幺值');
grid on;
% 确保无穷大时间点不会被画出来
set(gca, 'XLim', [0, t(end-1)]);
h1=38.56
h2=61.95
h3=84.74

% 使用线性插值找到对应的时间
t1 = interp1(h, t, h1, 'linear');
t2 = interp1(h, t, h2, 'linear');
t3 = interp1(h, t, h3, 'linear');
% 输出对应的时间
disp(['对应的时间 t1: ', num2str(t1)]);
disp(['对应的时间 t2: ', num2str(t2)]);
disp(['对应的时间 t3: ', num2str(t3)]);