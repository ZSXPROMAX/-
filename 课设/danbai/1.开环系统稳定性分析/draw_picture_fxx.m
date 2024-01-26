clc;
%%
%%%%%%%%%%画出非线性系统状态响应和非线性系统输出响应%%%%%%%%%%%%%%%%%%
figure;
set(gcf, 'Position', [100, 100, 1200, 600]); % 设置图形窗口大小
set(gca, 'FontSize', 15, 'FontName', 'Times New Roman')

% 第一个子图
subplot(2, 1, 1);
plot(out.x.time, out.x.signals.values(:,1), 'b-', out.x.time, out.x.signals.values(:,2), 'g-', out.x.time, out.x.signals.values(:,3), 'r-', out.x.time, out.x.signals.values(:,4), 'c-');
xlabel('Time', 'FontSize', 15);
ylabel('x(t)', 'FontSize', 15);
title('非线性系统状态响应', 'FontSize', 15);
% axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on;
legend('x_1', 'x_2', 'x_3', 'x_4');

% 第二个子图
subplot(2, 1, 2);
plot(out.y.time, out.y.signals.values(:,1), 'b-');
xlabel('Time', 'FontSize', 15);
ylabel('y(t)', 'FontSize', 15);
title('非线性系统输出响应', 'FontSize', 15);
% axis([0 10 -5*10^(18) 10^(18)]);
grid on;
legend('y');

%%
