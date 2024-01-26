clc;
%%
%%%%%%%%%%画出状态响应%%%%%%%%%%%%%%%%%%
figure(1);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.x.time,out.x.signals.values(:,1),'b-',out.x.time,out.x.signals.values(:,2),'g-',out.x.time,out.x.signals.values(:,3),'r-',out.x.time,out.x.signals.values(:,4),'c-');
xlabel('Time','FontSize',15);
ylabel('x(t)','FontSize',15);
title('states','FontSize',15);
axis([0 8 -2.5*10^(15) 2.5*10^(15)]);
grid on
legend('x_1','x_2','x_3','x_4')
%%
%%%%%%%%%%画出输出响应%%%%%%%%%%%%%%%%%%%%
figure(2);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.y.time,out.y.signals.values(:,1),'b-');
xlabel('Time','FontSize',15);
ylabel('y(t)','FontSize',15);
title('out','FontSize',15);
axis([0 10 -5*10^(18) 10^(18)]);
grid on
legend('y')