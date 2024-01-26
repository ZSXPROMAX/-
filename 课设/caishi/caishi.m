A=[-18/7 9 0;1 -1 1;0 -14.28 0];
H=[27/7;0;0];
C=[1 0 0];
D=[1 0 0];
W=1;
P=sdpvar(3,3,'symmetric');
V=sdpvar(3,1,'full');
T=sdpvar(1,1,'symmetric');
s=[P*A-V*C+A'*P-C'*V' P*H+D'*W*T;T'*W'*D+H'*P -2*T];
Fcond=[P>0,T>0,s<0];
ops=sdpsettings('verbose',0,'solver','sedumi');
diagnostics=solvesdp(Fcond,[],ops);
[m p]=checkset(Fcond);
tmin=min(m);
 
if tmin>0
    Ph=double(P);
    Vh=double(V);
    disp('系统是稳定的，并且控制增益稳定')
    K=inv(Ph)*Vh
else
    disp('系统不能通过状态反馈达到稳定')
end
%%
%%%%%%%%%%线性系统状态响应%%%%%%%%%%%%%%%%%%
x1=out.x1.signals.values  (:,1);
x2=out.x2.signals.values  (:,1);
x3=out.x3.signals.values  (:,1);

figure(1)
plot(x1,x2)
xlabel('x1');
ylabel('x2');
title('状态轨迹x1,x2')

figure(2)
plot(x1,x3)
xlabel('x1');
ylabel('x3');
title('状态轨迹x1,x3')

figure(3)
plot(x2,x3)
xlabel('x2');
ylabel('x3');
title('状态轨迹x2,x3')

figure(4)
plot3(x1,x2,x3)
xlabel('x1');
ylabel('x2');
zlabel('x3');
title('状态轨迹x1,x2,x3')
