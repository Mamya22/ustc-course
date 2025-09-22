% 设计频域平滑滤波器
img_1 = imread('./image/pout.bmp');
img_2 = imread('./image/Girl.bmp');
D0 = 15;
n = 3;
a = 1;
b = 0;
IHPF_img = IHPF(img_1,D0,a,b);
BHPF_img = BHPF(img_1,D0,n,a,b);
EHPF_img = EHPF(img_1,D0,a,b);
IHPF_img_2 = IHPF(img_2,D0,a,b);
BHPF_img_2 = BHPF(img_2,D0,n,a,b);
EHPF_img_2 = EHPF(img_2,D0,a,b);

figure();
subplot(2,4,1); imshow(img_1); title('pout原图');
subplot(2,4,2); imshow(uint8(IHPF_img),[]); title('pout理想高通滤波');
subplot(2,4,3); imshow(uint8(BHPF_img),[]); title('pout巴特沃斯高通滤波');
subplot(2,4,4); imshow(uint8(EHPF_img),[]); title('pout高斯高通滤波');

subplot(2,4,5); imshow(img_2); title('girl原图');
subplot(2,4,6); imshow(uint8(IHPF_img_2),[]); title('Girl理想高通滤波');
subplot(2,4,7); imshow(uint8(BHPF_img_2),[]); title('Girl巴特沃斯高通滤波');
subplot(2,4,8); imshow(uint8(EHPF_img_2),[]); title('Girl高斯高通滤波');

figure();
a = 1;
b = 0.5;
subplot(2,4,1); imshow(img_1,[]); title('Pout'); 
subplot(2,4,2); imshow(histeq(uint8(IHPF(img_1,D0,a,b)))); title('Pout理想高频-直方图'); 
subplot(2,4,3); imshow(histeq(uint8(BHPF(img_1,D0,n,a,b)))); title('Pout巴特沃斯高频-直方图'); 
subplot(2,4,4); imshow(histeq(uint8(EHPF(img_1,D0,a,b)))); title('Pout高斯高频-直方图');
subplot(2,4,6); imshow(IHPF(histeq(img_1),D0,a,b),[]); title('Pout直方图-理想高频'); 
subplot(2,4,7); imshow(BHPF(histeq(img_1),D0,n,a,b),[]); title('Pout直方图-巴特沃斯高频'); 
subplot(2,4,8); imshow(EHPF(histeq(img_1),D0,a,b),[]); title('Pout直方图-高斯高频');



function [output] = IHPF(img, D0,a,b)
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
            h = 1;
            if d <= D0
                h = 0;
            end
            h = a * h + b;
            shiftF(i,j) = shiftF(i,j) * h;
        end
    end 
    output = abs(ifft2(ifftshift(shiftF)));
end

function [output] = BHPF(img, D0, n,a,b)
    shiftF = fftshift(fft2(img));
    [r,l] = size(img);
    % 中心点
    r_mid = round(r/2);
    l_mid = round(l/2);
    % 计算距离
    for i = 1 : r
        for j = 1 : l
            d = sqrt((i-r_mid)^2 + (j-l_mid)^2);
            h = 1 / (1 + (D0/d)^(2*n));
            h = a * h + b;
            shiftF(i,j) = shiftF(i,j) * h;
        end
    end 
    output = abs(ifft2(ifftshift(shiftF)));
end
% 高斯
function [output] = EHPF(img, D0,a,b)
    shiftF = fftshift(fft2(img));
    [r,l] = size(img);
    % 中心点
    r_mid = round(r/2);
    l_mid = round(l/2);
    % 计算距离
    for i = 1 : r
        for j = 1 : l
            d = sqrt((i-r_mid)^2 + (j-l_mid)^2);
            h = exp(-(D0^2/d^2));
            h = a * h + b;
            shiftF(i,j) = shiftF(i,j) * h;
        end
    end 
    output = abs(ifft2(ifftshift(shiftF)));
end