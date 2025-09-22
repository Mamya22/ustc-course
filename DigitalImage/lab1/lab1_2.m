img = imread('E:\Homework\Digital Image\image\alphabet1.jpg');
degree = input('Input degree:');
theta= degree * pi / 180.0;
matrix_1 = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
[r, c, l] = size(img); %
a = r/2;
b = c/2; % central point
matrix_2 = [1 0 a; 0 1 b; 0 0 1];
matrix_3 = [1 0 -a; 0 1 -b; 0 0 1];
matrix = matrix_2 * matrix_1 * matrix_3;
out_image_1 = zeros(r, c, l);
out_image_2 = zeros(r, c, l);

for x = 1 : r
    for y = 1 : c
        p = [x; y; 1];
        p = matrix \ p;
        new_x = round(p(1,1));
        new_y = round(p(2,1));
        if(new_x>=1) && (new_x <= r) && (new_y >= 1) && (new_y <= c)
            for k = 1 : l
                out_image_1(x, y, k) = img(new_x, new_y, k);
            end
        end
    end
end

for x = 1 : r
     for y = 1 : c
        p = [x; y; 1];
        p = matrix \ p;
        x1 = floor(p(1,1));
        y1 = floor(p(2,1));
        dx = p(1,1) - x1;
        dy = p(2,1) - y1;
        if(p(1,1)>=1) && (p(1,1) <= r-1) && (p(2,1) >= 1) && (p(2,1) <= c-1)
            for k = 1 : l
                Q1 = img(x1, y1, k);
                Q2 = img(x1, y1+1, k);
                Q3 = img(x1+1, y1, k);
                Q4 = img(x1+1, y1+1, k);
                val = Q1 * (1-dx) * (1-dy) + Q2 * (1-dx) * dy + Q3 * dx * (1-dy) + Q4 * dx * dy;
                out_image_2(x, y, k) = val;
            end
        end
     end
end
subplot(1,2,1);imshow(uint8(out_image_1));
subplot(1,2,2);imshow(uint8(out_image_2));
