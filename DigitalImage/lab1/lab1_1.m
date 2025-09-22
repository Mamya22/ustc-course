
source = imread('E:\Homework\Digital Image\image\alphabet1.jpg');
tx = input('Horizontal translation amount:');
ty = input('Vertical translation amount:');
matrix = [1 0 tx; 0 1 ty; 0 0 1];
[r, c, l] = size(source);
disp(l);
out_image = zeros(r, c, l);
for i = 1 : r
    for j = 1 : c
        pixel = [i; j; 1]; % place
        pixel = matrix * pixel;
        new_x = pixel(1, 1);
        new_y = pixel(2, 1);
         if(new_x <= r) && (new_y <= c) && (new_x >= 1) && (new_y >= 1)
            for k = 1 : l
                out_image(new_x, new_y, k) = source(i, j, k);
            end
         end
    end
end
% output image
subplot(1, 2, 1); imshow(source);
subplot(1, 2, 2); imshow(uint8(out_image));

