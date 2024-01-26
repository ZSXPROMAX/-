clc;
clear all;
A=[-4 1 0 0 0 0;
0 -4 0 0 0 0;
0 0 3 1 0 0;
0 0 0 3 0 0;
0 0 0 0 -1 1;
0 0 0 0 0 -1];
B=[1 3;5 7;4 3;0 0;1 6;0 0];
C=[3 1 0 5 0 0;1 4 0 2 0 0];

M = ctrb(A, B);
N = obsv(A, C);
r1 = rank(M);
r2 = rank(N);
L = size(A, 1); % 获取矩阵的行数和列数

if r1 == L
   disp('系统完全能控')
else
    disp('系统不完全能控')
    [A1, B1, C1, T, k] = ctrbf(A, B, C);
end

if r2 == L
    disp('系统完全能观')
else
    disp('系统不完全能观')
    [A2, B2, C2, T, k] = obsvf(A, B, C);
end

if r1 ~= L && r2 ~= L
    % 这里需要首先处理能控部分，然后再处理能观部分
    [A1, B1, C1, T1, K1] = ctrbf(A, B, C);
    % 提取能控子系统
    A2 = A1(1:K1, 1:K1);
    B2 = B1(1:K1, :);
    C2 = C1(:, 1:K1);
    % 在能控子系统上提取能观的部分
    [A3, B3, C3, T3, k3] = obsvf(A2, B2, C2)
    % 现在A3, B3, C3是能控且能观的子系统
end
%%
clear all
close all

% 定义系统矩阵
A = [-2, -1, 1; 1, 0, 1; -1, 0, 1];
B = [1; 1; 1];

% 计算控制性矩阵
Qc = ctrb(A, B);
rc = rank(Qc);

% 获取矩阵的行数
L = size(A, 1);

% 定义期望的闭环极点
roots = [-1, -2, -3];

if rc == L
   disp('系统完全可控')
   K1 = acker(A, B, roots)
   K2 = place(A, B, roots)
else
   disp('系统不完全可控')
end
%%