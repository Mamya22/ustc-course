
% 超限中值滤波去噪
function [filter_img] = mid_T_filter(img,T)
    [r,l] = size(img);
    filter_img = img;
    for i = 2 : r - 1
        for j = 2 : l - 1
            A = img(i-1:i+1,j-1:j+1);
            mid  = median(A,"all");
            if(abs(double(img(i,j)) - double(mid)) > T)
                filter_img(i,j) = mid;
            end
        end
    end    
end
