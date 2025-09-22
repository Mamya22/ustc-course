clc; clear;

img1 = imread('E:\Homework\Digital Image\image\alphabet1.jpg'); % 原图
img2 = imread('E:\Homework\Digital Image\image\alphabet2.jpg'); % 失真图

[r1, c1, h1] = size(img1);
[r2, c2, h2] = size(img2);

% 显示两幅图并选取对应的控制点（5对）
figure;
subplot(1,2,1); imshow(img1); title('原图');
subplot(1,2,2); imshow(img2); title('失真图');

[x, y] = ginput(10);  % 共10个点：点1是img1的控制点，点2是img2的对应点，交替

% 分离点
x1 = x(1:2:9);  y1 = y(1:2:9);  % 原图中的点（alphabet1）
x2 = x(2:2:10);  y2 = y(2:2:10);  % 失真图中的点（alphabet2）

% 构造线性系统：双线性变换模型
% 构造系数矩阵 M
M = [x1(1)*y1(1), x1(1), y1(1), 1;
     x1(2)*y1(2), x1(2), y1(2), 1;
     x1(3)*y1(3), x1(3), y1(3), 1;
     x1(4)*y1(4), x1(4), y1(4), 1;
     x1(5)*y1(5), x1(5), y1(5), 1];

% 求出映射系数 A, B
A = (M' * M) \ (M' * x2);  
B = (M' * M) \ (M' * y2);  % 用于计算目标Y坐标

% 生成输出图像
out_image = zeros(r1, c1, h1);

for i = 1:r1  % y
    for j = 1:c1  % x
        % 反向映射
        p = [j*i, j, i, 1];  % 注意顺序: x*y, x, y, 1
        X = p * A;
        Y = p * B;

        x1f = floor(X); y1f = floor(Y);
        dx = X - x1f; dy = Y - y1f;

        if x1f >= 1 && x1f+1 <= c2 && y1f >= 1 && y1f+1 <= r2
            for k = 1:h2
                % 取周围 4 个像素值（用于双线性插值）
                Q11 = double(img2(y1f,   x1f,   k));
                Q12 = double(img2(y1f,   x1f+1, k));
                Q21 = double(img2(y1f+1, x1f,   k));
                Q22 = double(img2(y1f+1, x1f+1, k));

                % 双线性插值计算
                val = Q11*(1-dx)*(1-dy) + Q12*dx*(1-dy) + ...
                      Q21*(1-dx)*dy + Q22*dx*dy;

                out_image(i, j, k) = val;
            end
        end
    end
end

% 显示校正后的图像
figure;
imshow(uint8(out_image));
title('校正后的图像');
