img = imread('./image/flower1.jpg');
% 位移30个像素，角度为45度
psf = fspecial('motion',30,45);

% 产生运动模糊
motion = imfilter(img, psf, 'conv', 'circular');
% 产生高斯噪声
img_gauss = imnoise(motion, 'gaussian', 0, 0.001);

% 逆滤波恢复
inv_img = deconvwnr(motion, psf, 0);

% 维纳滤波恢复
wn_inv = deconvwnr(motion, psf);

figure();
subplot(1,4,1); imshow(img,[]); title('原图');
subplot(1,4,2); imshow(img_gauss,[]); title('运动模糊图像');
subplot(1,4,3); imshow(inv_img,[]); title('逆滤波恢复');
subplot(1,4,4); imshow(wn_inv,[]); title('维纳滤波恢复');
% 信噪比的倒数 噪声方差/信号方差
inv_img_2 = deconvwnr(img_gauss, psf, 0);
wn_inv_2 = deconvwnr(img_gauss, psf, 0.0001/ var(double(img(:))));


figure();
subplot(1,4,1); imshow(img,[]); title('原图');
subplot(1,4,2); imshow(img_gauss,[]); title('运动模糊图像');
subplot(1,4,3); imshow(inv_img_2,[]); title('加噪逆滤波恢复');
subplot(1,4,4); imshow(wn_inv_2,[]); title('加噪维纳滤波恢复');
