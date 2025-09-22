% 均值滤波
function [filter_img] = mean_filter(img)
    [r,l] = size(img);
    filter_img = img;
    for i = 2 : r - 1
        for j = 2 : l - 1
            filter_img(i,j) = mean(mean(img(i-1:i+1,j-1:j+1)));
        end
    end
end