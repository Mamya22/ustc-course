img = imread('./image/rect1.bmp');
img_2 = imread('./image/Rect2.bmp');
% [r,l] = size(img_2);
% for i = 1 : r
%     for j = 1 : l
%         if(img_2(i,j) == 2)
%             img_2(i,j) = 255;
%         end
%     end
% end
% 进行二维傅里叶变换
fft_img_1 = fft2(img);
fft_img_2 = fft2(img_2);
% 对幅度做变换
% 将低频移到中心点
shift_img_1 = fftshift(fft_img_1);
LF_img1 = log(abs(shift_img_1) + 1); %取模

shift_img_2 = fftshift(fft_img_2);
LF_img2 = log(abs(shift_img_2) + 1);

% 幅度反变换
ifft_img_1 = ifft2(abs(fft_img_1)); % abs求复数的模
ifft_img_2 = ifft2(abs(fft_img_2)); % abs求复数的模

% 相位反变换 angle

ifft_angle_1 = ifft2(10000 * exp(1i * angle(fft_img_1)));
tmp = ifft2(angle(fft_img_1));
ifft_angle_2 = ifft2(10000 * exp(1i * angle(fft_img_2)));
figure();
subplot(1,2,1);imshow(uint8(ifft_angle_1));
subplot(1,2,2);imshow(uint8(tmp));
% 共轭后反变换
ifft_conj_1= ifft2(conj(fft_img_1));
ifft_conj_2= ifft2(conj(fft_img_2));
figure();
subplot(2,6,1); imshow(img); title('原图');
subplot(2,6,2); imshow(LF_img1,[]); title('rect1幅度谱');
subplot(2,6,3); imshow(uint8(ifft_img_1)); title("rect1幅度逆变换");
subplot(2,6,4); imshow(uint8(ifft_angle_1)); title("rect1相位逆变换");
subplot(2,6,5); imshow(uint8(ifft_conj_1),[]); title("rect1傅里叶变换共轭逆变换");

subplot(2,6,7); imshow(img_2,[]); title('原图');
subplot(2,6,8); imshow(LF_img2,[]); title('rect2幅度谱');
subplot(2,6,9); imshow(uint8(ifft_img_2),[]); title("rect2幅度逆变换");
subplot(2,6,10); imshow(uint8(ifft_angle_2)); title("rect2相位逆变换");
subplot(2,6,11); imshow(uint8(ifft_conj_2),[]); title("rect2傅里叶变换共轭逆变换");
