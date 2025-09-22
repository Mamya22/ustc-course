% 中值滤波去噪
function [filter_img] = mid_filter(img)
    [r,l] = size(img);
    filter_img = img;
    for i = 2 : r - 1
        for j = 2 : l - 1
            A = img(i-1:i+1,j-1:j+1);
            mid  = median(A,"all");
            filter_img(i,j) = mid;
        end
    end    
end
