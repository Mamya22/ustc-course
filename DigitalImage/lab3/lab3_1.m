% 读取图像
img = imread("./image/lena.bmp");

% 添加椒盐噪声
img_sp =imnoise(img,'salt & pepper', 0.03);

% 添加高斯噪声,默认方差为0.01
img_gs =imnoise(img,'gaussian');

% 添加随机噪声
img_random = rdm_noise(img);

% 显示图像
subplot(2,4,1); imshow(img); title('原图');
subplot(2,4,2); imshow(img_sp); title('添加椒盐噪声');
subplot(2,4,3); imshow(img_gs); title('添加高斯噪声');
subplot(2,4,4); imshow(img_random); title('添加随机噪声');

% 使用均值滤波器去噪
sp_filter = mean_filter(img_sp);
gs_filter = mean_filter(img_gs);
rdm_filter = mean_filter(img_random);

% 显示图像
subplot(2,4,5); imshow(img); title('原图');
subplot(2,4,6); imshow(sp_filter); title('椒盐噪声均值滤波');
subplot(2,4,7); imshow(gs_filter); title('高斯噪声均值滤波');
subplot(2,4,8); imshow(rdm_filter); title('随机噪声均值滤波');