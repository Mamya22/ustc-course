img = imread('./image/lena.bmp');
threshold = graythresh(img);
T = OSTU(img);
disp(T/255);
disp(threshold);
subplot(1,3,1); imshow(img); title('原图');
subplot(1,3,2); imshow(imbinarize(img, T/255)); title('OSTU分割结果');
subplot(1,3,3); imshow(imbinarize(img, graythresh(img))); title('分割结果');
function [T] = OSTU(img)
    [r, l] = size(img);
    N = r * l;
    g = zeros(256,1);  
    p = zeros(256, 1);
    % 计算概率
    for i = 0 : 255
        p(i+1) = length(find(img == i)) / N;
    end

    mu = sum((0:255)' .* p);  % 总的平均灰度
    w0 = 0;
    u0 = 0;
    for i = 0 : 255
        w0 = w0 + p(i+1); % 计算概率
        if w0 == 0 || w0 == 1
            g(i+1) = 0;
            continue;
        end

        w1 = 1 - w0;
        u0 = u0 + i * p(i+1);
        u1 = (mu - u0) / w1;
        g(i+1) = w0 * w1 * ((u0 / w0 - u1).^2);
    end
    [~, T] = max(g);
    T = T - 1;
end

