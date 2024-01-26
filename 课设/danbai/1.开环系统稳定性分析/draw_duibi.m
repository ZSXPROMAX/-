clc
%%%%%%%%%%画出输出响应%%%%%%%%%%%%%%%%%%%%
figure(1);
set(gca,'FontSize',15,'FontName','Times New Roman')
plot(out.y.time,out.y.signals.values(:,1),'b-',out.y.time,out.y.signals.values(:,2),'r-');
xlabel('Time','FontSize',15);
ylabel('y(t)','FontSize',15);
title('out','FontSize',15);
% axis([0 10 -5*10^(18) 10^(18)]);
grid on
legend('非线性','线性')