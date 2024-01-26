%%
%2.3
clc;
clear all;
A=[0 1 0; 0 0 1;2 -5 4];
syms s t
FS=inv(s*eye(3)-A);
eAt=ilaplace(FS,s,t)

%%
%2.4.1
clc;
clear all;
A = [0 -1; 4 0];
syms s t
FS = inv(s * eye(2) - A);
eAt1 = ilaplace(FS, s, t); % 方法一
eAt1 = simplify(eAt1) %化简表达式
eAt2 = expm(A * t); % 方法二
eAt2 = simplify(eAt2) %化简表达式
[V, D] = eig(A); % 方法三
eAt3 = V * diag(exp(diag(D) * t)) / V;
eAt3=simplify(eAt3) %化简表达式

%%
%2.4.2
clc;
clear all;
A = [1 1; 4 1];
syms s t
FS = inv(s * eye(2) - A);
eAt1 = ilaplace(FS, s, t); % 方法一
eAt1 = simplify(eAt1) %化简表达式
eAt2 = expm(A * t); % 方法二
eAt2 = simplify(eAt2) %化简表达式
[V, D] = eig(A); % 方法三
eAt3 = V * diag(exp(diag(D) * t)) / V;
eAt3=simplify(eAt3) %化简表达式

%%
%2.6
A=[0 1;0 0];
B=[0;1];
C=[1 0];
D=0;
x0=[1,1];
t=0:0.01:10;
u=ones(1,size(t,2));
lsim(A,B,C,D,u,t,x0)
%%
