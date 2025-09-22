img = imread("./image/lena.bmp");
fa = input("请输入斜率:"); %斜率
fb = input("请输入截距:"); %截距
[r, c, l] = size(img);
out_img = zeros(r, c, l);

for i = 1 : r
    for j = 1 : c
        for h = 1 : l
            out_img(i,j,h) = img(i,j,h) * fa + fb;
        end
    end
end

% 显示图片
subplot(1,2,1); imshow(img);
subplot(1,2,2); imshow(uint8(out_img));
