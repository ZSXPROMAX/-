%% 状态轨迹
close all;
figure(1);
Time=x1.time;
y1 = x1.signals.values;
y2 = x2.signals.values;
y3 = x3.signals.values;
grid on;
plot(Time, y1, 'g-', Time, y2, 'b-', Time, y3, 'r-', 'LineWidth', 1.5);
xlabel('Time'); 
ylabel('Output'); 
title('Response');
legend('x1', 'x2', 'x3'); % 添加图例
%% 状态轨迹三维图
Time=x1.time;
h=animatedline('Color','b') %创建一个动画的点线对象，并将其颜色设置为蓝色
Z=x1.signals.values;
Y=x2.signals.values;
X=x3.signals.values;
grid on;
view([-11 11])
zlim([-6 6])
ylim([-1 1])
xlim([-5 5])
for t=1:length(x1.time)

   addpoints(h,X(t),Y(t),Z(t))

   drawnow %在每个时间点之后强制刷新图形

end


