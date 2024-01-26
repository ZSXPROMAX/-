%分析
%第一部分
clc
clear
A=[-4 1 0 0 0 0;
   0 -4 0 0 0 0;
   0 0 3 1 0 0;
   0 0 0 3 0 0;
   0 0 0 0 -1 1;
   0 0 0 0 0 -1];
B=[1 3;5 7;4 3;0 0;1 6;0 0];
C=[3 1 0 5 0 0;1 4 0 2 0 0];

n=size(A,1);
Qc=ctrb(A,B);
Qo=obsv(A,C);
i1=rank(Qc);
i2=rank(Qo);
if rank(Qc)==n
    str='系统能控'
else
    str='系统不能控'
    [A1,B1,C1,T,K]=ctrbf(A,B,C)
end
if rank(Qo)==n
    str='系统能观'
else
    str='系统不能观'
    [A2,B2,C2,T,K]=obsvf(A,B,C)
end