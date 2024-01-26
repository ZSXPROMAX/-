clc;
%%线性系统验证
%%%%%%%%%%画出状态响应%%%%%%%%%%%%%%%%%%
figure(1);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.x.time,out.x.signals.values(:,1),'b-',out.x.time,out.x.signals.values(:,2),'g-',out.x.time,out.x.signals.values(:,3),'r-',out.x.time,out.x.signals.values(:,4),'c-');
xlabel('Time','FontSize',15);
ylabel('x(t)','FontSize',15);
title('states','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('x_1','x_2','x_3','x_4')
%%%%%%%%%%画出输出响应%%%%%%%%%%%%%%%%%%%%
figure(2);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.y.time,out.y.signals.values(:,1),'b-');
xlabel('Time','FontSize',15);
ylabel('y(t)','FontSize',15);
title('out','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('y')
%%%%%%%%%%画出误差响应%%%%%%%%%%%%%%%%%%%%
figure(3);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.e.time,out.e.signals.values(:,1),'b-');
xlabel('Time','FontSize',15);
ylabel('e(t)','FontSize',15);
title('error','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('e')
%%非线性系统验证
%%%%%%%%%%画出状态响应%%%%%%%%%%%%%%%%%%
figure(4);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.x1.time,out.x1.signals.values(:,1),'b-',out.x1.time,out.x1.signals.values(:,2),'g-',out.x1.time,out.x1.signals.values(:,3),'r-',out.x1.time,out.x1.signals.values(:,4),'c-');
xlabel('Time','FontSize',15);
ylabel('x(t)','FontSize',15);
title('states','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('x_1','x_2','x_3','x_4')
%%
%%%%%%%%%%画出输出响应%%%%%%%%%%%%%%%%%%%%
figure(5);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.y1.time,out.y1.signals.values(:,1),'b-');
xlabel('Time','FontSize',15);
ylabel('y(t)','FontSize',15);
title('out','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('y')
%%
%%%%%%%%%%画出误差响应%%%%%%%%%%%%%%%%%%%%
figure(6);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.e1.time,out.e1.signals.values(:,1),'b-');
xlabel('Time','FontSize',15);
ylabel('e(t)','FontSize',15);
title('error','FontSize',15);
%axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('e')