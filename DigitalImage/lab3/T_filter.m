% 超限邻域平均法去除图像中的噪声
function [filter_img] = T_filter(img, T)
    [r,l] = size(img);
    filter_img = img;
    for i = 2 : r - 1
        for j = 2 : l - 1
            if(abs(img(i,j) - mean(mean(img(i-1:i+1,j-1:j+1)))) > T)
                filter_img(i,j) = mean(mean(img(i-1:i+1,j-1:j+1)));
            end
        end
    end    
end