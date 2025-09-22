function [img_random] = rdm_noise(img)
    % 设置3%的随机值脉冲噪声干扰
    % 通过椒盐噪声找点
    img_sp =imnoise(img,'salt & pepper', 0.03);
    diff = img_sp ~= img;
    % disp(diff);
    [r,l] = size(img);
    img_random = img;
    for i = 1 : r
        for j = 1 : l
            if(diff(i,j) == 1)
                img_random(i,j) = randi(256) - 1;
            end
        end
    end
end