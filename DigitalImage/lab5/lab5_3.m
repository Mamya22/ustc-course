%{
四叉树分裂后，每个块的边界用白色线条标出。
通过合并灰度差异较小的相邻块，边界重新绘制后得到更合理的分割效果。
%}

img = imread('./image/cameraman.bmp');
subplot(1,3,1); imshow(img); title('原图'); 
threshold = 0.45;   % 设置四叉树分割阈值
% 极差大于 threshold 的块会被分裂，最小块为 2×2
tree = qtdecomp(img,threshold,2); % 四叉树分割  最小块 2x2
blocks = zeros(size(tree)); % 分块信息

%产生分块边界
for dim = [128 64 32 16 8 4 2]
	numblocks = length(find(tree==dim)); % 找出所有大小为dim的块数量 
	if (numblocks > 0)     
        % 创建边界值为1， 内部为0 的三维数组   
        values = repmat(uint8(1),[dim dim numblocks]);
        values(2:dim,2:dim,:) = 0; % 除去左上角均设为0
        
        % 将这个块边界值赋给 blocks 矩阵对应的位置
        blocks = qtsetblk(blocks,tree,dim,values);
  end
end

%产生分裂图
output1 = img;
output1(blocks==1) = 255; % 边界像素点置为255，突出显示块边界

%将各块分别标记
% qtsetblk 函数的机制决定了它是以 左上角坐标 来定位每个块的
i = 0;
for dim = [128 64 32 16 8 4 2]
    [vals,r,c] = qtgetblk(img,tree,dim);  % 获取所有大小为 dim 的块的像素块及其起始坐标
    % 存在
    if ~isempty(vals)
        for j = 1:length(r) % 标记块，重新赋值
            i = i + 1; 
            blocks(r(j):r(j)+ dim - 1,c(j):c(j)+ dim - 1) = i;
        end
    end
end

%将极差较小的块的标记合并
for j = 1 : i
    % 找出块 j 的边界像素且这些边界像素邻接的其他块编号
    % 既是边界临界像素也是区域外像素，则找到了边界
    bound = boundarymask(blocks==j,4) & (~(blocks==j));
    [r,l] = find(bound==1); % 找到这些边界像素的坐标
    for k = 1 : size(r,1)
        % 合并
        merge = img((blocks==j) | (blocks==blocks(r(k),l(k))));
        % 计算合并后块的极差
        if(range(merge(:))<threshold*256)
            blocks(blocks==blocks(r(k),l(k))) = j;
        end
    end
end

%根据标记重新分割
output2 = img;
for i = 1 : 255
    for j = 1 : 255
        if(blocks(i,j)~=blocks(i,j+1) || blocks(i,j)~=blocks(i+1,j))
            output2(i,j) = 255;
        end
    end
end
subplot(1,3,2); imshow(output1); title('分裂后图像'); 
subplot(1,3,3); imshow(output2); title('合并后图像'); 