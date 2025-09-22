% 设计频域平滑滤波器
img_1 = imread('./image/pout.bmp');
img_2 = imread('./image/Girl.bmp');
D0 = 15;
n = 3;
ILPF_img = ILPF(img_1,D0);
BLPF_img = BLPF(img_1,D0,n);
ELPF_img = ELPF(img_1,D0);

ILPF_img_2 = ILPF(img_2,D0);
BLPF_img_2 = BLPF(img_2,D0,n);
ELPF_img_2 = ELPF(img_2,D0);
% ILPF平滑作用，去除小噪声，高频分量中含大量边缘信息，发生边缘模糊
% BLPF 振铃不明显，因为滤波高低频平滑过渡 ELPF无振铃
figure();
subplot(2,4,1); imshow(img_1); title('pout原图');
subplot(2,4,2); imshow(ILPF_img,[]); title('pout理想低通滤波');
subplot(2,4,3); imshow(BLPF_img,[]); title('pout巴特沃斯低通滤波');
subplot(2,4,4); imshow(ELPF_img,[]); title('pout高斯低通滤波');

subplot(2,4,5); imshow(img_2); title('Girl原图');
subplot(2,4,6); imshow(ILPF_img_2,[]); title('Girl理想低通滤波');
subplot(2,4,7); imshow(BLPF_img_2,[]); title('Girl巴特沃斯低通滤波');
subplot(2,4,8); imshow(ELPF_img_2,[]); title('Girl高斯低通滤波');

% 应该高斯去噪最好，高斯噪声全频段分布，椒盐0或255，
figure();
img_sp_2 = imnoise(img_2, "salt & pepper", 0.03);
img_gs_2 = imnoise(img_2,"gaussian");
subplot(2,5,[1,6]);imshow(img_2);title('girl原图');
subplot(2,5,2); imshow(img_sp_2); title('girl椒盐噪声');
subplot(2,5,3); imshow(ILPF(img_sp_2,D0),[]); title('girl椒盐噪声理想低通滤波');
subplot(2,5,4); imshow(BLPF(img_sp_2,D0,n),[]); title('girl椒盐噪声巴特沃斯低通滤波');
subplot(2,5,5); imshow(ELPF(img_sp_2,D0),[]); title('girl椒盐噪声高斯低通滤波');
subplot(2,5,7); imshow(img_gs_2); title('girl高斯噪声');
subplot(2,5,8); imshow(ILPF(img_gs_2,D0),[]); title('girl高斯噪声理想低通滤波');
subplot(2,5,9); imshow(BLPF(img_gs_2,D0,n),[]); title('girl高斯噪声巴特沃斯低通滤波');
subplot(2,5,10); imshow(ELPF(img_gs_2,D0),[]); title('girl高斯噪声高斯低通滤波');

% 理想低通滤波器
function [output] = ILPF(img, D0)
    shiftF = fftshift(fft2(img));
    [r,l] = size(img);
    % 中心点
    r_mid = round(r/2);
    l_mid = round(l/2);
    % output = zeros(r,l);
    % 计算距离
    for i = 1 : r
        for j = 1 : l
            d = sqrt((i-r_mid)^2 + (j-l_mid)^2);
            h = 0;
            if d <= D0
                h = 1;
            end
            shiftF(i,j) = shiftF(i,j) * h;
        end
    end
    output = abs(ifft2(ifftshift(shiftF)));
end

function [output] = BLPF(img, D0, n)
    shiftF = fftshift(fft2(img));
    [r,l] = size(img);
    % 中心点
    r_mid = round(r/2);
    l_mid = round(l/2);
    % 计算距离
    for i = 1 : r
        for j = 1 : l
            d = sqrt((i-r_mid)^2 + (j-l_mid)^2);
            h = 1 / (1 + (d/D0)^(2*n));
            shiftF(i,j) = shiftF(i,j) * h;
        end
    end 
    output = abs(ifft2(ifftshift(shiftF)));
end
% 高斯
function [output] = ELPF(img, D0)
    shiftF = fftshift(fft2(img));
    [r,l] = size(img);
    % 中心点
    r_mid = round(r/2);
    l_mid = round(l/2);
    % 计算距离
    for i = 1 : r
        for j = 1 : l
            d = sqrt((i-r_mid)^2 + (j-l_mid)^2);
            h = exp(-(d^2/D0^2));
            shiftF(i,j) = shiftF(i,j) * h;
        end
    end 
    output = abs(ifft2(ifftshift(shiftF)));
end