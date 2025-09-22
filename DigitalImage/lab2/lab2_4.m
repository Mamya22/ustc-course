
img = imread("image\lena.bmp");

 % 显示原图及其直方图
subplot(3,2,1); imshow(img); title("原图");
subplot(3,2,2); histogram(img); title("原始图像直方图"); 

% 直方图均衡增强
img_S = histeq(img);
subplot(3,2,3); imshow(img_S); title("增强后图像");
subplot(3,2,4); histogram(img_S); title("增强后直方图");

% 直方图规定化处理
% normpdf正态概率密度函数
img_G = histeq(img, normpdf((0:1:255), 127, 70));
subplot(3,2,5); imshow(img_G); title("规定化后图像");
subplot(3,2,6); histogram(img_G); title("规定化后直方图");
