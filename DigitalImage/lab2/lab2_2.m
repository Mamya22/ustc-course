% 灰度拉伸
x1 = input("x1:");
y1 = input("y1:");
x2 = input("x2:");
y2 = input("y2:");

img = imread("./image/lena.bmp");
[r,c] = size(img);
out_img = zeros(r,c);

for i = 1 : r
    for j = 1 : c
        if (img(i,j) < x1)
            out_img(i,j) = y1/x1 * img(i,j);
        elseif(img(i,j) > x2)
            out_img(i,j) = (255 - y2) / (255 - x2) * (img(i,j) - x2) + y2;
        else
            out_img(i,j) = (y2 - y1) / (x2 - x1) * (img(i,j) - x1) + y1;
        end
    end
end

subplot(1,2,1); imshow(img);
subplot(1,2,2); imshow(uint8(out_img));