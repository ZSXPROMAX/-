clc;
close
%%%%%%%%%%画出线性系统输出响应%%%%%%%%%%%%%%%%%%%%
figure(1)
set(gca,'FontSize',15,'FontName','Times New Roman')
%plot(out.y.time,out.y.signals.values(:,1),'b-');
[ys,tr,ts,tm,ov]=Fun_Step_Performance(out.y.time,out.y.signals.values(:,1));
xlabel('Time','FontSize',15);
ylabel('y(t)','FontSize',15);
title('out','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('y')
%%%%%%%%%%画出非线性系统输出响应%%%%%%%%%%%%%%%%%%%%
figure(2)
set(gca,'FontSize',15,'FontName','Times New Roman')
% plot(out.y1.time,out.y1.signals.values(:,1),'b-');
[ys,tr,ts,tm,ov]=Fun_Step_Performance(out.y1.time,out.y1.signals.values(:,1));
xlabel('Time','FontSize',15);
ylabel('y(t)','FontSize',15);
title('out','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('y')