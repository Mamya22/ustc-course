img = imread('E:\Homework\Digital Image\image\alphabet1.jpg');
c = input('y:');
d = input('x:');
matrix = [c 0 0; 0 d 0; 0 0 1];
[length,width , h] = size(img); 
newl = round(c*length);
neww = round(d*width);
out_image_1 = zeros(newl, neww, h);
out_image_2 = zeros(newl, neww, h);

for x = 1 : newl
    for y = 1 : neww
        p = [x; y; 1];
        p = matrix \ p;
        new_x = round(p(1,1));
        new_y = round(p(2,1));
        if(new_x>=1) && (new_x <= length) && (new_y >= 1) && (new_y <= width)
            for k = 1 : h
                out_image_1(x, y, k) = img(new_x, new_y, k);
            end
        end
    end
end

for x = 1 : newl
     for y = 1 : neww
        p = [x; y; 1];
        p = matrix \ p;
        x1 = floor(p(1,1));
        y1 = floor(p(2,1));
        dx = p(1,1) - x1;
        dy = p(2,1) - y1;
        if(p(1,1)>=0) && (p(1,1) <= length) && (p(2,1) >= 0) && (p(2,1) <= width)
            x3 = x1 + 1;
            y3 = y1 + 1;
            if(x1 >= length)
                x3 = length;
            end
            if(y1 >= width)
                y3 = width;
            end
            if(x1 == 0)
                x1 = 1;
            end
            if(y1 == 0)
                y1 = 1;
            end
            for k = 1 : h
                Q1 = img(x1, y1, k);
                Q2 = img(x1, y3, k);
                Q3 = img(x3, y1, k);
                Q4 = img(x3, y3, k);
                val = Q1 * (1-dx) * (1-dy) + Q2 * (1-dx) * dy + Q3 * dx * (1-dy) + Q4 * dx * dy;
                out_image_2(x, y, k) = val;
            end
        end
     end
end

subplot(1,2,1);imshow(uint8(out_image_1));
subplot(1,2,2);imshow(uint8(out_image_2));
